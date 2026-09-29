package org.erisia.savethreadingtest;

import java.io.DataInputStream;
import java.io.File;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLServerStartedEvent;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;

/** Test-only mod. Reflection uses production SRG names without distributing game classes. */
@Mod(modid = "erisia_save_threading_tests", name = "Save threading integration tests", version = "0.1.0",
     serverSideOnly = true, acceptableRemoteVersions = "*")
public final class IntegrationTests {
    private Object server;
    private final List<String> probes = Collections.synchronizedList(new ArrayList<String>());
    private final AtomicReference<Throwable> failure = new AtomicReference<>();

    @Mod.EventHandler
    public void starting(FMLServerStartingEvent event) throws Exception {
        server = call(event, "getServer");
        Class<?> commandType = type("net.minecraft.command.ICommand");
        Object command = Proxy.newProxyInstance(commandType.getClassLoader(), new Class<?>[]{commandType},
            (proxy, method, args) -> {
                switch (method.getName()) {
                    case "func_71517_b": return "erisia-thread-probe";
                    case "func_71518_a": return "erisia-thread-probe TOKEN";
                    case "func_71514_a": case "func_184883_a": return Collections.emptyList();
                    case "func_184882_a": return true;
                    case "func_82358_a": return false;
                    case "compareTo": return 0;
                    case "toString": return "Erisia thread probe";
                    case "hashCode": return System.identityHashCode(proxy);
                    case "equals": return proxy == args[0];
                    case "func_184881_a":
                        String token = ((String[]) args[2])[0];
                        if (!(Boolean) call(server, "func_152345_ab")) {
                            failure.compareAndSet(null, new AssertionError("RCON executed off server thread"));
                        }
                        probes.add(token);
                        call(args[1], "func_145747_a", construct("net.minecraft.util.text.TextComponentString", token));
                        return null;
                    default: throw new AssertionError("Unexpected ICommand method: " + method);
                }
            });
        call(event, "registerServerCommand", command);
    }

    @Mod.EventHandler
    public void started(FMLServerStartedEvent event) throws Exception {
        // The server-thread fast path must not enqueue and wait on itself.
        check(call(server, "func_71252_i", "erisia-thread-probe inline").equals("inline"), "inline RCON reply");
        Thread suite = new Thread(() -> {
            try {
                String only = System.getProperty("erisia.test.case", "all");
                if (only.equals("all") || only.equals("dequeue")) race("dequeue", false);
                if (only.equals("all") || only.equals("write")) race("write", false);
                if (only.equals("all") || only.equals("enqueue")) race("write", true);
                if (only.equals("all") || only.equals("rcon")) rcon();
                if (only.equals("all") || only.equals("wait")) saveWait();
                if (only.equals("all") || only.equals("log")) failureLog();
                if (only.equals("all") || only.equals("load")) loadPending();
                if (failure.get() != null) throw new AssertionError("Worker failure", failure.get());
                Files.write(Paths.get("test-result.txt"), "PASS\n".getBytes(StandardCharsets.UTF_8));
                System.out.println("ERISIA TESTS PASSED");
            } catch (Throwable t) {
                t.printStackTrace();
                try {
                    Files.write(Paths.get("test-result.txt"), ("FAIL: " + t + "\n").getBytes(StandardCharsets.UTF_8));
                } catch (Exception ignored) { }
            } finally {
                try { call(server, "func_71263_m"); } catch (Exception e) { e.printStackTrace(); }
            }
        }, "Erisia test suite");
        suite.setDaemon(true);
        suite.start();
    }

