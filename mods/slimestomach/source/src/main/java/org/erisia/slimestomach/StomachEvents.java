package org.erisia.slimestomach;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;
import java.util.UUID;
import net.minecraft.block.Block;
import net.minecraft.block.state.IBlockState;
import net.minecraft.entity.Entity;
import net.minecraft.entity.EntityLivingBase;
import net.minecraft.entity.item.EntityItem;
import net.minecraft.entity.monster.EntitySlime;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.init.Blocks;
import net.minecraft.init.MobEffects;
import net.minecraft.potion.PotionEffect;
import net.minecraft.server.MinecraftServer;
import net.minecraft.util.DamageSource;
import net.minecraft.util.EnumActionResult;
import net.minecraft.util.EnumHand;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.text.ITextComponent;
import net.minecraft.util.text.TextComponentString;
import net.minecraft.util.text.TextFormatting;
import net.minecraft.world.World;
import net.minecraft.world.WorldServer;
import net.minecraft.world.gen.ChunkProviderServer;
import net.minecraftforge.common.DimensionManager;
import net.minecraftforge.event.entity.living.LivingAttackEvent;
import net.minecraftforge.event.entity.living.LivingDeathEvent;
import net.minecraftforge.event.entity.living.LivingHurtEvent;
import net.minecraftforge.event.entity.player.PlayerInteractEvent;
import net.minecraftforge.event.entity.player.PlayerSetSpawnEvent;
import net.minecraftforge.event.entity.player.PlayerSleepInBedEvent;
import net.minecraftforge.event.world.BlockEvent;
import net.minecraftforge.event.world.ExplosionEvent;
import net.minecraftforge.event.world.WorldEvent;
import net.minecraftforge.fluids.Fluid;
import net.minecraftforge.fluids.FluidRegistry;
import net.minecraftforge.fml.common.FMLCommonHandler;
import net.minecraftforge.fml.common.eventhandler.EventPriority;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import net.minecraftforge.fml.common.gameevent.PlayerEvent;
import net.minecraftforge.fml.common.gameevent.TickEvent;

public class StomachEvents {
    public static final StomachEvents INSTANCE = new StomachEvents();

    public static final DamageSource DIGESTED = new DamageSource("slimestomach.digested") {
        @Override
        public ITextComponent getDeathMessage(EntityLivingBase victim) {
            return new TextComponentString(victim.getName() + " was digested by a slime");
        }
    }.setDamageBypassesArmor().setDamageIsAbsolute();

    /** Players released for digestion; killed a tick later, once they have arrived. */
    private final Map<UUID, Integer> pendingKills = new HashMap<>();
    /** Player -> server tick until which they can't be hurt (just escaped). */
    private final Map<UUID, Integer> grace = new HashMap<>();
    /** Player -> slime that hit them; swallowed next tick, outside the damage code. */
    private final Map<UUID, UUID> pendingSwallows = new HashMap<>();
    private int ticks;

    private static MinecraftServer server() {
        return FMLCommonHandler.instance().getMinecraftServerInstance();
    }

    private static ITextComponent msg(TextFormatting color, String text) {
        ITextComponent c = new TextComponentString(text);
        c.getStyle().setColor(color);
        return c;
    }

    private static String where(int dim, double x, double y, double z) {
        return String.format("%d, %d, %d in dimension %d", (int) Math.floor(x), (int) Math.floor(y), (int) Math.floor(z), dim);
    }

    // ---- The stomach dimension ----

    @SubscribeEvent
    public void onWorldLoad(WorldEvent.Load event) {
        World world = event.getWorld();
        if (world.isRemote || world.provider.getDimension() != SSConfig.stomachDimension || !SlimeStomach.enabled) return;
        ((ChunkProviderServer) world.getChunkProvider()).chunkGenerator = new VoidChunkGenerator(world);
        SlimeStomach.LOGGER.info("Stomach dimension {} loaded with a void generator", SSConfig.stomachDimension);
    }

