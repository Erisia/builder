package org.erisia.inspect;

import com.google.gson.*;
import java.lang.management.*;
import java.util.*;
import java.util.concurrent.locks.LockSupport;
import javax.management.*;
import javax.management.openmbean.CompositeData;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.TickEvent;

/**
 * Always-on slow-tick recorder. The server thread only writes two volatiles per tick; a daemon
 * watchdog samples the server thread's stack only while the current tick is over the threshold.
 * All data belongs to the inspector, never to the game.
 */
public final class Spikes {
    private static final int MAX_SPIKES=32, MAX_SAMPLES=2000, MAX_STACKS=64, MAX_FRAMES=64, MAX_GCS=64;
    private static final long INTERVAL_NS=5_000_000L;
    private static final Gson JSON=new GsonBuilder().serializeNulls().create();
    private static final long BASE_NS=System.nanoTime(), BASE_UPTIME_MS=ManagementFactory.getRuntimeMXBean().getUptime();
    private static final long BASE_EPOCH_MS=System.currentTimeMillis();
    private static volatile long thresholdNs=100_000_000L;
    private static volatile Thread serverThread;
    private static volatile long tickSeq, tickStartNs;
    private static long ticksSeen, slowTicks, sampleErrors;
    private static String sampleErrorSample;
    private static final ArrayDeque<Spike> spikes=new ArrayDeque<>();
    private static final ArrayDeque<long[]> gcs=new ArrayDeque<>(); // {startNs, durationMs}
    private static final List<String> gcNames=new ArrayList<>();
    private static boolean registered;

    static final class Spike {
        final long seq, startNs; long durationNs=-1, droppedSamples, otherStacks; int samples; boolean truncatedFrames;
        final LinkedHashMap<String,Object[]> stacks=new LinkedHashMap<>(); // key -> {count int[], frames String[]}
        Spike(long seq,long startNs) { this.seq=seq; this.startNs=startNs; }
    }

    public static synchronized void register() {
        if(registered)return;
        registered=true;
        MinecraftForge.EVENT_BUS.register(new Spikes());
        for(GarbageCollectorMXBean bean:ManagementFactory.getGarbageCollectorMXBeans()) {
            if(!(bean instanceof NotificationEmitter))continue;
            gcNames.add(bean.getName());
            ((NotificationEmitter)bean).addNotificationListener((notification,handback) -> gcNotification(bean.getName(),notification),null,null);
        }
        Thread watchdog=new Thread(Spikes::watch,"Erisia inspector slow-tick watchdog");
        watchdog.setDaemon(true); watchdog.setPriority(Thread.MAX_PRIORITY); watchdog.start();
    }

    @SubscribeEvent public void tick(TickEvent.ServerTickEvent event) {
        long now=System.nanoTime();
        if(event.phase==TickEvent.Phase.START) {
            serverThread=Thread.currentThread();
            tickSeq++; tickStartNs=now;
            return;
        }
        long start=tickStartNs; tickStartNs=0;
        if(start==0)return;
        long duration=now-start;
        synchronized(Spikes.class) {
            ticksSeen++;
            if(duration<thresholdNs)return;
            slowTicks++;
            spike(tickSeq,start).durationNs=duration;
        }
    }

    private static Spike spike(long seq,long start) {
        Spike last=spikes.peekLast();
        if(last!=null && last.seq==seq)return last;
        if(spikes.size()>=MAX_SPIKES)spikes.removeFirst();
        Spike s=new Spike(seq,start); spikes.addLast(s); return s;
    }

    private static void watch() {
        while(true) {
            LockSupport.parkNanos(INTERVAL_NS);
            try {
                long start=tickStartNs, seq=tickSeq; Thread thread=serverThread;
                if(start==0 || thread==null || System.nanoTime()-start<thresholdNs)continue;
                StackTraceElement[] stack=thread.getStackTrace();
                if(tickStartNs!=start || tickSeq!=seq)continue; // tick ended while sampling
                synchronized(Spikes.class) { add(spike(seq,start),stack); }
            } catch(Throwable t) {
                synchronized(Spikes.class) { sampleErrors++; if(sampleErrorSample==null)sampleErrorSample=Minecraft112.string(t); }
            }
        }
    }

    private static void add(Spike s,StackTraceElement[] stack) {
        if(s.samples>=MAX_SAMPLES) { s.droppedSamples++; return; }
        s.samples++;
        int n=Math.min(stack.length,MAX_FRAMES);
        if(stack.length>MAX_FRAMES)s.truncatedFrames=true;
        String[] frames=new String[n];
        for(int i=0;i<n;i++)frames[i]=stack[i].getClassName()+"."+stack[i].getMethodName()+":"+stack[i].getLineNumber();
        String key=String.join("\n",frames);
        Object[] entry=s.stacks.get(key);
        if(entry!=null) { ((int[])entry[0])[0]++; return; }
        if(s.stacks.size()>=MAX_STACKS) { s.otherStacks++; return; }
        s.stacks.put(key,new Object[]{new int[]{1},frames});
    }

