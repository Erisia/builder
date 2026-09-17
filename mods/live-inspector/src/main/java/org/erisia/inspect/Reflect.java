package org.erisia.inspect;

import java.lang.reflect.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** Pinned production SRG names; fail rather than guessing a different member. */
public final class Reflect {
    private static final Map<String, Field> fields = new ConcurrentHashMap<>();
    private static final Map<String, Method> methods = new ConcurrentHashMap<>();
    public static Class<?> type(String name) throws Exception { return Class.forName(name); }
    /** Read a known game field from its declaring class, ignoring mod-subclass name collisions. */
    public static Object declaredField(Object target,String declaringClass,String name) throws Exception {
        String key="declared:"+declaringClass+":"+name;
        Field member=fields.get(key);
        if(member==null) {
            member=type(declaringClass).getDeclaredField(name);
            member.setAccessible(true); fields.put(key,member);
        }
        return member.get(target);
    }
    public static Object field(Object target, String name) throws Exception {
        Class<?> start = target instanceof Class ? (Class<?>) target : target.getClass();
        String key = start.getName() + ":" + name;
        Field field = fields.get(key);
        if (field == null) {
            for (Class<?> c = start; c != null; c = c.getSuperclass()) {
                try { field = c.getDeclaredField(name); break; } catch (NoSuchFieldException ignored) { }
            }
            if (field == null) throw new NoSuchFieldException(key);
            field.setAccessible(true);
            fields.put(key, field);
        }
        return field.get(target instanceof Class ? null : target);
    }
    public static Object call(Object target, String name, Object... args) throws Exception {
        Class<?> start = target instanceof Class ? (Class<?>) target : target.getClass();
        String key = start.getName() + ":" + name + ":" + Arrays.toString(Arrays.stream(args)
            .map(a -> a == null ? null : a.getClass()).toArray());
        Method method = methods.get(key);
        if (method == null) {
            for (Class<?> c = start; c != null && method == null; c = c.getSuperclass()) {
                for (Method m : c.getDeclaredMethods()) {
                    if (m.getName().equals(name) && matches(m.getParameterTypes(), args)) { method = m; break; }
                }
            }
            if (method == null) throw new NoSuchMethodException(key);
            method.setAccessible(true);
            methods.put(key, method);
        }
        try { return method.invoke(target instanceof Class ? null : target, args); }
        catch (InvocationTargetException e) {
            if (e.getCause() instanceof Error) throw (Error)e.getCause();
            throw (Exception)e.getCause();
        }
    }
    public static Object construct(String name, Object... args) throws Exception {
        for (Constructor<?> c : type(name).getConstructors()) {
            if (matches(c.getParameterTypes(), args)) return c.newInstance(args);
        }
        throw new NoSuchMethodException(name + " constructor");
    }
    private static boolean matches(Class<?>[] types, Object[] args) {
        if (types.length != args.length) return false;
        for (int i=0; i<types.length; i++) {
            if (args[i] == null || types[i].isInstance(args[i])) continue;
            if (types[i] == int.class && args[i] instanceof Integer) continue;
            if (types[i] == double.class && args[i] instanceof Double) continue;
            if (types[i] == boolean.class && args[i] instanceof Boolean) continue;
            if (types[i] == long.class && args[i] instanceof Long) continue;
            return false;
        }
        return true;
    }
}