    /** No beds or spawn points in there: respawning in the void would be a death loop. */
    @SubscribeEvent
    public void onSleep(PlayerSleepInBedEvent event) {
        if (event.getEntityPlayer().dimension == SSConfig.stomachDimension && !event.getEntityPlayer().world.isRemote) {
            event.setResult(EntityPlayer.SleepResult.NOT_POSSIBLE_HERE);
        }
    }

    @SubscribeEvent
    public void onSetSpawn(PlayerSetSpawnEvent event) {
        if (event.getEntityPlayer().dimension == SSConfig.stomachDimension && event.getNewSpawn() != null) {
            event.setCanceled(true);
        }
    }

    // ---- Swallowing ----

    @SubscribeEvent
    public void onInteract(PlayerInteractEvent.EntityInteract event) {
        if (!SlimeStomach.enabled || event.getWorld().isRemote || event.getHand() != EnumHand.MAIN_HAND) return;
        if (!(event.getEntityPlayer() instanceof EntityPlayerMP) || !(event.getTarget() instanceof EntitySlime)) return;
        EntitySlime slime = (EntitySlime) event.getTarget();
        EntityPlayerMP player = (EntityPlayerMP) event.getEntityPlayer();
        StomachData data = StomachData.get(player.server);
        if (!canSwallow(data, player, slime)) return;
        event.setCanceled(true);
        event.setCancellationResult(EnumActionResult.SUCCESS);
        swallow(data, player, slime);
    }

    private static boolean canSwallow(StomachData data, EntityPlayerMP player, EntitySlime slime) {
        if (slime.isDead || slime.getSlimeSize() < SSConfig.minSlimeSize || Theme.forEntity(slime) == null) return false;
        if (player.isSpectator() || player.isDead || player.dimension == SSConfig.stomachDimension) return false;
        return data.byOccupant(player.getUniqueID()) == null;
    }

    /** A big slime that actually hurts a player may swallow them. */
    @SubscribeEvent(priority = EventPriority.LOWEST)
    public void onHurt(LivingHurtEvent event) {
        if (!SlimeStomach.enabled || !(event.getEntity() instanceof EntityPlayerMP) || event.getEntity().world.isRemote) return;
        Entity attacker = event.getSource().getTrueSource();
        if (!(attacker instanceof EntitySlime) || event.getAmount() <= 0) return;
        EntityPlayerMP player = (EntityPlayerMP) event.getEntity();
        if (!canSwallow(StomachData.get(player.server), player, (EntitySlime) attacker)) return;
        if (player.getRNG().nextDouble() < SSConfig.swallowChanceOnHit) {
            pendingSwallows.put(player.getUniqueID(), attacker.getUniqueID());
        }
    }

    /** Just escaped: slimes nearby (the split-up remains of the old one, say) can't hurt you yet. */
    @SubscribeEvent(priority = EventPriority.HIGHEST)
    public void onAttack(LivingAttackEvent event) {
        if (!(event.getEntity() instanceof EntityPlayerMP) || event.getSource() == DIGESTED) return;
        if (event.getSource() == DamageSource.OUT_OF_WORLD) return;
        Integer until = grace.get(event.getEntity().getUniqueID());
        if (until != null && until >= ticks) {
            event.setCanceled(true);
            return;
        }
        // Inside, only digestion hurts: every death in there goes through digest(), which puts the grave outside.
        if (event.getEntity().dimension == SSConfig.stomachDimension
                && StomachData.get(server()).byOccupant(event.getEntity().getUniqueID()) != null) {
            event.setCanceled(true);
        }
    }