    private void race(String point, boolean enqueue) throws Exception {
        File directory = new File("test-chunks/" + point + (enqueue ? "-enqueue" : "-flush"));
        check(directory.mkdirs(), "new isolated chunk directory");
        Object loader = construct("net.minecraft.world.chunk.storage.AnvilChunkLoader", directory,
                construct("net.minecraft.util.datafix.DataFixer", 1343));
        Object pos = construct("net.minecraft.util.math.ChunkPos", 0, 0);
        Object oldNbt = nbt(1);
        Object newNbt = nbt(2);
        // Populate only this test loader, without registering it with the global worker.
        // The competing consumers below execute the real transformed write/flush methods.
        Map<Object, Object> pending = pending(loader);
        pending.put(pos, oldNbt);
        Thread writer = worker("test writer", () -> call(loader, "func_75814_c"));
        RaceGate gate = new RaceGate(loader, point, writer);
        RaceGate.active = gate;
        Thread contender = worker("test contender", () -> {
            if (enqueue) call(loader, "func_75824_a", pos, newNbt);
            else call(loader, "func_75818_b");
        });
        try {
            writer.start();
            check(gate.entered.await(10, TimeUnit.SECONDS), "writer reached " + point);
            contender.start();
            long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(5);
            while (contender.isAlive() && contender.getState() != Thread.State.BLOCKED
                    && System.nanoTime() < deadline) Thread.sleep(1);
            // At dequeue the contender parks on the lock; during the disk write the lock is free and
            // flush or a newer save of the same chunk parks on its condition. Both are WAITING.
            Thread.State expected = Thread.State.WAITING;
            while (contender.isAlive() && contender.getState() != expected && System.nanoTime() < deadline) Thread.sleep(1);
            check(contender.getState() == expected,
                    (enqueue ? "enqueue" : "flush") + " must wait for in-flight " + point + ", state " + contender.getState());

            // A stalled loader must not prevent another dimension's loader from draining.
            File otherDirectory = new File(directory, "other-dimension");
            check(otherDirectory.mkdirs(), "other dimension directory");
            Object other = construct("net.minecraft.world.chunk.storage.AnvilChunkLoader", otherDirectory,
                    construct("net.minecraft.util.datafix.DataFixer", 1343));
            pending(other).put(pos, nbt(3));
            Thread independent = worker("other loader", () -> call(other, "func_75818_b"));
            independent.start();
            join(independent);
        } finally {
            gate.release.countDown();
            join(writer);
            if (contender.getState() != Thread.State.NEW) join(contender);
            RaceGate.active = null;
        }
        call(loader, "func_75818_b");
        Object io = call(type("net.minecraft.world.storage.ThreadedFileIOBase"), "func_178779_a");
        Thread drain = worker("waitForFinish", () -> call(io, "func_75734_a"));
        drain.start();
        join(drain);
        check(pending.isEmpty(), "pending chunks drained");
        // Read through the actual region file/NBT reader, after flush and global queue drain.
        try (DataInputStream input = (DataInputStream) call(type("net.minecraft.world.chunk.storage.RegionFileCache"),
                "func_76549_c", directory, 0, 0)) {
            check(input != null, "chunk exists on disk");
            Object saved = call(type("net.minecraft.nbt.CompressedStreamTools"), "func_74794_a", input);
            check(call(saved, "func_74762_e", "revision").equals(enqueue ? 2 : 1), "latest NBT persisted");
        }
        check(Thread.getAllStackTraces().keySet().stream().anyMatch(t -> t.isAlive() && t.getName().equals("File IO Thread")),
                "File IO Thread remains alive");
        if (failure.get() != null) throw new AssertionError("Worker failed", failure.get());
        System.out.println("PASS race " + point + (enqueue ? " / newer save" : " / flush"));
    }

    private void rcon() throws Exception {
        List<Thread> clients = new ArrayList<>();
        CountDownLatch start = new CountDownLatch(1);
        for (int i = 0; i < 32; i++) {
            final String token = "reply-" + i;
            Thread client = worker("test RCON " + i, () -> {
                check(start.await(5, TimeUnit.SECONDS), "RCON start gate");
                check(call(server, "func_71252_i", "erisia-thread-probe " + token).equals(token), "isolated reply " + token);
            });
            clients.add(client);
            client.start();
        }
        start.countDown();
        for (Thread client : clients) join(client);
        check(probes.size() == 33, "every command executed exactly once");
        if (failure.get() != null) throw new AssertionError("RCON worker failure", failure.get());
        for (int i = 0; i < 3; i++) {
            try {
                call(server, "func_71252_i", "save-off");
                String reply = (String) call(server, "func_71252_i", "save-all flush");
                check(reply.contains("Saved the world"), "save-all flush completed: " + reply);
            } finally {
                call(server, "func_71252_i", "save-on");
            }
        }
        if (failure.get() != null) throw new AssertionError("RCON worker failure", failure.get());
        System.out.println("PASS RCON affinity, concurrent responses and save-all flush");
    }

