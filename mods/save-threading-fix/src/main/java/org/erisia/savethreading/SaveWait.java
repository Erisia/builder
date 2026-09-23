package org.erisia.savethreading;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.function.Function;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * RCON {@code save-wait [timeoutSeconds]}: block the calling RCON thread until every chunk
 * queued so far has been written to its region file. It is the waiting half of
 * {@code save-all flush} without doing the writes on the server thread. Intended use is
 * {@code save-off}, {@code save-all}, {@code save-wait}, snapshot, {@code save-on}.
 *
 * <p>Reflection uses production SRG names (no Minecraft classes on the compile classpath).
 */
public final class SaveWait {
    public static final String COMMAND = "save-wait";
    public static final String SUCCESS = "Save queue drained";
    public static final String FAILURE = "save-wait failed";
    private static final Logger LOGGER = LogManager.getLogger("ErisiaSaveThreading");
    private static final long DEFAULT_TIMEOUT_SECONDS = 300;
    private static final long POLL_MILLIS = 10;
    private static final long REQUEUE_NANOS = TimeUnit.SECONDS.toNanos(1);
    private static volatile Game game;

    private SaveWait() { }

    public static boolean matches(String command) {
        String[] args = split(command);
        return args.length > 0 && args[0].equals(COMMAND);
    }

    public static String refuseOnServerThread() {
        return FAILURE + ": must be sent over RCON; waiting on the server thread would stall the game";
    }

    /** @param onServerThread schedules a task on the server thread (MinecraftServer.callFromMainThread). */
    public static String run(Object server, String command,
                             Function<Callable<Object>, Future<Object>> onServerThread) {
        long start = System.nanoTime();
        String reply;
        try {
            reply = waitForDrain(server, command, onServerThread, start);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            reply = FAILURE + ": interrupted";
        } catch (Exception e) {
            LOGGER.error("save-wait failed", e);
            reply = FAILURE + ": " + e;
        }
        if (reply.startsWith(FAILURE)) LOGGER.error(reply);
        else LOGGER.info(reply);
        return reply;
    }