    private void swallow(StomachData data, EntityPlayerMP player, EntitySlime slime) {
        Stomach stomach = data.bySlime(slime.getUniqueID());
        if (stomach == null) {
            WorldServer target = player.server.getWorld(SSConfig.stomachDimension);
            BlockPos origin = target == null ? null : findSpot(target, data);
            if (origin == null) {
                player.sendMessage(msg(TextFormatting.GRAY, "The slime looks too full to eat you."));
                return;
            }
            Theme theme = Theme.forEntity(slime);
            StomachShape shape = StomachShape.generate(target.rand);
            build(target, origin, shape, theme);
            stomach = new Stomach();
            stomach.shape = shape;
            stomach.wall = theme.wallSpec;
            stomach.light = theme.lightSpec;
            stomach.juice = theme.juiceName;
            stomach.id = data.nextId - 1;
            stomach.slime = slime.getUniqueID();
            stomach.dimension = SSConfig.stomachDimension;
            stomach.origin = origin;
            stomach.origName = slime.hasCustomName() ? slime.getCustomNameTag() : "";
            stomach.origAlwaysRender = slime.getAlwaysRenderNameTag();
            data.stomachs.add(stomach);
            SlimeStomach.LOGGER.info("Built stomach #{} at {} for slime {}", stomach.id,
                    where(stomach.dimension, origin.getX(), origin.getY(), origin.getZ()), slime.getUniqueID());
        }
        stomach.slimeDim = slime.dimension;
        stomach.slimeX = slime.posX;
        stomach.slimeY = slime.posY;
        stomach.slimeZ = slime.posZ;
        stomach.occupants.add(player.getUniqueID());
        data.markDirty();
        slime.enablePersistence();
        updateName(stomach, slime);

        BlockPos c = stomach.spawn();
        StomachTeleporter.teleport(player, stomach.dimension, c.getX() + 0.5, c.getY(), c.getZ() + 0.5);
        tire(player);
        player.sendMessage(msg(TextFormatting.GREEN,
                "Schlorp. You have been swallowed by " + Theme.forEntity(slime).description + ". Someone else will have to kill it to get you out."));
        SlimeStomach.LOGGER.info("{} was swallowed by slime {} (stomach #{}) at {}", player.getName(), slime.getUniqueID(),
                stomach.id, where(slime.dimension, slime.posX, slime.posY, slime.posZ));
        if (SSConfig.announce) {
            player.server.getPlayerList().sendMessage(msg(TextFormatting.GREEN, player.getName()
                    + " was swallowed by " + Theme.forEntity(slime).description + " at " + where(slime.dimension, slime.posX, slime.posY, slime.posZ)
                    + ". Kill it to set them free!"));
        }
    }

    /** Stomachs sit on a grid, 64 blocks apart, one cell per stomach ID. */
    private static BlockPos findSpot(WorldServer world, StomachData data) {
        for (int attempt = 0; attempt < 100; attempt++) {
            int cell = data.nextId++;
            BlockPos origin = new BlockPos((cell % 64) * 64, 100, (cell / 64) * 64);
            if (isEmpty(world, origin)) return origin;
        }
        return null;
    }

    private static boolean isEmpty(WorldServer world, BlockPos origin) {
        int n = StomachShape.N - 1;
        for (BlockPos p : BlockPos.getAllInBoxMutable(origin, origin.add(n, n, n))) {
            if (!world.isAirBlock(p)) return false;
        }
        return true;
    }

    private static void build(WorldServer world, BlockPos origin, StomachShape shape, Theme theme) {
        IBlockState bedrock = Blocks.BEDROCK.getDefaultState();
        IBlockState slime = theme.wall;
        IBlockState glow = theme.light;
        int lights = 0;
        for (int i = 0; i < shape.cells.length; i++) {
            BlockPos p = origin.add(StomachShape.x(i), StomachShape.y(i), StomachShape.z(i));
            switch (shape.cells[i]) {
                case StomachShape.BEDROCK:
                    world.setBlockState(p, bedrock, 2);
                    break;
                case StomachShape.WALL:
                    boolean light = shape.isVisibleWall(i) && world.rand.nextDouble() < SSConfig.glowstoneChance;
                    if (light) lights++;
                    world.setBlockState(p, light ? glow : slime, 2);
                    break;
                default:
            }
        }
        if (lights == 0) {
            // At least one light, just above the spawn point's head if that's wall.
            int s = shape.spawn;
            int x = StomachShape.x(s), y = StomachShape.y(s), z = StomachShape.z(s);
            for (int up = 2; up < StomachShape.N; up++) {
                if (shape.at(x, y + up, z) == StomachShape.WALL) {
                    world.setBlockState(origin.add(x, y + up, z), glow, 2);
                    break;
                }
            }
        }
    }

