package org.erisia.savethreading;

import java.lang.reflect.Method;

/** Deep-copies a queued chunk compound (NBTTagCompound.copy, SRG func_74737_b). */
public final class PendingCopy {
    private static volatile Method copy;

    private PendingCopy() { }

    public static Object copy(Object nbt) {
        if (nbt == null) return null;
        try {
            Method m = copy;
            if (m == null) copy = m = nbt.getClass().getMethod("func_74737_b");
            return m.invoke(nbt);
        } catch (ReflectiveOperationException e) {
            throw new IllegalStateException("Cannot copy pending chunk NBT", e);
        }
    }
}
