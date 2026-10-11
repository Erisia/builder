package org.erisia.stepheightfix;

import java.util.Collections;
import java.util.List;
import zone.rong.mixinbooter.ILateMixinLoader;

/** Found by Cleanroom's built-in MixinBooter through the ASM data table; queues the Astral Sorcery mixin. */
public final class StepHeightMixinLoader implements ILateMixinLoader {
    @Override public List<String> getMixinConfigs() {
        return Collections.singletonList("mixins.erisia_stepheight_fix.json");
    }
}