    private static void demolish(Stomach stomach) {
        WorldServer world = server().getWorld(stomach.dimension);
        if (world == null) return;
        Theme theme = stomach.theme();
        int n = StomachShape.N - 1;
        for (BlockPos.MutableBlockPos p : BlockPos.getAllInBoxMutable(stomach.origin, stomach.origin.add(n, n, n))) {
            IBlockState state = world.getBlockState(p);
            if (state.getBlock() == Blocks.BEDROCK || theme.isWall(state) || theme.isJuice(state)) {
                world.setBlockState(p, Blocks.AIR.getDefaultState(), 2);
            }
        }
        SlimeStomach.LOGGER.info("Demolished stomach #{}", stomach.id);
    }

    private static void updateName(Stomach stomach, EntitySlime slime) {
        if (stomach.occupants.isEmpty()) {
            slime.setCustomNameTag(stomach.origName);
            slime.setAlwaysRenderNameTag(stomach.origAlwaysRender);
            return;
        }
        StringJoiner names = new StringJoiner(", ");
        for (UUID u : stomach.occupants) {
            EntityPlayerMP p = server().getPlayerList().getPlayerByUUID(u);
            names.add(p != null ? p.getName() : "someone");
        }
        slime.setCustomNameTag("Stomach of " + names);
        slime.setAlwaysRenderNameTag(true);
    }

    private static EntitySlime findSlime(Stomach stomach) {
        WorldServer world = DimensionManager.getWorld(stomach.slimeDim);
        if (world == null) return null;
        Entity e = world.getEntityFromUuid(stomach.slime);
        return e instanceof EntitySlime ? (EntitySlime) e : null;
    }

    private static final int FATIGUE_TICKS = 60;

    /** Walls shouldn't come apart too easily: keep occupants tired. */
    private static void tire(EntityPlayerMP player) {
        if (SSConfig.miningFatigue < 0) return;
        PotionEffect current = player.getActivePotionEffect(MobEffects.MINING_FATIGUE);
        if (current == null || current.getDuration() < FATIGUE_TICKS / 2) {
            player.addPotionEffect(new PotionEffect(MobEffects.MINING_FATIGUE, FATIGUE_TICKS, SSConfig.miningFatigue, true, false));
        }
    }

    private static void rest(EntityPlayerMP player) {
        PotionEffect current = player.getActivePotionEffect(MobEffects.MINING_FATIGUE);
        if (current != null && current.getIsAmbient() && current.getDuration() <= FATIGUE_TICKS) {
            player.removePotionEffect(MobEffects.MINING_FATIGUE);
        }
    }

    // ---- Leaving ----

    /** Take a player out of a stomach and put them where the slime is (or was). */
    private void eject(StomachData data, Stomach stomach, UUID uuid, int dim, double x, double y, double z) {
        stomach.occupants.remove(uuid);
        data.markDirty();
        EntityPlayerMP player = server().getPlayerList().getPlayerByUUID(uuid);
        if (player == null) {
            data.pendingReturns.put(uuid, new double[] {dim, x, y, z});
            return;
        }
        rest(player);
        StomachTeleporter.teleport(player, dim, x, y, z);
        grace.put(uuid, ticks + SSConfig.graceTicks);
    }

