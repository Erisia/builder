package org.erisia.inspect;

import com.google.gson.*;
import java.lang.reflect.Proxy;
import java.util.*;
import java.util.concurrent.*;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;
import static org.erisia.inspect.Reflect.*;

/** No world mutation commands, ticking hooks, capabilities, NBT serialization, or chunk requests. */
public final class Minecraft112 {
    public static final String SESSION = UUID.randomUUID().toString();
    private static final Gson JSON = new GsonBuilder().serializeNulls().create();
    private static final int MAX_VISITS=100000, MAX_CHUNKS=4096, MAX_DETAILS=1024, MAX_TILES=256;
    private static final long BUDGET_NS=50_000_000L;
    private static Class<?> itemClass;


    static final class Budget {
        final long start=System.nanoTime(); int visits; boolean limited;
        boolean take() {
            if (++visits>MAX_VISITS || System.nanoTime()-start>BUDGET_NS) { limited=true; return false; }
            return true;
        }
    }
    static final class Seen {
        final Object entity; boolean world,chunk; int listedX,listedZ; JsonObject group,row;
        Seen(Object entity) { this.entity=entity; }
    }
    static int n(Object target,String fieldName) throws Exception { return ((Number)field(target,fieldName)).intValue(); }
    static double d(Object target,String fieldName) throws Exception { return ((Number)field(target,fieldName)).doubleValue(); }
    static int cx(Object e) throws Exception { return ((int)Math.floor(d(e,"field_70165_t")))>>4; }
    static int cz(Object e) throws Exception { return ((int)Math.floor(d(e,"field_70161_v")))>>4; }
    public static long key(int x,int z) { return ((long)x & 0xffffffffL) | (((long)z & 0xffffffffL)<<32); }
    @SuppressWarnings("unchecked") static Map<Long,Object> loaded(Object world) throws Exception {
        return (Map<Long,Object>)field(call(world,"func_72863_F"),"field_73244_f");
    }
    static JsonArray coords(int x,int z) { JsonArray a=new JsonArray(); a.add(x); a.add(z); return a; }
    static String string(Object o) { String s=String.valueOf(o); return s.length()>256?s.substring(0,256):s; }
    static void increment(JsonObject obj,String key,long amount) {
        obj.addProperty(key,(obj.has(key)?obj.get(key).getAsLong():0)+amount);
    }
    static JsonObject group(Map<Long,JsonObject> groups,int x,int z) {
        return groups.computeIfAbsent(key(x,z), k -> {
            JsonObject g=new JsonObject(); g.addProperty("chunk_x",x); g.addProperty("chunk_z",z);
            g.addProperty("entities",0); g.add("entity_classes",new JsonObject()); g.addProperty("item_entities",0); g.addProperty("item_units",0); return g;
        });
    }

    static final class Collector {
        final IdentityHashMap<Object,Seen> seen=new IdentityHashMap<>();
        final Map<Long,JsonObject> groups=new LinkedHashMap<>();
        final JsonArray entities=new JsonArray();
        final Map<Long,Object> chunks; final Object tickets; final Budget budget;
        final boolean detail; final int offset; int index;
        Collector(Map<Long,Object> chunks,Object tickets,Budget budget,boolean detail,int offset) {
            this.chunks=chunks; this.tickets=tickets; this.budget=budget; this.detail=detail; this.offset=offset;
        }
        void add(Object e,boolean world,int lx,int lz) throws Exception {
            Seen s=seen.get(e);
            if(s==null) {
                if(groups.size()>=MAX_CHUNKS && !groups.containsKey(key(cx(e),cz(e)))) { budget.limited=true; return; }
                s=new Seen(e); seen.put(e,s);
            int px=cx(e),pz=cz(e);
            JsonObject g=group(groups,px,pz);
            increment(g,"entities",1);
            JsonObject classes=g.getAsJsonObject("entity_classes");
            String className=e.getClass().getName();
            if(classes.size()<64 || classes.has(className))increment(classes,className,1);
            else increment(g,"other_entity_classes",1);
            if((Boolean)field(e,"field_70128_L"))increment(g,"dead_entities",1);
            if(itemClass.isInstance(e)) {
                int age=n(e,"field_70292_b");
                Object stack=call(e,"func_92059_d");
                int count=((Number)call(stack,"func_190916_E")).intValue();
                increment(g,"item_entities",1); increment(g,"item_units",count);
                if(age==-32768)increment(g,"never_despawn_age_items",1);
                if(!g.has("min_item_age") || age<g.get("min_item_age").getAsInt())g.addProperty("min_item_age",age);
                if(!g.has("max_item_age") || age>g.get("max_item_age").getAsInt())g.addProperty("max_item_age",age);
            }
                s.group=g;
                if(detail && index++>=offset && entities.size()<MAX_DETAILS) {
                    s.row=entity(s,chunks,tickets); entities.add(s.row);
                }
            }
            if(world && !s.world) { increment(s.group,"world_list_entities",1); s.world=true; }
            if(!world && !s.chunk) { increment(s.group,"chunk_list_entities",1); s.chunk=true; s.listedX=lx; s.listedZ=lz; }
            if(s.row!=null) {
                s.row.addProperty("world_list",s.world); s.row.addProperty("chunk_list",s.chunk);
                if(s.chunk)s.row.add("listed_chunk",coords(s.listedX,s.listedZ));
            }
        }
    }

