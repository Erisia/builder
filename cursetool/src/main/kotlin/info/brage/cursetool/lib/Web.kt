package info.brage.cursetool.lib

import kotlinx.coroutines.experimental.CommonPool
import kotlinx.coroutines.experimental.async
import kotlinx.coroutines.experimental.delay
import org.apache.commons.codec.digest.DigestUtils
import org.apache.commons.httpclient.HttpClient
import org.apache.commons.httpclient.methods.GetMethod
import org.apache.commons.httpclient.RedirectException
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import java.nio.file.FileSystems
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardCopyOption
import java.util.*
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.Semaphore

data class PageNotFound(val url: String) : Throwable()


object DiskCache {
    private val path: Path = FileSystems.getDefault().getPath(
            System.getProperty("user.home")).resolve(".cursetool")

    private val age: ConcurrentHashMap<Path, Long> = ConcurrentHashMap()
    private val size: ConcurrentHashMap<Path, Long> = ConcurrentHashMap()

    private val max_entry_size = 100_000
    private val max_total_size = 100_000_000
    private val max_entry_age = 86400_000  // Milliseconds.

    init {
        if (Files.exists(path) && Files.isDirectory(path)) {
            println("Using ${path} for disk cache")
        } else {
            Files.createDirectories(path)
        }

        // Clean up any orphan -tmp files.
        Files.list(path)
                .filter { it.endsWith("-tmp") }
                .forEach { it.toFile().delete() }
        // And load the remainder.
        Files.list(path)
                .map { it to it.toFile() }
                .filter { it.second.isFile }
                .forEach {
                    age[it.first] = it.second.lastModified()
                    size[it.first] = it.second.length()
                }
        Runtime.getRuntime().addShutdownHook(Thread(this::gc))
        println("Loaded ${age.size} cache entries")
    }

    fun gc() {
        // TODO: Implement GC!
        println("Ran GC on ${age.size} keys, deleting 0")
    }

    fun write(url: String, value: ByteArray) {
        val (file, tmp) = paths(url)
        Files.write(tmp, value)
        Files.move(tmp, file, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING)
        age[file] = System.currentTimeMillis()
        size[file] = value.size.toLong()
    }

    suspend fun get(url: String, loader: () -> ByteArray): ByteArray {
        val now = System.currentTimeMillis()
        val (file, _) = paths(url)
        var suspendTime: Long = 8000;
        while (true) {
            try {
                if (age[file] ?: 0 < now - max_entry_age) {
                    write(url, loader())
                }
                break
            } catch (e: RedirectException) {
                if (Files.exists(file)) {
                    println("Stuck in redirect loop for ${url}, using cached value")
                    break
                } else {
                    println("Stuck in redirect loop for ${url}, but no cache. Sleeping ${suspendTime / 1000} seconds.")
                    delay(suspendTime)
                    suspendTime *= 2
                }
            }
        }
        return Files.readAllBytes(file)
    }

    private fun paths(url: String): Pair<Path, Path> {
        val key = Base64.getUrlEncoder().encodeToString(url.toByteArray())
        val file = path.resolve(key)
        val tmp = path.resolve(key + "-tmp")
        return Pair(file, tmp)
    }
}


/**
 * A generic rate-limiting browser.
 */
object Browser {
    private val limit = Semaphore(2)

    private fun getUncached(url: String): GetMethod {
        val client = HttpClient()
        val get = GetMethod(url).apply {
            addRequestHeader("User-Agent", "MCPackBuilder 2.0")
        }
        with(limit) {
            println("Fetching $url")
            val status = client.executeMethod(get)
            return when (status) {
                200 -> get
                404 -> throw PageNotFound(url)
                else -> throw Exception("Unexpected HTTP response $status: ${get.responseBodyAsString}")
            }
        }
    }

    suspend fun getCached(url: String) = DiskCache.get(url, {
        getUncached(url).responseBodyAsStream.readBytes()
    })

    suspend fun soup(url: String): Document = Jsoup.parse(String(getCached(url)))

    /**
     * Downloads and writes a file to the local filesystem. Doesn't cache.
     */
    fun download(url: String, target: String): Unit {
        if (target.contains('/'))
            throw Exception("Scary-looking filename: $target")
        val path = FileSystems.getDefault().getPath(target)
        if (Files.exists(path))
            throw Exception("Refusing to overwrite file: $path")
        println("Downloading to $path")
        val file = getUncached(url)
        Files.copy(file.responseBodyAsStream, path)
    }
}

/**
 * Represents the Curse website itself.
 */
object Curse {
    private val site = "https://minecraft.curseforge.com"