    /** The slime is gone: everyone inside comes out where it was. */
    public void free(StomachData data, Stomach stomach, String why) {
        int dim = stomach.slimeDim;
        double x = stomach.slimeX, y = stomach.slimeY, z = stomach.slimeZ;
        List<String> names = new ArrayList<>();
        moveItems(stomach, dim, x, y, z);
        for (UUID u : new ArrayList<>(stomach.occupants)) {
            EntityPlayerMP p = server().getPlayerList().getPlayerByUUID(u);
            names.add(p != null ? p.getName() : u.toString());
            eject(data, stomach, u, dim, x, y, z);
            if (p != null) p.sendMessage(msg(TextFormatting.GREEN, "Blorp. You slide out of the slime, " + why + "."));
        }
        SlimeStomach.LOGGER.info("Stomach #{} freed ({}): {}", stomach.id, why, names);
        if (SSConfig.announce && !names.isEmpty()) {
            server().getPlayerList().sendMessage(msg(TextFormatting.GREEN, String.join(", ", names) + " escaped a slime's stomach."));
        }
        retire(data, stomach, true);
    }

    /** Drop the stomach record; demolish the structure if asked. */
    private static void retire(StomachData data, Stomach stomach, boolean demolish) {
        data.stomachs.remove(stomach);
        data.markDirty();
        EntitySlime slime = findSlime(stomach);
        if (slime != null) {
            stomach.occupants.clear();
            updateName(stomach, slime);
        }
        if (demolish) demolish(stomach);
    }

    /** Items thrown around inside come out with their owners instead of falling into the void. */
    private static void moveItems(Stomach stomach, int dim, double x, double y, double z) {
        WorldServer from = DimensionManager.getWorld(stomach.dimension);
        WorldServer to = server().getWorld(dim);
        if (from == null || to == null || !from.isBlockLoaded(stomach.spawn())) return;
        for (EntityItem item : from.getEntitiesWithinAABB(EntityItem.class, stomach.box())) {
            if (item.isDead || item.getItem().isEmpty()) continue;
            to.spawnEntity(new EntityItem(to, x, y, z, item.getItem().copy()));
            item.setDead();
        }
    }

    /** One player leaves, but the slime lives on. The stomach goes once it's empty. */
    public void releaseOne(StomachData data, Stomach stomach, UUID uuid, boolean demolishIfEmpty) {
        eject(data, stomach, uuid, stomach.slimeDim, stomach.slimeX, stomach.slimeY, stomach.slimeZ);
        afterLeave(data, stomach, demolishIfEmpty);
    }

    private static void afterLeave(StomachData data, Stomach stomach, boolean demolishIfEmpty) {
        if (stomach.occupants.isEmpty()) {
            retire(data, stomach, demolishIfEmpty);
        } else {
            EntitySlime slime = findSlime(stomach);
            if (slime != null) updateName(stomach, slime);
        }
    }

    @SubscribeEvent(priority = EventPriority.LOWEST)
    public void onDeath(LivingDeathEvent event) {
        if (event.getEntity().world.isRemote) return;
        StomachData data = StomachData.get(server());
        if (event.getEntity() instanceof EntitySlime) {
            Stomach stomach = data.bySlime(event.getEntity().getUniqueID());
            if (stomach == null) return;
            Entity slime = event.getEntity();
            stomach.slimeDim = slime.dimension;
            stomach.slimeX = slime.posX;
            stomach.slimeY = slime.posY;
            stomach.slimeZ = slime.posZ;
            Entity killer = event.getSource().getTrueSource();
            free(data, stomach, killer instanceof EntityPlayerMP ? "thanks to " + killer.getName() : "as it dies");
        } else if (event.getEntity() instanceof EntityPlayerMP) {
            // Died inside of something other than digestion. Leave the structure: their drops are in there.
            Stomach stomach = data.byOccupant(event.getEntity().getUniqueID());
            if (stomach == null) return;
            stomach.occupants.remove(event.getEntity().getUniqueID());
            data.markDirty();
            SlimeStomach.LOGGER.info("{} died inside stomach #{} ({}); stomach at {}", event.getEntity().getName(), stomach.id,
                    event.getSource().getDamageType(), where(stomach.dimension, stomach.origin.getX(), stomach.origin.getY(), stomach.origin.getZ()));
            afterLeave(data, stomach, false);
        }
    }

