package org.erisia.savethreading;

import java.util.Collections;
import java.util.List;
import net.minecraftforge.fml.relauncher.IFMLLoadingPlugin;
import zone.rong.mixinbooter.IEarlyMixinLoader;

/** Cleanroom's early loader: these targets load before ordinary mod initialization. */
@IFMLLoadingPlugin.Name("ErisiaSaveThreading")
@IFMLLoadingPlugin.MCVersion("1.12.2")
public final class SaveThreadingPlugin implements IFMLLoadingPlugin, IEarlyMixinLoader {
    @Override
    public List<String> getMixinConfigs() {
        return Collections.singletonList("mixins.erisia.save-threading.json");
    }
}