    /** Must run on the server thread. It reads only already resident world and chunk collections. */
    public static String inspect(Object server,String[] args) throws Exception {
        if (!(Boolean)call(server,"func_152345_ab")) throw new IllegalStateException("Inspection requires the server thread");
        if(args.length==1 && args[0].equals("status")) return status(server);
        boolean census=(args.length==1 || args.length==2) && args[0].equals("census");
        boolean detail=(args.length==4 || args.length==5) && args[0].equals("chunk");
        if (!census && !detail) throw new IllegalArgumentException("status | census [DIM] | chunk DIM CX CZ [ENTITY_OFFSET]");
        int dim=0,x=0,z=0,offset=0;
        if(detail) {
            dim=Integer.parseInt(args[1]); x=Integer.parseInt(args[2]); z=Integer.parseInt(args[3]);
            if(args.length==5) offset=Integer.parseInt(args[4]);
            if(Math.abs((long)x)>1875000 || Math.abs((long)z)>1875000 || offset<0 || offset>MAX_VISITS)
                throw new IllegalArgumentException("Chunk coordinates/offset outside supported bounds");
        }
        if(itemClass==null) itemClass=type("net.minecraft.entity.item.EntityItem");
        JsonObject root=new JsonObject(); root.addProperty("schema",1); root.addProperty("session",SESSION);
        root.addProperty("captured_epoch_ms",System.currentTimeMillis());
        root.addProperty("server_tick",((Number)call(server,"func_71259_af")).longValue());
        root.addProperty("query",String.join(" ",args));
        root.addProperty("scope","resident world list and resident chunk slices; excludes disk and dormant cache");
        JsonArray worlds=new JsonArray(); root.add("worlds",worlds);
        Budget budget=new Budget();
        for(Object world:(Object[])field(server,"field_71305_c")) {
            if(world==null)continue;
            int worldDim=((Number)call(field(world,"field_73011_w"),"getDimension")).intValue();
            if((detail && worldDim!=dim) || (census && args.length==2 && worldDim!=Integer.parseInt(args[1])))continue;
            worlds.add(world(world,worldDim,detail,x,z,offset,budget));
            if(budget.limited)break;
        }
        root.addProperty("complete",!budget.limited); root.addProperty("visits",budget.visits);
        root.addProperty("scan_ms",(System.nanoTime()-budget.start)/1e6);
        if(budget.limited) root.addProperty("limitation","Scan budget reached; counts are lower bounds. Narrow to a chunk; absence proves nothing.");
        root.addProperty("gate_note","Neighbor coverage is a structural prerequisite, not an observed tick decision; Forge hooks/mixins can override it.");
        return JSON.toJson(root);
    }

