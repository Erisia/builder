package org.erisia.savethreadingtest;

import java.util.Collections;
import java.util.List;
import net.minecraftforge.fml.relauncher.IFMLLoadingPlugin;
import zone.rong.mixinbooter.IEarlyMixinLoader;

@IFMLLoadingPlugin.Name("ErisiaSaveThreadingTests")
public final class TestPlugin implements IFMLLoadingPlugin, IEarlyMixinLoader {
    @Override public List<String> getMixinConfigs() {
        return Collections.singletonList("mixins.erisia.save-threading-tests.json");
    }
}
