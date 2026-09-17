package org.erisia.inspect;
import net.minecraftforge.fml.relauncher.IFMLLoadingPlugin;
@IFMLLoadingPlugin.Name("ErisiaLiveInspector")
@IFMLLoadingPlugin.MCVersion("1.12.2")
public final class InspectorPlugin implements IFMLLoadingPlugin, zone.rong.mixinbooter.IEarlyMixinLoader {
    @Override public java.util.List<String> getMixinConfigs() {
        return java.util.Collections.singletonList("mixins.erisia.live-inspector.json");
    }
}