    @SubscribeEvent
    public void onLogin(PlayerEvent.PlayerLoggedInEvent event) {
        if (!(event.player instanceof EntityPlayerMP)) return;
        EntityPlayerMP player = (EntityPlayerMP) event.player;
        StomachData data = StomachData.get(player.server);
        double[] ret = data.pendingReturns.remove(player.getUniqueID());
        if (ret != null) {
            data.markDirty();
            StomachTeleporter.teleport(player, (int) ret[0], ret[1], ret[2], ret[3]);
            grace.put(player.getUniqueID(), ticks + SSConfig.graceTicks);
            player.sendMessage(msg(TextFormatting.GREEN, "While you were away, someone killed the slime that ate you."));
        } else {
            rescueStray(data, player);
        }
    }

    /**
     * Someone in the stomach dimension who isn't in any stomach (its record was lost, say) would
     * fall into the void. Send them to the overworld spawn instead.
     */
    private void rescueStray(StomachData data, EntityPlayerMP player) {
        if (player.dimension != SSConfig.stomachDimension || player.isCreative() || player.isSpectator()) return;
        if (data.byOccupant(player.getUniqueID()) != null || pendingKills.containsKey(player.getUniqueID())) return;
        WorldServer overworld = player.server.getWorld(0);
        BlockPos spawn = overworld.getTopSolidOrLiquidBlock(overworld.getSpawnPoint());
        SlimeStomach.LOGGER.info("{} was in the stomach dimension without a stomach; sending them to spawn", player.getName());
        StomachTeleporter.teleport(player, 0, spawn.getX() + 0.5, spawn.getY(), spawn.getZ() + 0.5);
        grace.put(player.getUniqueID(), ticks + SSConfig.graceTicks);
        player.sendMessage(msg(TextFormatting.GREEN, "Blorp. The slime spits you out."));
    }

    // ---- Digestion ----

    private static Stomach stomachAt(StomachData data, int dim, BlockPos pos) {
        for (Stomach s : data.stomachs) if (s.dimension == dim && s.contains(pos)) return s;
        return null;
    }

    /** A wall block broke: start digesting, or digest harder. */
    private void wound(StomachData data, Stomach stomach) {
        stomach.wounds++;
        data.markDirty();
        String text;
        if (!stomach.digesting) {
            stomach.digesting = true;
            stomach.fillTimer = 0;
            text = "The stomach walls convulse. Gastric juice begins to seep in...";
            SlimeStomach.LOGGER.info("Stomach #{} started digesting", stomach.id);
        } else {
            text = "The stomach clenches. The juices grow stronger (x" + stomach.wounds + ").";
        }
        for (UUID u : stomach.occupants) {
            EntityPlayerMP p = server().getPlayerList().getPlayerByUUID(u);
            if (p != null) p.sendMessage(msg(TextFormatting.DARK_GREEN, text));
        }
    }

    @SubscribeEvent
    public void onBreak(BlockEvent.BreakEvent event) {
        if (event.getWorld().isRemote) return;
        StomachData data = StomachData.get(server());
        Stomach stomach = stomachAt(data, event.getWorld().provider.getDimension(), event.getPos());
        if (stomach != null && stomach.theme().isWall(event.getState())) wound(data, stomach);
    }

    @SubscribeEvent
    public void onExplosion(ExplosionEvent.Detonate event) {
        if (event.getWorld().isRemote) return;
        StomachData data = StomachData.get(server());
        int dim = event.getWorld().provider.getDimension();
        for (BlockPos pos : event.getAffectedBlocks()) {
            Stomach stomach = stomachAt(data, dim, pos);
            if (stomach != null && stomach.theme().isWall(event.getWorld().getBlockState(pos))) wound(data, stomach);
        }
    }

