package org.erisia.savethreading;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/** Names the chunk behind vanilla's anonymous "Failed to save chunk". Reflection uses SRG names. */
public final class SaveFailureLog {
    private static final Logger LOGGER = LogManager.getLogger("ErisiaSaveThreading");

    private SaveFailureLog() { }

    public static void log(File saveLocation, Object pos, Object nbt, RuntimeException e) {
        LOGGER.error("Failed to write chunk {} in {}: {}; root NBT keys now: {}",
                pos, saveLocation, e, rootKeys(nbt));
    }

    // Best effort: the map may still be changing under us.
    private static String rootKeys(Object nbt) {
        try {
            Object keys = nbt.getClass().getMethod("func_150296_c").invoke(nbt);
            return new ArrayList<Object>((Collection<?>) keys).toString();
        } catch (ReflectiveOperationException | RuntimeException e) {
            return "unavailable (" + e + ")";
        }
    }
}
