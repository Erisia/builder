package org.erisia.inspect;

import com.google.gson.*;
import java.util.*;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.entity.EntityJoinWorldEvent;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.TickEvent;
import static org.erisia.inspect.Reflect.*;

/** Passive, bounded observation. All data belongs to the inspector, never to the game. */
public final class Watch {
    private static final int MAX_OBJECTS=4096, MAX_JOINS=128;
    private static final Gson JSON=new GsonBuilder().serializeNulls().create();
    private static volatile Capture active;
    private static Capture last;
    private static final boolean[] hooksSeen=new boolean[3];
    public static void noteHook(int hook) { hooksSeen[hook]=true; }
    public static JsonObject coverage() {
        JsonObject c=new JsonObject(); c.addProperty("entity_on_update_seen",hooksSeen[0]);
        c.addProperty("entity_ridden_update_seen",hooksSeen[1]); c.addProperty("tile_update_seen",hooksSeen[2]);
        c.addProperty("note","False means unverified/unavailable, not that an entity or tile is inactive. Other coremods can replace call sites.");
        return c;
    }
    private static final Watch LISTENER=new Watch();
    private static boolean registered;
    static final class Record {
        final JsonObject identity; long calls,total,max;
        Record(JsonObject identity) { this.identity=identity; }
    }
    static final class Capture {
        final Thread thread=Thread.currentThread();
        final String id=UUID.randomUUID().toString();
        final long startMs=System.currentTimeMillis(), startNs=System.nanoTime();
        final long deadline; final int[] scope;
        final IdentityHashMap<Object,Record> objects=new IdentityHashMap<>();
        final List<Record> rows=new ArrayList<>();
        final JsonArray joins=new JsonArray();
        final Set<String> errorSamples=new LinkedHashSet<>();
        long endMs, droppedObjects,droppedJoins, errors, unlocated; boolean complete;
        Capture(int seconds,int[] scope) { deadline=startNs+seconds*1_000_000_000L; this.scope=scope; }
        void finish() { endMs=System.currentTimeMillis(); complete=true; objects.clear(); }
    }
    public static void register() { if(!registered) { MinecraftForge.EVENT_BUS.register(LISTENER); registered=true; } }
    @SubscribeEvent public void tick(TickEvent.ServerTickEvent event) { current(); }
    private static Capture current() {
        Capture c=active;
        if(c!=null && c.thread==Thread.currentThread() && System.nanoTime()>=c.deadline) {
            c.finish(); last=c; active=null; return null;
        }
        return c!=null && c.thread==Thread.currentThread()?c:null;
    }
    public static String command(Object server,String[] args) throws Exception {
        current();
        if(args.length==2 && args[1].equals("status")) return report();
        if((args.length!=3 && args.length!=6) || !args[1].equals("start"))
            throw new IllegalArgumentException("watch start SECONDS [DIM CX CZ] | watch status");
        if(active!=null)throw new IllegalStateException("A watch is already active; inspect it with watch status");
        int seconds=Integer.parseInt(args[2]);
        if(seconds<1 || seconds>60)throw new IllegalArgumentException("Watch seconds must be 1..60");
        int[] scope=null;
        if(args.length==6) {
            scope=new int[]{Integer.parseInt(args[3]),Integer.parseInt(args[4]),Integer.parseInt(args[5])};
            if(Math.abs((long)scope[1])>1875000 || Math.abs((long)scope[2])>1875000)throw new IllegalArgumentException("Chunk coordinates out of bounds");
        }
        active=new Capture(seconds,scope); return report();
    }
    static boolean matches(Capture c,JsonObject identity) {
        if(c.scope==null)return true;
        if(identity.get("dimension").isJsonNull()) { c.unlocated++; return false; }
        return (identity.get("dimension").getAsInt()==c.scope[0]
            && ((int)Math.floor(identity.get("x").getAsDouble())>>4)==c.scope[1]
            && ((int)Math.floor(identity.get("z").getAsDouble())>>4)==c.scope[2]);
    }
    static void error(Capture c,Object object,Exception ex) {
        c.errors++;
        if(c.errorSamples.size()<8)c.errorSamples.add(Minecraft112.string(object.getClass().getName()+": "+ex));
    }
    /** Return zero when disabled; excludes observer setup overhead from the measured call. */
    public static long begin(Object object,boolean tile) {
        Capture c=current(); if(c==null)return 0;
        try {
            Record r=c.objects.get(object);
            if(r==null) {
                if(c.rows.size()>=MAX_OBJECTS) { c.droppedObjects++; return 0; }
                JsonObject identity=Minecraft112.identity(object,tile);
                if(!matches(c,identity))return 0;
                r=new Record(identity); c.objects.put(object,r); c.rows.add(r);
            } else if(c.scope!=null && !matches(c,Minecraft112.identity(object,tile)))return 0;
            return System.nanoTime();
        } catch(Exception ex) { error(c,object,ex); return 0; }
    }
    public static void end(Object object,long started) {
        if(started==0)return;
        long elapsed=System.nanoTime()-started;
        Capture c=active; if(c==null || c.thread!=Thread.currentThread())return;
        Record r=c.objects.get(object); if(r==null)return;
        r.calls++; r.total+=elapsed; r.max=Math.max(r.max,elapsed);
    }
    @SubscribeEvent public void joined(EntityJoinWorldEvent event) {
        Capture c=current(); if(c==null)return;
        try {
            if(c.joins.size()>=MAX_JOINS) { c.droppedJoins++; return; }
            Object entity=call(event,"getEntity");
            JsonObject row=Minecraft112.identity(entity,false); if(!matches(c,row))return;
            row.addProperty("observed_epoch_ms",System.currentTimeMillis());
            JsonArray stack=new JsonArray(); boolean chunkLoad=false; int totalFrames=0;
            for(StackTraceElement frame:Thread.currentThread().getStackTrace()) {
                if(frame.getClassName().equals("net.minecraft.world.chunk.Chunk"))chunkLoad=true;
                if(!frame.getClassName().startsWith("org.erisia.inspect") && !frame.getClassName().equals("java.lang.Thread")) {
                    totalFrames++; if(stack.size()<20)stack.add(frame.toString());
                }
            }
            row.addProperty("stack_truncated",totalFrames>stack.size());
            row.add("stack",stack); row.addProperty("origin_hint",chunkLoad?"chunk_path_present":"spawn_or_other_path");
            row.addProperty("note","Join event observed; acceptance, actual spawn, machine ownership and later removal are not guaranteed");
            c.joins.add(row);
        } catch(Exception ex) { error(c,event,ex); }
    }
    static String report() {
        Capture c=active!=null?active:last;
        JsonObject root=new JsonObject(); root.addProperty("schema",1); root.addProperty("session",Minecraft112.SESSION);
        root.addProperty("active",active!=null); root.add("hooks_observed_since_start",coverage());
        if(c==null) { root.addProperty("available",false); return JSON.toJson(root); }
        root.addProperty("available",true); root.addProperty("watch_id",c.id);
        root.addProperty("start_epoch_ms",c.startMs); root.addProperty("end_epoch_ms",c.complete?c.endMs:System.currentTimeMillis());
        root.addProperty("duration_limit_seconds",(c.deadline-c.startNs)/1e9);
        root.addProperty("finished",c.complete); root.addProperty("dropped_object_observations",c.droppedObjects);
        root.addProperty("dropped_join_events",c.droppedJoins); root.addProperty("observer_errors",c.errors);
        JsonArray errors=new JsonArray(); for(String sample:c.errorSamples)errors.add(sample);
        root.add("observer_error_samples",errors);
        root.addProperty("unlocated_scoped_observations",c.unlocated);
        if(c.scope!=null) { JsonArray scope=new JsonArray(); for(int i:c.scope)scope.add(i); root.add("scope_dim_chunk",scope); }
        JsonArray rows=new JsonArray(); root.add("updates",rows);
        for(Record r:c.rows) {
            JsonObject row=new JsonObject(); for(Map.Entry<String,JsonElement> e:r.identity.entrySet())row.add(e.getKey(),e.getValue());
            row.addProperty("calls",r.calls); row.addProperty("total_ms",r.total/1e6); row.addProperty("max_ms",r.max/1e6); rows.add(row);
        }
        root.add("joins",c.joins);
        root.addProperty("coverage","World entity onUpdate/updateRidden and World or HammerLib McHooks tile ITickable.update call sites on the server thread; excludes other schedulers/async work");
        root.addProperty("timing_note","Inclusive elapsed call time, not CPU/self time. Positions are first observed. Records can overlap/recurse.");
        return JSON.toJson(root);
    }
}
