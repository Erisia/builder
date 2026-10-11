package org.erisia.stepheightfix.mixin;

import net.minecraft.entity.player.EntityPlayer;
import org.objectweb.asm.Opcodes;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Redirect;

/**
 * Astral Sorcery's KeyStepAssist.onPlayerTick (server) adds 0.5 to stepHeight when the perk activates, then refreshes
 * its cooldown every tick and only keeps stepHeight at 1.1 or above; it sends the client (server - 0.4). Removed step
 * gear resets stepHeight to 0.6 or 0.5, and Chibi lowers the base to 0.7, so the client ends up below 1.0.
 *
 * Both writes in onPlayerTick (the +0.5 and the 1.1 floor) instead set at least 1.5, the value the perk intends
 * (client 1.1), whatever the base. Higher values from worn gear are kept. handleCooldownTimeout's -0.5 then leaves 1.0.
 * Names are runtime (SRG) names, so no refmap is needed.
 */
@Mixin(targets="hellfirepvp.astralsorcery.common.constellation.perk.tree.nodes.key.KeyStepAssist", remap=false)
public abstract class KeyStepAssistMixin {
    private static final float PERK_STEP_HEIGHT = 1.5f;

    @Redirect(method="onPlayerTick", remap=false, at=@At(value="FIELD", opcode=Opcodes.PUTFIELD, remap=false,
              target="Lnet/minecraft/entity/player/EntityPlayer;field_70138_W:F"))
    private void erisia$atLeastPerkStepHeight(EntityPlayer player, float value) {
        player.field_70138_W = Math.max(player.field_70138_W, PERK_STEP_HEIGHT);
    }
}