    @SuppressWarnings("unchecked") static JsonObject world(Object world,int dim,boolean detail,int x,int z,int offset,Budget budget) throws Exception {
        Map<Long,Object> chunks=loaded(world);
        Set<Long> dropped=(Set<Long>)field(call(world,"func_72863_F"),"field_73248_b");
        Object tickets=call(world,"getPersistentChunks");
        List<?> worldEntities=(List<?>)field(world,"field_72996_f");
        JsonObject result=new JsonObject(); result.addProperty("dimension",dim);
        result.addProperty("loaded_chunks_total",chunks.size()); result.addProperty("world_entities_total",worldEntities.size());
        if(detail) {
            result.add("requested_chunk",coords(x,z)); result.addProperty("requested_chunk_loaded",chunks.containsKey(key(x,z)));
            Object target=chunks.get(key(x,z)); int sliceTotal=0;
            if(target!=null)for(Object slice:(Object[])field(target,"field_76645_j"))sliceTotal+=((Collection<?>)slice).size();
            result.addProperty("chunk_slice_entities_total",sliceTotal);
        }
        Collector capture=new Collector(chunks,tickets,budget,detail,offset);
        Map<Long,JsonObject> groups=capture.groups;
        Iterable<Object> selected=detail ? (chunks.containsKey(key(x,z)) ? Collections.singletonList(chunks.get(key(x,z))) : Collections.emptyList()) : chunks.values();
        int chunkVisits=0;
        for(Object chunk:selected) {
            if(!budget.take() || ++chunkVisits>MAX_CHUNKS) { budget.limited=true; break; }
            int lx=n(chunk,"field_76635_g"),lz=n(chunk,"field_76647_h");
            for(Object slice:(Object[])field(chunk,"field_76645_j")) {
                for(Object e:(Iterable<?>)slice) {
                    if(!budget.take())break;
                    capture.add(e,false,lx,lz);
                }
                if(budget.limited)break;
            }
            if(budget.limited)break;
        }
        for(Object e:worldEntities) {
            if(!budget.take())break;
            if(detail && (cx(e)!=x || cz(e)!=z))continue;
            capture.add(e,true,0,0);
        }
        result.add("entities",capture.entities);
        int index=capture.index,exported=capture.entities.size();
        if(detail) {
            result.addProperty("entity_offset",offset); result.addProperty("details_complete",!budget.limited && offset+exported>=index);
            result.addProperty("next_entity_offset",offset+exported);
            if(!groups.containsKey(key(x,z)))group(groups,x,z);
            JsonArray tiles=new JsonArray(); result.add("nearby_tiles",tiles);
            int tileCount=0;
            outer: for(int nx=x-1;nx<=x+1;nx++)for(int nz=z-1;nz<=z+1;nz++) {
                Object c=chunks.get(key(nx,nz)); if(c==null)continue;
                Map<?,?> tileMap=(Map<?,?>)field(c,"field_150816_i");
                for(Map.Entry<?,?> entry:tileMap.entrySet()) {
                    if(!budget.take() || tileCount++>=MAX_TILES) { result.addProperty("tiles_truncated",true); break outer; }
                    Object p=entry.getKey(); JsonObject t=new JsonObject();
                    t.addProperty("x",((Number)call(p,"func_177958_n")).intValue());
                    t.addProperty("y",((Number)call(p,"func_177956_o")).intValue());
                    t.addProperty("z",((Number)call(p,"func_177952_p")).intValue());
                    Object tile=entry.getValue();
                    t.addProperty("class",tile.getClass().getName());
                    t.addProperty("tickable",type("net.minecraft.util.ITickable").isInstance(tile));
                    t.addProperty("invalid",(Boolean)field(tile,"field_145846_f")); tiles.add(t);
                }
            }
        }
        JsonArray summaries=new JsonArray(); result.add("chunks",summaries);
        for(JsonObject g:groups.values()) {
            int total=g.get("entities").getAsInt();
            g.addProperty("chunk_only_entities",total-(g.has("world_list_entities")?g.get("world_list_entities").getAsInt():0));
            g.addProperty("world_only_entities",total-(g.has("chunk_list_entities")?g.get("chunk_list_entities").getAsInt():0));
            summaries.add(g);
            if(!budget.take()) { g.addProperty("metadata_incomplete",true); continue; }
            int gx=g.get("chunk_x").getAsInt(),gz=g.get("chunk_z").getAsInt();
            g.addProperty("loaded",chunks.containsKey(key(gx,gz))); g.addProperty("queued_unload",dropped.contains(key(gx,gz)));
            JsonArray owners=new JsonArray(); g.add("forge_tickets",owners);
            Collection<?> ts=(Collection<?>)call(tickets,"get",construct("net.minecraft.util.math.ChunkPos",gx,gz));
            for(Object ticket:ts) {
                if(owners.size()>=32) { g.addProperty("tickets_truncated",true); break; }
                JsonObject owner=new JsonObject(); owner.addProperty("mod",string(call(ticket,"getModId")));
                owner.addProperty("type",string(call(ticket,"getType"))); owners.add(owner);
            }
        }
        return result;
    }