    private static String waitForDrain(Object server, String command, Function<Callable<Object>, Future<Object>> onServerThread,
                                       long start) throws Exception {
        String[] args = split(command);
        long timeoutSeconds = DEFAULT_TIMEOUT_SECONDS;
        if (args.length > 2) return usage();
        if (args.length == 2) {
            try { timeoutSeconds = Long.parseLong(args[1]); } catch (NumberFormatException e) { return usage(); }
            if (timeoutSeconds < 1 || timeoutSeconds > 86400) return usage();
        }
        long deadline = start + TimeUnit.SECONDS.toNanos(timeoutSeconds);
        Game g = game();

        // A dead writer thread is what hung the server on 2026-09-15; never wait on one.
        Thread writer = findThread("File IO Thread");
        if (writer == null) return FAILURE + ": File IO Thread is not running; restart the server";

        // The world list belongs to the server thread. Worlds loaded after this point hold
        // nothing from the save being waited for.
        @SuppressWarnings("unchecked")
        List<Object> loaders = (List<Object>) onServerThread.apply(() -> g.chunkLoaders(server))
                .get(Math.max(1, deadline - System.nanoTime()), TimeUnit.NANOSECONDS);

        long nextRequeue = start + REQUEUE_NANOS;
        try {
            while (true) {
                // Vanilla's waitForFinish flag: the writer skips its 10 ms sleep between chunks.
                // Re-set every poll because a concurrent waitForFinish clears it when done.
                g.setWaiting(true);
                List<Object> pending = g.pending(loaders);
                if (pending.isEmpty() && g.ioIdle()) break;
                if (!writer.isAlive()) {
                    return FAILURE + ": File IO Thread died while draining; restart the server";
                }
                long now = System.nanoTime();
                if (now - deadline > 0) {
                    return FAILURE + ": timed out after " + timeoutSeconds + " s; " + g.describe(pending)
                            + " still pending";
                }
                if (now - nextRequeue > 0 && !pending.isEmpty()) {
                    // Vanilla can strand a loader: an enqueue sees it still in the writer's list
                    // just before the writer removes it as empty. queueIO ignores loaders already
                    // queued, and like every other enqueue it must run on the server thread.
                    onServerThread.apply(() -> {
                        for (Object loader : pending) g.queue(loader);
                        return null;
                    });
                    nextRequeue = now + REQUEUE_NANOS;
                }
                Thread.sleep(POLL_MILLIS);
            }
        } finally {
            g.setWaiting(false);
        }
        long millis = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - start);
        return SUCCESS + " in " + millis + " ms (" + loaders.size() + " dimensions)";
    }

    private static String usage() {
        return FAILURE + ": usage: " + COMMAND + " [timeoutSeconds 1-86400, default " + DEFAULT_TIMEOUT_SECONDS + "]";
    }

    private static String[] split(String command) {
        String trimmed = command.trim();
        if (trimmed.startsWith("/")) trimmed = trimmed.substring(1);
        return trimmed.isEmpty() ? new String[0] : trimmed.split("\\s+");
    }

    private static Thread findThread(String name) {
        for (Thread thread : Thread.getAllStackTraces().keySet()) {
            if (thread.isAlive() && thread.getName().equals(name)) return thread;
        }
        return null;
    }

    private static Game game() throws ReflectiveOperationException {
        Game g = game;
        if (g == null) game = g = new Game();
        return g;
    }

    /** Resolved once; a missing name fails the command instead of guessing. */
    private static final class Game {
        final Object io;
        final Field writesQueued, writesDone, waiting;
        final Method queueIO;
        final Class<?> anvilLoader;
        final Field toSave, beingSaved, directory;
        final Field worlds, chunkLoader;
        final Method chunkProvider;

        Game() throws ReflectiveOperationException {
            Class<?> ioType = Class.forName("net.minecraft.world.storage.ThreadedFileIOBase");
            io = ioType.getMethod("func_178779_a").invoke(null);
            writesQueued = field(ioType, "field_75740_c");
            writesDone = field(ioType, "field_75737_d");
            waiting = field(ioType, "field_75738_e");
            queueIO = ioType.getMethod("func_75735_a", Class.forName("net.minecraft.world.storage.IThreadedFileIO"));

            anvilLoader = Class.forName("net.minecraft.world.chunk.storage.AnvilChunkLoader");
            toSave = field(anvilLoader, "field_75828_a");
            beingSaved = field(anvilLoader, "field_193415_c");
            directory = field(anvilLoader, "field_75825_d");

            Class<?> serverType = Class.forName("net.minecraft.server.MinecraftServer");
            worlds = field(serverType, "field_71305_c");
            chunkProvider = Class.forName("net.minecraft.world.WorldServer").getMethod("func_72863_F");
            chunkLoader = field(Class.forName("net.minecraft.world.gen.ChunkProviderServer"), "field_73247_e");
        }

        private static Field field(Class<?> owner, String name) throws NoSuchFieldException {
            Field field = owner.getDeclaredField(name);
            field.setAccessible(true);
            return field;
        }

        /** Server thread only. */
        Object chunkLoaders(Object server) throws ReflectiveOperationException {
            List<Object> loaders = new ArrayList<>();
            Object[] loaded = (Object[]) worlds.get(server);
            for (Object world : loaded) {
                if (world == null) continue;
                Object loader = chunkLoader.get(chunkProvider.invoke(world));
                if (anvilLoader.isInstance(loader)) loaders.add(loader);
            }
            return loaders;
        }

        List<Object> pending(List<Object> loaders) throws IllegalAccessException {
            List<Object> pending = new ArrayList<>();
            for (Object loader : loaders) {
                // Both are concurrent collections. writeNextIO adds a position to beingSaved
                // before removing it from toSave, and removes it from beingSaved only after
                // the region write. Reading in this order therefore cannot miss a write.
                if (!((Map<?, ?>) toSave.get(loader)).isEmpty()
                        || !((Collection<?>) beingSaved.get(loader)).isEmpty()) {
                    pending.add(loader);
                }
            }
            return pending;
        }

        boolean ioIdle() throws IllegalAccessException {
            // Vanilla waitForFinish's condition. Volatile fields; reflective reads are volatile.
            return writesQueued.getLong(io) == writesDone.getLong(io);
        }

        void setWaiting(boolean value) throws IllegalAccessException {
            waiting.setBoolean(io, value);
        }

        void queue(Object loader) throws ReflectiveOperationException {
            queueIO.invoke(io, loader);
        }

        String describe(List<Object> loaders) throws IllegalAccessException {
            StringBuilder out = new StringBuilder();
            for (Object loader : loaders) {
                if (out.length() > 0) out.append(", ");
                int chunks = ((Map<?, ?>) toSave.get(loader)).size() + ((Collection<?>) beingSaved.get(loader)).size();
                out.append(((File) directory.get(loader)).getName()).append(": ").append(chunks);
            }
            return (out.length() == 0 ? "no chunks, but the File IO queue is not idle" : "chunks " + out);
        }
    }
}