    private void saveWait() throws Exception {
        Object world = ((Object[]) get(server, "field_71305_c"))[0];
        Object loader = get(call(world, "func_72863_F"), "field_73247_e");
        File region = (File) get(loader, "field_75825_d");
        call(type("net.minecraft.world.storage.ThreadedFileIOBase"), "func_178779_a"); // starts the thread
        Thread fileIo = Thread.getAllStackTraces().keySet().stream()
                .filter(t -> t.isAlive() && t.getName().equals("File IO Thread")).findFirst().orElse(null);
        check(fileIo != null, "File IO Thread running");
        Object inline = ((java.util.concurrent.Future<?>) call(server, "func_175586_a",
                (java.util.concurrent.Callable<Object>) () -> call(server, "func_71252_i", "save-wait"))).get(5, TimeUnit.SECONDS);
        check(((String) inline).startsWith("save-wait failed: must be sent over RCON"),
                "save-wait refuses to block the server thread: " + inline);
        try {
            call(server, "func_71252_i", "save-off");
            String saved = (String) call(server, "func_71252_i", "save-all");
            check(saved.contains("Saved the world"), "save-all completed: " + saved);
            String first = (String) call(server, "func_71252_i", "save-wait 30");
            check(first.startsWith("Save queue drained"), "save-wait drains save-all: " + first);
            // The queue is now empty, so the gate below catches the marker write only. A gate on
            // another chunk would hold the loader lock and block the marker's server-thread enqueue.

            // Pause the real File IO Thread just before it writes a marker chunk to disk.
            RaceGate gate = gateWrite(loader, fileIo, 1000, 7);
            String[] reply = new String[1];
            Thread waiter = worker("test save-wait", () -> reply[0] = (String) call(server, "func_71252_i", "save-wait 30"));
            try {
                waiter.start();
                int ticks = (Integer) call(server, "func_71259_af");
                Thread.sleep(500);
                check(waiter.isAlive(), "save-wait must wait for an in-flight write: " + reply[0]);
                check((Integer) call(server, "func_71259_af") > ticks, "server keeps ticking during save-wait");
                check(call(server, "func_71252_i", "erisia-thread-probe during-wait").equals("during-wait"),
                        "other RCON commands run during save-wait");
            } finally {
                gate.release.countDown();
            }
            join(waiter);
            check(reply[0] != null && reply[0].startsWith("Save queue drained"), "save-wait succeeded: " + reply[0]);
            check(revisionOnDisk(region, 1000) == 7, "marker chunk on disk when save-wait returns");

            gate = gateWrite(loader, fileIo, 1001, 8);
            long start = System.nanoTime();
            try {
                String timedOut = (String) call(server, "func_71252_i", "save-wait 1");
                long millis = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - start);
                check(timedOut.startsWith("save-wait failed: timed out"), "save-wait timeout reported: " + timedOut);
                check(millis >= 1000 && millis < 5000, "save-wait timeout bounded: " + millis + " ms");
            } finally {
                gate.release.countDown();
            }
            String drained = (String) call(server, "func_71252_i", "save-wait 30");
            check(drained.startsWith("Save queue drained"), "save-wait after timeout: " + drained);
            check(revisionOnDisk(region, 1001) == 8, "second marker on disk");
            check(((String) call(server, "func_71252_i", "save-wait x")).startsWith("save-wait failed: usage"),
                    "bad timeout rejected");
        } finally {
            RaceGate.active = null;
            call(server, "func_71252_i", "save-on");
        }
        check(fileIo.isAlive(), "File IO Thread remains alive");
        if (failure.get() != null) throw new AssertionError("save-wait worker failure", failure.get());
        System.out.println("PASS save-wait waits off the server thread");
    }

    /** Enqueue a marker chunk as the server does (on its thread) and hold the writer before its disk write. */
    private RaceGate gateWrite(Object loader, Thread fileIo, int x, int revision) throws Exception {
        RaceGate gate = new RaceGate(loader, "write", fileIo);
        RaceGate.active = gate;
        Object pos = construct("net.minecraft.util.math.ChunkPos", x, x);
        Object nbt = nbt(revision);
        ((java.util.concurrent.Future<?>) call(server, "func_175586_a",
                (java.util.concurrent.Callable<Object>) () -> call(loader, "func_75824_a", pos, nbt))).get(5, TimeUnit.SECONDS);
        check(gate.entered.await(5, TimeUnit.SECONDS), "File IO Thread reached disk write");
        return gate;
    }

    private static int revisionOnDisk(File directory, int x) throws Exception {
        try (DataInputStream input = (DataInputStream) call(type("net.minecraft.world.chunk.storage.RegionFileCache"),
                "func_76549_c", directory, x, x)) {
            check(input != null, "chunk " + x + " exists on disk");
            Object saved = call(type("net.minecraft.nbt.CompressedStreamTools"), "func_74794_a", input);
            return (Integer) call(saved, "func_74762_e", "revision");
        }
    }

    private static Object get(Object target, String name) throws Exception {
        for (Class<?> c = target.getClass(); c != null; c = c.getSuperclass()) {
            try {
                Field field = c.getDeclaredField(name);
                field.setAccessible(true);
                return field.get(target);
            } catch (NoSuchFieldException ignored) { }
        }
        throw new NoSuchFieldException(target.getClass().getName() + "." + name);
    }

    private Thread worker(String name, Checked action) {
        Thread thread = new Thread(() -> {
            try { action.run(); } catch (Throwable t) { t.printStackTrace(); failure.compareAndSet(null, t); }
        }, name);
        thread.setDaemon(true);
        return thread;
    }

    private static void join(Thread thread) throws InterruptedException {
        thread.join(10000);
        check(!thread.isAlive(), "bounded completion of " + thread.getName());
    }

    // A load must neither read the stale disk copy during an in-flight write nor share a queued compound.
    private void loadPending() throws Exception {
        File directory = new File("test-chunks/load");
        check(directory.mkdirs(), "new isolated chunk directory");
        Object loader = construct("net.minecraft.world.chunk.storage.AnvilChunkLoader", directory,
                construct("net.minecraft.util.datafix.DataFixer", 1343));
        Object world = ((Object[]) get(server, "field_71305_c"))[0];
        // A real chunk compound, serialised on the server thread like vanilla's saveChunk.
        Object template = ((java.util.concurrent.Future<?>) call(server, "func_175586_a",
                (java.util.concurrent.Callable<Object>) () -> {
                    Object root = construct("net.minecraft.nbt.NBTTagCompound");
                    Object level = construct("net.minecraft.nbt.NBTTagCompound");
                    call(root, "func_74782_a", "Level", level);
                    call(loader, "func_75820_a", call(world, "func_72964_e", 0, 0), world, level);
                    return root;
                })).get(5, TimeUnit.SECONDS);
        Object pos = construct("net.minecraft.util.math.ChunkPos", 0, 0);
        Map<Object, Object> pending = pending(loader);
        pending.put(pos, revision(template, 1));
        call(loader, "func_75818_b");

        pending.put(pos, revision(template, 2));
        Thread writer = worker("test writer", () -> call(loader, "func_75814_c"));
        RaceGate gate = new RaceGate(loader, "write", writer);
        RaceGate.active = gate;
        Object[][] loaded = new Object[1][];
        Thread reader = worker("test load", () -> loaded[0] = (Object[]) call(loader, "loadChunk__Async", world, 0, 0));
        Object other = construct("net.minecraft.util.math.ChunkPos", 5, 5);
        Thread otherSave = worker("test other save", () -> call(loader, "func_75824_a", other, revision(template, 9)));
        try {
            writer.start();
            check(gate.entered.await(10, TimeUnit.SECONDS), "writer reached disk write");
            // The disk write is still held: neither a load of that chunk nor a save of another may wait for it.
            reader.start();
            join(reader);
            otherSave.start();
            join(otherSave);
            check(pending.containsKey(other), "save of another chunk queued during the write");
        } finally {
            gate.release.countDown();
            join(writer);
            if (reader.getState() != Thread.State.NEW) join(reader);
            RaceGate.active = null;
        }
        check(loaded[0] != null && call(loaded[0][1], "func_74762_e", "revision").equals(2),
                "load during the write sees the in-flight revision, not the stale disk copy");
        call(loaded[0][1], "func_74768_a", "XU2Generation", 1);
        Object[] afterWrite = (Object[]) call(loader, "loadChunk__Async", world, 0, 0);
        check(!(Boolean) call(afterWrite[1], "func_74764_b", "XU2Generation"), "load did not share the in-flight compound");
        check(call(afterWrite[1], "func_74762_e", "revision").equals(2), "written revision on disk");

        Object queued = revision(template, 3);
        pending.put(pos, queued);
        Object[] fromQueue = (Object[]) call(loader, "loadChunk__Async", world, 0, 0);
        check(fromQueue != null && call(fromQueue[1], "func_74762_e", "revision").equals(3), "load sees the queued revision");
        check(fromQueue[1] != queued, "load must not share the queued compound");
        call(fromQueue[1], "func_74768_a", "XU2Generation", 1);
        check(!(Boolean) call(queued, "func_74764_b", "XU2Generation"), "Load handlers cannot mutate the queued compound");
        call(loader, "func_75818_b");
        check(pending.isEmpty(), "pending chunks drained");
        if (failure.get() != null) throw new AssertionError("load worker failure", failure.get());
        System.out.println("PASS load reads in-flight/queued NBT copies without waiting for the disk write");
    }

    private static Object revision(Object template, int revision) throws Exception {
        Object nbt = call(template, "func_74737_b");
        call(nbt, "func_74768_a", "revision", revision);
        return nbt;
    }

    // Null NBT makes the real writeChunkData throw: the failure must be logged with its chunk and rethrown.
    private void failureLog() throws Exception {
        File directory = new File("test-chunks/failure-log");
        check(directory.mkdirs(), "new isolated chunk directory");
        Object loader = construct("net.minecraft.world.chunk.storage.AnvilChunkLoader", directory,
                construct("net.minecraft.util.datafix.DataFixer", 1343));
        Method write = null;
        for (Method m : loader.getClass().getDeclaredMethods()) {
            if (m.getName().equals("func_183013_b")) write = m;
        }
        check(write != null, "writeChunkData exists");
        write.setAccessible(true);
        Throwable thrown = null;
        try {
            write.invoke(loader, construct("net.minecraft.util.math.ChunkPos", 5, -7), null);
        } catch (InvocationTargetException e) {
            thrown = e.getCause();
        }
        check(thrown instanceof NullPointerException, "write failure is rethrown unchanged, got " + thrown);
        String expected = "Failed to write chunk [5, -7] in " + directory;
        long deadline = System.nanoTime() + TimeUnit.SECONDS.toNanos(5);
        while (!new String(Files.readAllBytes(Paths.get("logs/latest.log")), StandardCharsets.UTF_8).contains(expected)) {
            check(System.nanoTime() < deadline, "log names the failed chunk: " + expected);
            Thread.sleep(50);
        }
    }

    private static Object nbt(int revision) throws Exception {
        Object nbt = construct("net.minecraft.nbt.NBTTagCompound");
        call(nbt, "func_74768_a", "revision", revision);
        return nbt;
    }

    @SuppressWarnings("unchecked")
    private static Map<Object, Object> pending(Object loader) throws Exception {
        Field field = loader.getClass().getDeclaredField("field_75828_a");
        field.setAccessible(true);
        return (Map<Object, Object>) field.get(loader);
    }

    private static Class<?> type(String name) throws ClassNotFoundException { return Class.forName(name); }

    private static Object construct(String name, Object... args) throws Exception {
        for (Constructor<?> constructor : type(name).getConstructors()) {
            if (matches(constructor.getParameterTypes(), args)) return constructor.newInstance(args);
        }
        throw new NoSuchMethodException(name + " constructor");
    }

    private static Object call(Object target, String name, Object... args) throws Exception {
        Class<?> start = target instanceof Class<?> ? (Class<?>) target : target.getClass();
        for (Class<?> c = start; c != null; c = c.getSuperclass()) {
            for (Method method : c.getDeclaredMethods()) {
                if (method.getName().equals(name) && matches(method.getParameterTypes(), args)) {
                    method.setAccessible(true);
                    try { return method.invoke(target instanceof Class<?> ? null : target, args); }
                    catch (InvocationTargetException e) {
                        if (e.getCause() instanceof Error) throw (Error) e.getCause();
                        throw (Exception) e.getCause();
                    }
                }
            }
        }
        throw new NoSuchMethodException(start.getName() + "." + name);
    }

    private static boolean matches(Class<?>[] params, Object[] args) {
        if (params.length != args.length) return false;
        for (int i = 0; i < params.length; i++) {
            if (args[i] != null && !params[i].isInstance(args[i])
                    && !(params[i] == int.class && args[i] instanceof Integer)) return false;
        }
        return true;
    }

    private static void check(boolean condition, String message) {
        if (!condition) throw new AssertionError(message);
    }

    private interface Checked { void run() throws Exception; }
}
