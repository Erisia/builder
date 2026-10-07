package org.erisia.savethreading;

import java.io.ByteArrayOutputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Replacement for vanilla {@code CompressedStreamTools.write(NBTTagCompound, File)}, which wraps a bare
 * FileOutputStream in a DataOutputStream: one write() syscall per tag field, on whatever thread calls it.
 * Astral Sorcery saves its 170 KB lightnetwork.dat this way at every autosave, ~32k syscalls and ~200 ms
 * of server-thread time.
 *
 * Here the compound is serialised into memory first (same bytes, same uncompressed format), then written
 * to a sibling temporary file in one go and renamed over the target. A crash mid-write leaves the old
 * file intact instead of a truncated one. Like vanilla, there is no fsync.
 */
public final class NbtFileWrite {
    private static final Logger LOGGER = LogManager.getLogger("ErisiaSaveThreading");
    private static volatile Method writeToDataOutput;
    private static volatile boolean unavailable;

    private NbtFileWrite() {}

    /** Returns false if the vanilla method should run instead (reflection unavailable). */
    public static boolean write(Object compound, File file) throws IOException {
        Method write = resolve();
        if (write == null) return false;
        ByteArrayOutputStream bytes = new ByteArrayOutputStream(16 * 1024);
        try (DataOutputStream out = new DataOutputStream(bytes)) {
            write.invoke(null, compound, out);
        } catch (InvocationTargetException e) {
            Throwable cause = e.getCause();
            if (cause instanceof IOException) throw (IOException) cause;
            if (cause instanceof RuntimeException) throw (RuntimeException) cause;
            if (cause instanceof Error) throw (Error) cause;
            throw new IOException(cause);
        } catch (IllegalAccessException e) {
            throw new IOException(e);
        }
        Path target = file.toPath();
        // Per-thread name: concurrent writers of the same file must not share a temporary file.
        Path tmp = target.resolveSibling(target.getFileName() + ".erisia-" + Thread.currentThread().getId() + ".tmp");
        try {
            Files.write(tmp, bytes.toByteArray());
            try {
                Files.move(tmp, target, StandardCopyOption.ATOMIC_MOVE);
            } catch (AtomicMoveNotSupportedException e) {
                Files.move(tmp, target, StandardCopyOption.REPLACE_EXISTING);
            }
        } finally {
            Files.deleteIfExists(tmp);
        }
        return true;
    }

    private static Method resolve() {
        Method m = writeToDataOutput;
        if (m != null || unavailable) return m;
        try {
            Class<?> tools = Class.forName("net.minecraft.nbt.CompressedStreamTools");
            Class<?> compound = Class.forName("net.minecraft.nbt.NBTTagCompound");
            // write(NBTTagCompound, DataOutput)
            m = tools.getMethod("func_74800_a", compound, DataOutput.class);
            writeToDataOutput = m;
            return m;
        } catch (ReflectiveOperationException | RuntimeException e) {
            unavailable = true;
            LOGGER.error("Buffered NBT file write unavailable, using vanilla unbuffered write", e);
            return null;
        }
    }
}
