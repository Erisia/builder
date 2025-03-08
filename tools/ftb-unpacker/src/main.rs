use std::fmt::Display;
use std::io::Write;
use std::ops::Add;
use std::path::{Path, PathBuf};

use clap::Parser;
use color_eyre::eyre::{ContextCompat, Result, WrapErr};
use indicatif::ProgressBar;
use serde::{Deserialize, Serialize};
use tracing::{Level, event, span};
use tracing_subscriber::EnvFilter;
use url::Url;

/// Base URL for the modpack API.
///
/// The 0 included as the penultimate path segment is supposed to be the API key,
/// at time of writing this does not appear to be validated.
static BASE_URL: &str = "https://api.feed-the-beast.com/v1/modpacks/0/modpack/";

fn main() -> Result<()> {
    color_eyre::install()?;
    if let Ok(level) = std::env::var("FTB_LOG") {
        tracing_subscriber::fmt()
            .with_env_filter(EnvFilter::new(&format!(
                "{}={level}",
                env!("CARGO_PKG_NAME").replace("-", "_")
            )))
            .init();
    } else {
        tracing_subscriber::fmt()
            .with_env_filter(EnvFilter::new("INFO"))
            .init();
    }
    let cli = Cli::parse();

    let base_url: Url = Url::parse(BASE_URL).wrap_err("Failed to parse hardcoded base URL")?;
    let final_url: Url = base_url.join(&format!("{}/{}", cli.pack_id, cli.version_id))?;

    event!(Level::INFO, "Calling FTB URL {}", final_url.as_str());

    let response = reqwest::blocking::get(final_url)
        .wrap_err("Failed to request pack info")?
        .text()
        .wrap_err("Failed to receive pack info from server")?;
    let pack_info: FtbPack =
        serde_json::from_str(&response).wrap_err("Failed to parse pack info as JSON")?;
    event!(Level::INFO, "Successfully retrieved FTB pack info");
    event!(Level::TRACE, "Pack JSON: {:?}", pack_info);

    let download_targets = generate_download_targets(&pack_info.files, &cli.iteration_name)
        .wrap_err("Failed to generate list of files to download")?;

    let output_dir = cli.base.unwrap_or(PathBuf::from("base"));
    if !cli.dry_run {
        do_file_downloads(&download_targets, &output_dir)?;
    } else {
        event!(
            Level::INFO,
            "Dry run, skipping download of {} files to base directory {:?}",
            download_targets.len(),
            output_dir
        );
        for download_target in &download_targets {
            event!(
                Level::TRACE,
                "Dry run, skipping download of {:?} from {}",
                download_target.0,
                download_target.1
            );
        }
    }

    let mmmm_modlist = generate_mmmm_modlist(&pack_info.files);
    let output_path = cli
        .manifest
        .unwrap_or(PathBuf::from("manifest"))
        .join(cli.iteration_name.clone().add("-mods.yaml"));
    if !cli.dry_run {
        do_manifest_output(&mmmm_modlist, &output_path)?;
    }

    Ok(())
}

fn do_file_downloads(
    download_targets: &Vec<(PathBuf, Url, Hashes)>,
    output_dir: &PathBuf,
) -> Result<()> {
    event!(
        Level::INFO,
        "Downloading {} files to base directory {:?}",
        download_targets.len(),
        output_dir
    );
    let bar = ProgressBar::new(download_targets.len() as u64);
    for download_target in download_targets {
        let _span = span!(
            Level::TRACE,
            "file_download",
            file = download_target.0.display().to_string()
        )
        .entered();
        event!(
            Level::TRACE,
            "Downloading {:?} from {}",
            download_target.0,
            download_target.1
        );
        let out_path = output_dir.join(&download_target.0);
        // Skip download if the destination file already exists and has a matching hash
        if sha256::try_digest(&out_path)
            .map(|digest| download_target.2.sha256 != digest)
            .unwrap_or(true)
        {
            std::fs::create_dir_all(out_path.parent().wrap_err_with(|| {
                format!("Failed to get parent of filepath {}", out_path.display())
            })?)
            .wrap_err_with(|| {
                format!("Failed to create directory for file {}", out_path.display())
            })?;
            let out_file = std::fs::File::create(&out_path).wrap_err_with(|| {
                format!("Failed to open file {} for writing", out_path.display())
            })?;
            let mut buf = std::io::BufWriter::new(out_file);
            let mut req =
                reqwest::blocking::get(download_target.1.clone()).wrap_err_with(|| {
                    format!("Failed to request file from URL {}", download_target.1)
                })?;
            req.copy_to(&mut buf)
                .wrap_err_with(|| format!("Failed to write file {} to disk", out_path.display()))?;
            buf.flush().wrap_err_with(|| {
                format!(
                    "Failed to flush buffer when writing file {} to disk",
                    out_path.display()
                )
            })?;
        }
        bar.inc(1);
    }
    bar.finish();
    event!(Level::INFO, "Finished downloading files");
    Ok(())
}