    private static void gcNotification(String collector,Notification notification) {
        try {
            if(!"com.sun.management.gc.notification".equals(notification.getType()))return;
            CompositeData info=(CompositeData)((CompositeData)notification.getUserData()).get("gcInfo");
            long startMs=((Number)info.get("startTime")).longValue(), duration=((Number)info.get("duration")).longValue();
            long startNs=BASE_NS+(startMs-BASE_UPTIME_MS)*1_000_000L;
            synchronized(Spikes.class) {
                if(gcs.size()>=MAX_GCS)gcs.removeFirst();
                gcs.addLast(new long[]{startNs,duration,gcNames.indexOf(collector)});
            }
        } catch(Throwable ignored) { }
    }

    static long epochMs(long ns) { return BASE_EPOCH_MS+(ns-BASE_NS)/1_000_000L; }

    public static synchronized String command(String[] args) {
        if(args.length==1)return summary();
        if(args.length==3 && args[1].equals("show"))return detail(Long.parseLong(args[2]));
        if(args.length==3 && args[1].equals("threshold")) {
            long ms=Long.parseLong(args[2]);
            if(ms<20 || ms>60000)throw new IllegalArgumentException("Threshold must be 20..60000 ms");
            thresholdNs=ms*1_000_000L; return summary();
        }
        throw new IllegalArgumentException("spikes | spikes show SEQ | spikes threshold MS");
    }

    private static JsonObject header() {
        JsonObject root=new JsonObject(); root.addProperty("schema",1); root.addProperty("session",Minecraft112.SESSION);
        root.addProperty("threshold_ms",thresholdNs/1e6); root.addProperty("sample_interval_ms",INTERVAL_NS/1e6);
        root.addProperty("ticks_seen",ticksSeen); root.addProperty("slow_ticks_total",slowTicks);
        root.addProperty("retained_spikes_limit",MAX_SPIKES);
        root.addProperty("sample_errors",sampleErrors); root.addProperty("sample_error_sample",sampleErrorSample);
        root.addProperty("note","Ticks are ServerTickEvent START..END. Sampling begins only once a tick passes the threshold, so stacks show the late part of a slow tick. Stack sampling is safepoint-biased. duration_ms null means the tick was still running at report time.");
        return root;
    }

    private static JsonObject row(Spike s) {
        JsonObject row=new JsonObject(); row.addProperty("seq",s.seq); row.addProperty("start_epoch_ms",epochMs(s.startNs));
        if(s.durationNs<0)row.add("duration_ms",JsonNull.INSTANCE); else row.addProperty("duration_ms",s.durationNs/1e6);
        row.addProperty("samples",s.samples); row.addProperty("distinct_stacks",s.stacks.size());
        long end=s.durationNs<0?System.nanoTime():s.startNs+s.durationNs, gcMs=0; int gcCount=0;
        JsonArray overlap=new JsonArray();
        for(long[] gc:gcs) {
            long gcEnd=gc[0]+gc[1]*1_000_000L;
            if(gcEnd<s.startNs || gc[0]>end)continue;
            gcCount++; gcMs+=gc[1];
            JsonObject g=new JsonObject(); g.addProperty("collector",gc[2]>=0?gcNames.get((int)gc[2]):null);
            g.addProperty("start_epoch_ms",epochMs(gc[0])); g.addProperty("duration_ms",gc[1]); overlap.add(g);
        }
        row.addProperty("overlapping_gc_count",gcCount); row.addProperty("overlapping_gc_ms",gcMs);
        row.add("overlapping_gcs",overlap);
        Object[] top=null;
        for(Object[] e:s.stacks.values())if(top==null || ((int[])e[0])[0]>((int[])top[0])[0])top=e;
        row.addProperty("top_stack_leaf",top==null?null:((String[])top[1]).length>0?((String[])top[1])[0]:null);
        return row;
    }

    private static String summary() {
        JsonObject root=header(); JsonArray rows=new JsonArray();
        for(Spike s:spikes)rows.add(row(s));
        root.add("spikes",rows); return JSON.toJson(root);
    }

    private static String detail(long seq) {
        JsonObject root=header();
        for(Spike s:spikes) {
            if(s.seq!=seq)continue;
            JsonObject row=row(s); row.addProperty("dropped_samples",s.droppedSamples);
            row.addProperty("samples_in_unretained_stacks",s.otherStacks); row.addProperty("frames_truncated",s.truncatedFrames);
            List<Object[]> sorted=new ArrayList<>(s.stacks.values());
            sorted.sort((a,b) -> ((int[])b[0])[0]-((int[])a[0])[0]);
            JsonArray stacks=new JsonArray();
            for(Object[] e:sorted) {
                JsonObject st=new JsonObject(); st.addProperty("count",((int[])e[0])[0]);
                JsonArray frames=new JsonArray(); for(String f:(String[])e[1])frames.add(f);
                st.add("frames_leaf_first",frames); stacks.add(st);
            }
            row.add("stacks",stacks); root.add("spike",row); return JSON.toJson(root);
        }
        throw new IllegalArgumentException("No retained spike with seq "+seq);
    }
}