    /** Fills the next layer: cavity, and any holes broken into the wall. */
    private static void fillLayer(Stomach stomach) {
        WorldServer world = server().getWorld(stomach.dimension);
        IBlockState juice = stomach.theme().juice.getDefaultState();
        int y = stomach.shape.minY + stomach.fillLevel;
        for (int z = 0; z < StomachShape.N; z++)
            for (int x = 0; x < StomachShape.N; x++) {
                byte c = stomach.shape.at(x, y, z);
                if (c != StomachShape.CAVITY && c != StomachShape.WALL) continue;
                BlockPos p = stomach.origin.add(x, y, z);
                if (world.isAirBlock(p)) world.setBlockState(p, juice, 2);
            }
        stomach.fillLevel++;
    }

    private static boolean inJuice(EntityPlayerMP player, Theme theme) {
        BlockPos feet = new BlockPos(player.posX, player.posY + 0.1, player.posZ);
        BlockPos eyes = new BlockPos(player.posX, player.posY + player.getEyeHeight(), player.posZ);
        return theme.isJuice(player.world.getBlockState(feet)) || theme.isJuice(player.world.getBlockState(eyes));
    }

    private void digest(StomachData data, Stomach stomach, EntityPlayerMP player) {
        if (player.isCreative() || player.isSpectator()) return;
        // Stronger with every broken wall block, and doubling over time so no armor holds out forever.
        double doublings = SSConfig.digestDoublingSeconds > 0 ? stomach.digestTicks / (20.0 * SSConfig.digestDoublingSeconds) : 0;
        float damage = (float) (SSConfig.digestDamage * Math.max(1, stomach.wounds) * Math.pow(2, doublings));
        if (player.getHealth() + player.getAbsorptionAmount() > damage) {
            // Armor mods with shields may cancel the attack outright; digestion happens anyway.
            if (!player.attackEntityFrom(DIGESTED, damage)) player.setHealth(player.getHealth() - damage);
            return;
        }
        // The last bite: spit the remains out where the slime is, so graves and drops are reachable.
        player.sendMessage(msg(TextFormatting.DARK_GREEN, "You have been digested."));
        SlimeStomach.LOGGER.info("{} was digested in stomach #{}", player.getName(), stomach.id);
        releaseOne(data, stomach, player.getUniqueID(), true);
        pendingKills.put(player.getUniqueID(), 2);
    }

    // ---- Ticking ----