    static JsonObject entity(Seen s,Map<Long,Object> chunks,Object tickets) throws Exception {
        Object e=s.entity; int x=cx(e),z=cz(e);
        JsonObject out=new JsonObject(); out.addProperty("uuid",string(call(e,"func_110124_au")));
        out.addProperty("class",e.getClass().getName());
        out.addProperty("x",d(e,"field_70165_t")); out.addProperty("y",d(e,"field_70163_u")); out.addProperty("z",d(e,"field_70161_v"));
        out.addProperty("ticks_existed",n(e,"field_70173_aa")); out.addProperty("dead",(Boolean)field(e,"field_70128_L"));
        out.addProperty("update_blocked",(Boolean)field(e,"updateBlocked"));
        out.addProperty("added_to_chunk",(Boolean)field(e,"field_70175_ag"));
        out.add("position_chunk",coords(x,z)); out.add("stored_chunk",coords(n(e,"field_70176_ah"),n(e,"field_70164_aj")));
        out.addProperty("world_list",s.world); out.addProperty("chunk_list",s.chunk);
        if(s.chunk)out.add("listed_chunk",coords(s.listedX,s.listedZ));
        if(itemClass.isInstance(e)) {
            Object stack=call(e,"func_92059_d");
            out.addProperty("age_ticks",n(e,"field_70292_b")); out.addProperty("lifespan_ticks",n(e,"lifespan"));
            out.addProperty("item_count",((Number)call(stack,"func_190916_E")).intValue());
            out.addProperty("item_id",string(call(call(stack,"func_77973_b"),"getRegistryName")));
            out.addProperty("item_damage",((Number)call(stack,"func_77960_j")).intValue());
        }
        boolean forced=(Boolean)call(tickets,"containsKey",construct("net.minecraft.util.math.ChunkPos",x,z));
        out.addProperty("forge_forced",forced);
        JsonArray missing=new JsonArray(); int range=forced?0:2;
        for(int nx=x-range;nx<=x+range;nx++)for(int nz=z-range;nz<=z+range;nz++)
            if(!chunks.containsKey(key(nx,nz)))missing.add(coords(nx,nz));
        out.add("missing_entity_neighbor_chunks",missing); out.addProperty("neighbor_coverage_complete",missing.size()==0);
        return out;
    }
    static String status(Object server) throws Exception {
        JsonObject root=new JsonObject(); root.addProperty("schema",1); root.addProperty("session",SESSION);
        root.addProperty("adapter","minecraft-1.12.2-cleanroom-0.6.12-alpha");
        root.addProperty("version","0.1.0"); root.addProperty("read_only",true); root.add("hooks_observed_since_start",Watch.coverage());
        root.addProperty("captured_epoch_ms",System.currentTimeMillis());
        root.addProperty("server_tick",((Number)call(server,"func_71259_af")).longValue());
        root.addProperty("scan_budget_ms",BUDGET_NS/1e6); root.addProperty("max_visits",MAX_VISITS);
        JsonArray worlds=new JsonArray(); root.add("worlds",worlds);
        for(Object world:(Object[])field(server,"field_71305_c")) {
            if(world==null)continue;
            JsonObject w=new JsonObject(); w.addProperty("dimension",((Number)call(field(world,"field_73011_w"),"getDimension")).intValue());
            w.addProperty("loaded_chunks",loaded(world).size());
            w.addProperty("world_entities",((List<?>)field(world,"field_72996_f")).size());
            w.addProperty("loaded_tiles",((List<?>)field(world,"field_147482_g")).size());
            w.addProperty("ticking_tiles",((List<?>)field(world,"field_175730_i")).size());
            JsonArray players=new JsonArray(); w.add("players",players);
            for(Object player:(List<?>)field(world,"field_73010_i")) {
                if(players.size()>=128) { w.addProperty("players_truncated",true); break; }
                JsonObject p=new JsonObject(); p.addProperty("uuid",string(call(player,"func_110124_au")));
                p.addProperty("name",string(call(player,"func_70005_c_")));
                p.addProperty("x",d(player,"field_70165_t")); p.addProperty("y",d(player,"field_70163_u")); p.addProperty("z",d(player,"field_70161_v"));
                players.add(p);
            }
            worlds.add(w);
        }
        return JSON.toJson(root);
    }

    /** Version adapter for passive watch identities; no inventory or NBT callbacks. */
    public static JsonObject identity(Object object,boolean tile) throws Exception {
        JsonObject row=new JsonObject(); row.addProperty("kind",tile?"tile":"entity");
        row.addProperty("class",object.getClass().getName());
        if(tile && !type("net.minecraft.tileentity.TileEntity").isInstance(object)) {
            row.add("dimension",JsonNull.INSTANCE); row.add("x",JsonNull.INSTANCE);
            row.add("y",JsonNull.INSTANCE); row.add("z",JsonNull.INSTANCE);
            row.addProperty("location_note","ITickable object is not a TileEntity; no mapped world position");
            return row;
        }
        Object world=tile?declaredField(object,"net.minecraft.tileentity.TileEntity","field_145850_b")
            :declaredField(object,"net.minecraft.entity.Entity","field_70170_p");
        if(world==null) {
            row.add("dimension",JsonNull.INSTANCE);
            row.addProperty("location_note","No world in mapped field; detached or mod-managed object. Coordinates may be placeholders.");
        } else row.addProperty("dimension",((Number)call(field(world,"field_73011_w"),"getDimension")).intValue());
        if(tile) {
            Object p=declaredField(object,"net.minecraft.tileentity.TileEntity","field_174879_c");
            row.addProperty("x",((Number)call(p,"func_177958_n")).intValue());
            row.addProperty("y",((Number)call(p,"func_177956_o")).intValue());
            row.addProperty("z",((Number)call(p,"func_177952_p")).intValue());
        } else {
            row.addProperty("uuid",string(call(object,"func_110124_au")));
            row.addProperty("x",d(object,"field_70165_t")); row.addProperty("y",d(object,"field_70163_u")); row.addProperty("z",d(object,"field_70161_v"));
        }
        return row;
    }

}
