package org.erisia.inspecttest;

import com.google.gson.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.lang.reflect.*;
import java.util.*;
import java.util.concurrent.*;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLServerStartedEvent;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;
import org.erisia.inspect.Inspector;
import org.erisia.inspect.Minecraft112;
import static org.erisia.inspect.Reflect.*;

/** Real transformed Cleanroom classes in a disposable flat world. Never loads the live pack/world. */
@Mod(modid="erisia_inspector_tests",name="Inspector integration tests",version="0.1.0",
     serverSideOnly=true,acceptableRemoteVersions="*")
public final class IntegrationTests {
    static class BasePosition { private final String position="base position"; }
    static class ShadowPosition extends BasePosition { private final int position=42; }
    private Object server,world,item;
    private static final int X=1000,Z=-1000;
    @Mod.EventHandler public void starting(FMLServerStartingEvent e)throws Exception { server=call(e,"getServer"); }
    @Mod.EventHandler public void started(FMLServerStartedEvent e) {
        Thread suite=new Thread(() -> {
            try {
                onMain(() -> { setup(); invariants(); return null; });
                Thread.sleep(1200);
                onMain(() -> {
                    check(((Number)field(item,"field_70292_b")).intValue()==0,"resident fringe item does not age under normal server ticks");
                    JsonObject before=query("chunk","0",String.valueOf(X),String.valueOf(Z));
                    check(find(before).get("age_ticks").getAsInt()==0,"snapshot preserves frozen age");
                    // Test fixture only: grow the resident item population without ticking the fringe.
                    spawn(X*16+10.0,Z*16+10.0);
                    JsonObject grown=query("chunk","0",String.valueOf(X),String.valueOf(Z));
                    check(grown.getAsJsonArray("worlds").get(0).getAsJsonObject().getAsJsonArray("entities").size()>=2,"growing item list remains visible remotely");
                    Files.write(Paths.get("frozen-after.json"),grown.toString().getBytes(StandardCharsets.UTF_8));
                    // Real gate transition: the test loads missing neighbors, never the inspector.
                    for(int x=X-2;x<=X+2;x++)for(int z=Z-2;z<=Z+2;z++)call(world,"func_72964_e",x,z);
                    int age=((Number)field(item,"field_70292_b")).intValue();
                    for(int i=0;i<5;i++)call(world,"func_72866_a",item,true);
                    check(((Number)field(item,"field_70292_b")).intValue()>age,"item ages once neighbor gate is satisfied");
                    return null;
                });
                Thread.sleep(2200);
                onMain(() -> {
                    JsonObject watch=query("watch","status");
                    check(!watch.get("active").getAsBoolean(),"watch stops automatically");
                    check(watch.getAsJsonArray("updates").size()>0,"real transformed update calls observed");
                    check(watch.getAsJsonArray("joins").size()>0,"join provenance captured");
                    check(watch.get("observer_errors").getAsInt()==0,"watch adapter succeeds");
                    JsonObject coverage=watch.getAsJsonObject("hooks_observed_since_start");
                    check(coverage.get("entity_on_update_seen").getAsBoolean(),"expected entity hook is available in isolated Cleanroom");
                    check(coverage.get("tile_update_seen").getAsBoolean(),"expected tile hook is available in isolated Cleanroom");
                    boolean unlocated=false;
                    for(JsonElement row:watch.getAsJsonArray("updates"))
                        if(row.getAsJsonObject().get("dimension").isJsonNull())unlocated=true;
                    check(unlocated,"global watch preserves explicit null location through JSON serialization");
                    Files.write(Paths.get("watch.json"),watch.toString().getBytes(StandardCharsets.UTF_8));
                    return null;
                });
                Files.write(Paths.get("test-result.txt"),"PASS\n".getBytes(StandardCharsets.UTF_8));
                System.out.println("INSPECTOR TESTS PASSED");
            }catch(Throwable t) {
                t.printStackTrace();
                try { Files.write(Paths.get("test-result.txt"),("FAIL: "+t+"\n").getBytes(StandardCharsets.UTF_8)); }catch(Exception ignored) { }
            }finally { try { call(server,"func_71263_m"); }catch(Exception e2) { e2.printStackTrace(); } }
        },"Inspector test suite");
        suite.setDaemon(true); suite.start();
    }
    Object onMain(Callable<?> action)throws Exception { return ((Future<?>)call(server,"func_175586_a",action)).get(30,TimeUnit.SECONDS); }
    JsonObject query(String...args)throws Exception { return new JsonParser().parse(Inspector.dispatch(server,args)).getAsJsonObject(); }
    @SuppressWarnings("unchecked") Map<Long,Object> chunks()throws Exception { return (Map<Long,Object>)field(call(world,"func_72863_F"),"field_73244_f"); }
    void setup()throws Exception {
        check(declaredField(new ShadowPosition(),BasePosition.class.getName(),"position").equals("base position"),
            "declaring-class lookup ignores mod-style shadowed field names");
        Object detachedTile=construct("net.minecraft.tileentity.TileEntityChest");
        JsonObject detached=Minecraft112.identity(detachedTile,true);
        check(detached.get("dimension").isJsonNull(),"detached tile is explicitly unlocated, never assigned a guessed world");
        world=((Object[])field(server,"field_71305_c"))[0];
        query("status");
        call(world,"func_72964_e",X,Z);
        query("watch","start","3");
        // Adapter fixture only; do not invoke a detached tile's game update.
        long started=org.erisia.inspect.Watch.begin(detachedTile,true);
        org.erisia.inspect.Watch.end(detachedTile,started);
        item=spawn(X*16+8.0,Z*16+8.0);
        Object pos=construct("net.minecraft.util.math.BlockPos",X*16+4,2,Z*16+4);
        Object chest=field(type("net.minecraft.init.Blocks"),"field_150486_ae");
        call(world,"func_175656_a",pos,call(chest,"func_176223_P"));
    }
    Object spawn(double x,double z)throws Exception {
        Object diamond=field(type("net.minecraft.init.Items"),"field_151045_i");
        Object stack=construct("net.minecraft.item.ItemStack",diamond,1);
        Object entity=construct("net.minecraft.entity.item.EntityItem",world,x,3.0,z,stack);
        check((Boolean)call(world,"func_72838_d",entity),"spawn test entity");
        return entity;
    }
    JsonObject find(JsonObject report)throws Exception {
        String uuid=call(item,"func_110124_au").toString();
        for(JsonElement we:report.getAsJsonArray("worlds"))for(JsonElement e:we.getAsJsonObject().getAsJsonArray("entities"))
            if(e.getAsJsonObject().get("uuid").getAsString().equals(uuid))return e.getAsJsonObject();
        throw new AssertionError("item absent from report: "+report);
    }
    @SuppressWarnings("unchecked") void invariants()throws Exception {
        // Warm mapped access before verifying a complete query within its soft time budget.
        query("chunk","0",String.valueOf(X),String.valueOf(Z));
        Set<Long> before=new HashSet<>(chunks().keySet());
        Set<?> unloadBefore=new HashSet<>((Set<?>)field(call(world,"func_72863_F"),"field_73248_b"));
        int age=((Number)field(item,"field_70292_b")).intValue();
        int ticks=((Number)field(item,"field_70173_aa")).intValue();
        JsonObject report=query("chunk","0",String.valueOf(X),String.valueOf(Z));
        check(report.get("complete").getAsBoolean(),"small chunk inspection completes");
        Files.write(Paths.get("frozen-before.json"),report.toString().getBytes(StandardCharsets.UTF_8));
        JsonObject entity=find(report);
        check(entity.getAsJsonArray("missing_entity_neighbor_chunks").size()>0,"fringe reports missing neighbors");
        check(entity.get("world_list").getAsBoolean() && entity.get("chunk_list").getAsBoolean(),"both resident memberships visible");
        check(entity.get("position_chunk").getAsJsonArray().get(1).getAsInt()==Z,"negative coordinates floor correctly");
        query("census");
        query("chunk","0","99999","99999");
        check(query("chunk","999","0","0").getAsJsonArray("worlds").size()==0,"unloaded dimension is not initialized");
        check(before.equals(chunks().keySet()),"inspection never loads/generates/unloads a chunk");
        check(unloadBefore.equals(field(call(world,"func_72863_F"),"field_73248_b")),"inspection does not cancel queued unloads");
        check(((Number)field(item,"field_70292_b")).intValue()==age,"inspection leaves item age alone");
        check(((Number)field(item,"field_70173_aa")).intValue()==ticks,"inspection never ticks entities");
        List<Object> worldList=(List<Object>)field(world,"field_72996_f");
        worldList.remove(item); // Test-only inconsistent residency fixture.
        check(!find(query("chunk","0",String.valueOf(X),String.valueOf(Z))).get("world_list").getAsBoolean(),"chunk-only entity still visible");
        worldList.add(item);
        try { query("delete","items"); throw new AssertionError("mutation command accepted"); }
        catch(IllegalArgumentException expected) { }
        System.out.println("PASS no-load, no-tick, residency, bounds, negative coordinates and read-only command invariants");
    }
    static void check(boolean condition,String message) { if(!condition)throw new AssertionError(message); }
}
