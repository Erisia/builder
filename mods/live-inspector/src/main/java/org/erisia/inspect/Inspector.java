package org.erisia.inspect;

import com.google.gson.*;
import java.lang.reflect.Proxy;
import java.util.*;
import java.util.concurrent.*;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLServerStartingEvent;
import static org.erisia.inspect.Reflect.*;

@Mod(modid="erisia_live_inspector", name="Erisia Live Inspector", version="0.1.0",
     serverSideOnly=true, acceptableRemoteVersions="*")
public final class Inspector {
    private static final Gson JSON=new Gson();
    @Mod.EventHandler public void starting(FMLServerStartingEvent event) throws Exception {
        Watch.register();
        Class<?> commandType=type("net.minecraft.command.ICommand");
        Object command=Proxy.newProxyInstance(commandType.getClassLoader(), new Class<?>[]{commandType}, (proxy, method, args) -> {
            switch(method.getName()) {
                case "func_71517_b": return "erisia-inspect";
                case "func_71518_a": return "erisia-inspect status | census [DIM] | chunk DIM CX CZ [OFFSET] | watch start SECONDS [DIM CX CZ] | watch status";
                case "func_71514_a": case "func_184883_a": return Collections.emptyList();
                case "func_184882_a": return call(args[1], "func_70003_b", 2, "erisia-inspect");
                case "func_82358_a": return false;
                case "compareTo": return 0;
                case "toString": return "Erisia read-only inspector";
                case "hashCode": return System.identityHashCode(proxy);
                case "equals": return proxy == args[0];
                case "func_184881_a":
                    Object server=args[0], sender=args[1];
                    String[] words=(String[])args[2];
                    String result;
                    try {
                        if ((Boolean)call(server,"func_152345_ab")) result=dispatch(server,words);
                        else {
                            Future<?> pending=(Future<?>)call(server,"func_175586_a",(Callable<String>)() -> dispatch(server,words));
                            try { result=(String)pending.get(3,TimeUnit.SECONDS); }
                            catch (Exception ex) { pending.cancel(false); throw ex; }
                        }
                    } catch (Exception ex) {
                        JsonObject error=new JsonObject(); error.addProperty("schema",1);
                        error.addProperty("error",ex.toString()); result=JSON.toJson(error);
                    }
                    call(sender,"func_145747_a",construct("net.minecraft.util.text.TextComponentString",result));
                    return null;
                default: throw new UnsupportedOperationException(method.toString());
            }
        });
        call(event,"registerServerCommand",command);
    }

    public static String dispatch(Object server,String[] words) throws Exception {
        if (!(Boolean)call(server,"func_152345_ab")) throw new IllegalStateException("Server thread required");
        if(words.length>0 && words[0].equals("watch")) return Watch.command(server,words);
        return Minecraft112.inspect(server,words);
    }
}