fn do_manifest_output(mods: &Vec<MMMMUrlMod>, output_path: &Path) -> Result<()> {
    let _span = span!(Level::INFO, "manifest").entered();
    event!(Level::INFO, "Writing modlist as mmmm manifest snippet to {}", output_path.display());
    std::fs::create_dir_all(
        output_path
            .parent()
            .wrap_err("Failed to get parent directory for manifest")?,
    )
    .wrap_err("Failed to create parent directory for manifest")?;
    let mut file = std::fs::File::create(output_path)?;
    let contents: String = mods
        .iter()
        .map(|m| m.to_string())
        .collect::<Vec<_>>()
        .join("\n");
    file.write(contents.as_bytes())?;
    Ok(())
}

fn generate_download_targets<'a>(
    files: &'a Vec<File>,
    iteration_name: &'a str,
) -> Result<Vec<(PathBuf, Url, Hashes<'a>)>> {
    let common_base: &Path = Path::new(&iteration_name);
    let server_base: PathBuf = PathBuf::from(format!("{}-server", iteration_name));
    let client_base: PathBuf = PathBuf::from(format!("{}-client", iteration_name));
    files
        .iter()
        // Skip files of type mod, these are downloaded separately
        .filter(|file| file.file_type != "mod")
        .map(|file| {
            // Paths from API start with ./ indicating a relative path.
            // Confirm this property of each path and strip it off if present.
            let file_path = if file.path.starts_with("./") {
                Path::new(&file.path)
                    .strip_prefix("./")
                    .wrap_err("Failed to strip ./")?
                    .join(&file.name)
            } else {
                Path::new(&file.path).join(&file.name)
            };
            // Set the download directory based on the sidedness of the file
            let download_path: PathBuf = match (file.clientonly, file.serveronly) {
                (true, false) => client_base.join(file_path),
                (false, true) => server_base.join(file_path),
                // If both or none of serveronly or clientonly are set, download to the common directory.
                // It's unclear what both being set would even mean, so this acts as a fallback in that unlikely scenario.
                _ => common_base.join(file_path),
            };
            let download_url = Url::parse(&file.url)
                .wrap_err(format!("Failed to parse download URL {}", &file.url))?;
            Ok((download_path, download_url, file.hashes.clone()))
        })
        .collect()
}

fn generate_mmmm_modlist(files: &Vec<File>) -> Vec<MMMMUrlMod> {
    files
        .iter()
        .filter(|file| file.file_type == "mod")
        .map(|file| MMMMUrlMod {
            side: match (file.clientonly, file.serveronly) {
                (true, false) => MMMMSide::Client,
                (false, true) => MMMMSide::Server,
                _ => MMMMSide::Both,
            },
            location: file.url.into(),
            filename: file.name.into(),
            // Suboptimal: setting the name field to the filename without extension
            // Unfortunately, the response from FTB does not include any kind of slug
            name: file.name.trim_end_matches(".jar").into(),
        })
        .collect()
}

/// Extract an FTB pack for the builder
#[derive(Parser, Debug)]
#[command(version, about)]
struct Cli {
    /// Pack ID
    pack_id: u32,

    /// Pack Version ID
    version_id: u32,

    /// Iteration name (i.e. e35)
    iteration_name: String,

    /// Show the actions this script would take
    #[arg(short = 'n', long, default_value_t = false)]
    dry_run: bool,

    /// Base directory where downloaded files should be stored (defaults to base)
    #[arg(short, long)]
    base: Option<PathBuf>,

    /// Directory where manifest should be written (defaults to manifest)
    #[arg(short, long)]
    manifest: Option<PathBuf>,
}

/// Top level response from FTB pack API
#[derive(Serialize, Deserialize, Debug)]
struct FtbPack<'a> {
    /// Pack version
    name: &'a str,
    /// Versions for game, loaders, Java
    #[serde(borrow)]
    targets: Vec<Target<'a>>,
    /// Included files
    #[serde(borrow)]
    files: Vec<File<'a>>,
}

/// Runtime version target
#[derive(Serialize, Deserialize, Debug)]
struct Target<'a> {
    /// Name of dependency
    name: &'a str,
    /// Version of dependency
    version: &'a str,
    /// Type, such as game, modloader, runtime
    #[serde(alias = "type")]
    dependency_type: &'a str,
}

/// Included file
#[derive(Serialize, Deserialize, Debug)]
struct File<'a> {
    path: &'a str,
    url: &'a str,
    #[serde(borrow)]
    hashes: Hashes<'a>,
    size: u32,
    clientonly: bool,
    serveronly: bool,
    name: &'a str,
    #[serde(alias = "type")]
    file_type: &'a str,
}

/// Hashes of a file
#[derive(Serialize, Deserialize, Debug, Clone)]
struct Hashes<'a> {
    sha256: &'a str,
    sha512: &'a str,
}

struct MMMMUrlMod {
    name: String,
    location: String,
    filename: String,
    side: MMMMSide,
}

impl Display for MMMMUrlMod {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "- name: '{}'\n  source: url\n  location: '{}'\n  filename: '{}'\n  side: {}",
            self.name,
            self.location,
            self.filename,
            self.side.to_string()
        )
    }
}

enum MMMMSide {
    Server,
    Client,
    Both,
}

impl Display for MMMMSide {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            MMMMSide::Client => write!(f, "client"),
            MMMMSide::Server => write!(f, "server"),
            MMMMSide::Both => write!(f, "both"),
        }
    }
}