    /**
     * Fills in mod-info from Curse.
     */
    suspend fun fillModInfo(filter: String, info: ModInfo): ModInfo {
        if (!info.curse) return info

        check(info.name != null || info.id != null)
        val modUrl = "${site}/projects/${info.name ?: info.id.toString()}"
        val soup = async(CommonPool) { Browser.soup(modUrl) }
        val error = { "Failed to parse ${info.name}, at $modUrl" }
        val name = async(CommonPool) {
            val url = soup.await().select("section.atf .e-menu a").first().attr("href")
            val name = url.substringAfterLast('/')
            check(name != "", error)
            name
        }
        val id = async(CommonPool) {
            // val url = soup.await().getElementsByClass("view-on-curse").first().getElementsByTag("a").attr("href")
            // val id = Integer.parseInt(url.substringAfterLast('/'))
            val ids = soup.await().getElementsByClass("cf-details project-details").first().getElementsByClass("info-data").first().text()
            val id = Integer.parseInt(ids)
            check(id != 0, error)
            id
        }
        val title = async(CommonPool) {
            val title = soup.await().getElementsByClass("project-title").first().text()
            check(title != "", error)
            title
        }
        val files = async(CommonPool) {
            val filesUrl = "$site/projects/${name.await()}/files?$filter"
            Browser.soup(filesUrl)
                    .getElementsByClass("project-file-list-item")
                    .map {
                        val fileContainer = it.getElementsByClass("project-file-name-container")
                                .first()
                                .getElementsByAttributeValue("data-action", "file-link")
                                .singleOrNull()
                        check(fileContainer != null, { "Failed to parse files page, $filesUrl" })
                        val fileName = fileContainer!!.attr("data-name")
                        val url = site + fileContainer.attr("href")
                        val releaseContainer = it.getElementsByClass("project-file-release-type").single()
                        val maturity = if (releaseContainer.select(".release-phase").isNotEmpty()) Maturity.release
                        else if (releaseContainer.select(".beta-phase").isNotEmpty()) Maturity.beta
                        else if (releaseContainer.select(".alpha-phase").isNotEmpty()) Maturity.alpha
                        else throw Exception("Unknown maturity")
                        FileInfo(
                                name = fileName,
                                maturity = maturity,
                                filePageUrl = url
                        )
                    }
        }
        val deps = async(CommonPool) {
            val depsUrl = "$site/projects/${name.await()}/relations/dependencies?filter-related-dependencies=3"
            Browser.soup(depsUrl)
                    .getElementsByClass("project-list-item")
                    .map {
                        val url = it.getElementsByClass("avatar").single().getElementsByTag("a").attr("href")
                        url.substringAfterLast('/')
                    }
                    .toSet()
        }

        return info.copy(
                name = name.await(),
                title = title.await(),
                id = id.await(),
                files = files.await(),
                side = info.side,
                deps = deps.await()
        )
    }

    suspend fun fillFileInfo(basePath: Path, info: FileInfo): FileInfo {
        if (info.filePageUrl != null) {
            // We're on curse.
            val page = Browser.soup(info.filePageUrl)
            return info.copy(
                    src = Curse.site + page.select(".project-file-download-container a").attr("href"),
                    md5 = page.select(".md5").single().text(),
                    name = page.select(".details-info .info-data").first().text()
            )
        } else {
            // Not Curse. We'll need to grab the actual file.
            val bytes: ByteArray = if (info.src!!.startsWith("http")) {
                Browser.getCached(info.src)
            } else {
                // Local file, I guess.
                Files.readAllBytes(basePath.resolveSibling(info.src))
            }
            return info.copy(
                    md5 = DigestUtils.md5Hex(bytes)
            )
        }
    }

    suspend fun getFileInfo(projectId: Int, fileId: Int): FileInfo {
        val url = "${site}/projects/$projectId/files/$fileId"
        val page = Browser.soup(url)
        return FileInfo(
                src = site + page.select(".project-file-download-container a").attr("href"),
                md5 = page.select(".md5").single().text(),
                name = page.select(".details-info > ul .info-data").first().text(),
                filePageUrl = url,
                id = fileId
        )
    }

    fun download(file: FileInfo): Unit {
        Browser.download(file.src!!, file.name!!)
    }

    fun filterVersion(minecraft: String) = when (minecraft) {
        "1.7" -> "filter-game-version=2020709689%3A4449"
        "1.7.10" -> "filter-game-version=2020709689%3A4449"
        "1.8.9" -> "filter-game-version=2020709689%3A5806"
        "1.9" -> "filter-game-version=2020709689%3A5946"
        "1.9.4" -> "filter-game-version=2020709689%3A6084"
        "1.10" -> "filter-game-version=2020709689%3A6144"
        "1.10.1" -> "filter-game-version=2020709689%3A6160"
        "1.10.2" -> "filter-game-version=2020709689%3A6170"
        "1.11.2" -> "filter-game-version=2020709689%3A6452"
        "1.12" -> "filter-game-version=1738749986%3A628"
        "1.12.1" -> "filter-game-version=2020709689%3A6711"
        "1.12.2" -> "filter-game-version=2020709689%3A6756"
        else -> throw Exception("Minecraft version $minecraft not known, add to Web.kt.")
    }
}