    @SubscribeEvent
    public void onTick(TickEvent.ServerTickEvent event) {
        if (event.phase != TickEvent.Phase.END) return;
        MinecraftServer server = server();
        if (server == null || server.getWorld(0) == null) return;
        ticks++;

        for (Iterator<Map.Entry<UUID, Integer>> it = pendingKills.entrySet().iterator(); it.hasNext(); ) {
            Map.Entry<UUID, Integer> e = it.next();
            if (e.getValue() > 1) {
                e.setValue(e.getValue() - 1);
                continue;
            }
            it.remove();
            EntityPlayerMP p = server.getPlayerList().getPlayerByUUID(e.getKey());
            if (p != null && !p.isDead && !p.attackEntityFrom(DIGESTED, Float.MAX_VALUE) && !p.isCreative()) {
                // Cancelled (a shield, say) rather than survived (a totem): die regardless.
                p.setHealth(0);
                p.onDeath(DIGESTED);
            }
        }

        StomachData data = StomachData.get(server);
        if (!pendingSwallows.isEmpty()) {
            for (Map.Entry<UUID, UUID> e : new ArrayList<>(pendingSwallows.entrySet())) {
                EntityPlayerMP p = server.getPlayerList().getPlayerByUUID(e.getKey());
                Entity slime = p == null ? null : ((WorldServer) p.world).getEntityFromUuid(e.getValue());
                if (slime instanceof EntitySlime && canSwallow(data, p, (EntitySlime) slime)) {
                    swallow(data, p, (EntitySlime) slime);
                }
            }
            pendingSwallows.clear();
        }
        grace.values().removeIf(until -> until < ticks);
        if (ticks % 20 == 10 && SlimeStomach.enabled) {
            WorldServer stomachWorld = DimensionManager.getWorld(SSConfig.stomachDimension);
            if (stomachWorld != null) {
                for (EntityPlayer p : new ArrayList<>(stomachWorld.playerEntities)) {
                    if (p instanceof EntityPlayerMP && !p.isDead) rescueStray(data, (EntityPlayerMP) p);
                }
            }
        }
        if (data.stomachs.isEmpty()) return;
        boolean second = ticks % 20 == 0;
        for (Stomach stomach : new ArrayList<>(data.stomachs)) {
            List<EntityPlayerMP> present = new ArrayList<>();
            for (UUID u : new ArrayList<>(stomach.occupants)) {
                EntityPlayerMP p = server.getPlayerList().getPlayerByUUID(u);
                if (p == null || p.isDead) continue;
                if (p.dimension != stomach.dimension) {
                    if (!second) continue;
                    // Some other mod teleported them out. Let it count.
                    SlimeStomach.LOGGER.info("{} left stomach #{} by leaving the dimension", p.getName(), stomach.id);
                    stomach.occupants.remove(u);
                    data.markDirty();
                    rest(p);
                    p.sendMessage(msg(TextFormatting.GREEN, "You wriggle out of the slime somehow."));
                    afterLeave(data, stomach, true);
                    continue;
                }
                present.add(p);
            }
            if (!data.stomachs.contains(stomach)) continue;

            if (stomach.digesting && !present.isEmpty()) stomach.digestTicks++;
            if (stomach.digesting && !present.isEmpty() && stomach.fillLevel < stomach.layers()
                    && ++stomach.fillTimer >= SSConfig.ticksPerLayer) {
                stomach.fillTimer = 0;
                fillLayer(stomach);
                data.markDirty();
            }

            if (!second) continue;
            for (EntityPlayerMP p : present) {
                if (!stomach.isInside(new BlockPos(p.posX, p.posY + 0.1, p.posZ))) {
                    BlockPos c = stomach.spawn();
                    StomachTeleporter.teleport(p, stomach.dimension, c.getX() + 0.5, c.getY(), c.getZ() + 0.5);
                }
                tire(p);
                if (stomach.digesting && (stomach.fillLevel >= stomach.layers() || inJuice(p, stomach.theme()))) {
                    digest(data, stomach, p);
                }
            }
            if (!data.stomachs.contains(stomach)) continue;
            checkSlime(data, stomach);
        }
    }

    /** Catch slimes that vanish without dying (peaceful difficulty, other mods). */
    private void checkSlime(StomachData data, Stomach stomach) {
        WorldServer world = DimensionManager.getWorld(stomach.slimeDim);
        if (world == null) return;
        Entity e = world.getEntityFromUuid(stomach.slime);
        if (e != null && !e.isDead) {
            stomach.missingChecks = 0;
            if (e.dimension != stomach.slimeDim || e.posX != stomach.slimeX || e.posY != stomach.slimeY || e.posZ != stomach.slimeZ) {
                stomach.slimeDim = e.dimension;
                stomach.slimeX = e.posX;
                stomach.slimeY = e.posY;
                stomach.slimeZ = e.posZ;
                data.markDirty();
            }
            return;
        }
        if (e == null && !world.isBlockLoaded(new BlockPos(stomach.slimeX, stomach.slimeY, stomach.slimeZ))) {
            stomach.missingChecks = 0;
            return;
        }
        if (++stomach.missingChecks >= 5) free(data, stomach, "as it vanishes");
    }
}
