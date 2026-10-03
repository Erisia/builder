package org.erisia.danknullmigrate;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import net.minecraft.item.Item;
import net.minecraft.item.ItemStack;
import net.minecraft.nbt.NBTTagCompound;
import net.minecraft.nbt.NBTTagList;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.AttachCapabilitiesEvent;
import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLPreInitializationEvent;
import net.minecraftforge.fml.common.event.FMLServerStoppingEvent;
import net.minecraftforge.fml.common.eventhandler.EventPriority;
import net.minecraftforge.fml.common.eventhandler.SubscribeEvent;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * Carries dank null contents across the DankNull 1.7.91 -> 1.7.95+ storage change.
 *
 * 1.7.91 merged the handler's NBT into the stack's root tag; 1.7.95+ reads only tag.DankNullCap and ignores
 * (but keeps) the root keys. When a dank null stack is built from NBT (inventories, containers, docks), this
 * moves the old keys into DankNullCap before DankNull's lazy first read, and deletes them from the root:
 * left behind, they would match again after the dank null is emptied and bring the items back.
 *
 * Entries without an explicit extraction mode get KEEP_ALL, the 1.7.91 default (1.7.97 changed it to KEEP_1).
 */
@Mod(modid="erisia_danknull_migrate", name="Erisia DankNull Migrate", version="1.0.0",
     serverSideOnly=true, acceptableRemoteVersions="*")
public final class DankNullMigrate {
    static final Logger LOG = LogManager.getLogger("DankNullMigrate");
    static final String DANK_NULL_CLASS = "p455w0rd.danknull.items.ItemDankNull";
    static final String CAP = "DankNullCap";
    static final String INVENTORY = "danknull-inventory";
    static final String EXTRACTION = "ExtractionModes";
    static final String[] KEYS = {INVENTORY, "OreDictModes", EXTRACTION, "PlacementModes", "selectedIndex", "Locked"};
    static final int KEEP_ALL = 0, TAG_COMPOUND = 10;

    static final AtomicLong migrated = new AtomicLong(), skipped = new AtomicLong(), failed = new AtomicLong();
    private static volatile Class<?> dankNullClass;

    @Mod.EventHandler public void preInit(FMLPreInitializationEvent event) {
        MinecraftForge.EVENT_BUS.register(this);
    }

    @Mod.EventHandler public void stopping(FMLServerStoppingEvent event) {
        LOG.info("Totals this run: {} migrated, {} skipped, {} failed", migrated.get(), skipped.get(), failed.get());
    }

    @SubscribeEvent(priority=EventPriority.HIGHEST)
    public void attach(AttachCapabilitiesEvent<ItemStack> event) {
        try {
            ItemStack stack = event.getObject();
            Item item = stack.func_77973_b();
            if (item == null || !isDankNull(item)) return;
            NBTTagCompound tag = stack.func_77978_p();
            if (tag != null && tag.func_74764_b(INVENTORY)) migrate(item, tag);
        } catch (Throwable t) {
            // This runs inside ItemStack construction during chunk and player loading: never let it escape.
            failed.incrementAndGet();
            LOG.error("Migration failed for a dank null; its old contents are left in place", t);
        }
    }

    private static boolean isDankNull(Item item) {
        Class<?> known = dankNullClass;
        if (known != null) return known == item.getClass();
        if (!item.getClass().getName().equals(DANK_NULL_CLASS)) return false;
        dankNullClass = item.getClass();
        return true;
    }

    static void migrate(Item item, NBTTagCompound tag) {
        String what = item.getRegistryName() + " (" + summary(tag.func_150295_c(INVENTORY, TAG_COMPOUND)) + ")";
        if (tag.func_150297_b(CAP, TAG_COMPOUND) && tag.func_74775_l(CAP).func_74764_b(INVENTORY)) {
            // Items were put in after the update without this mod. Merging could duplicate or overwrite; leave both.
            skipped.incrementAndGet();
            LOG.warn("Not migrating {}: it already holds new-format contents ({}); old contents left in the root tag",
                     what, summary(tag.func_74775_l(CAP).func_150295_c(INVENTORY, TAG_COMPOUND)));
            return;
        }
        NBTTagCompound cap = new NBTTagCompound();
        for (String key : KEYS) {
            if (tag.func_74764_b(key)) cap.func_74782_a(key, tag.func_74781_a(key).func_74737_b());
        }
        int pinned = pinKeepAll(cap);
        tag.func_74782_a(CAP, cap);
        for (String key : KEYS) tag.func_82580_o(key);
        migrated.incrementAndGet();
        LOG.info("Migrated {}; pinned KEEP_ALL on {} entries", what, pinned);
    }

    /** Adds an explicit KEEP_ALL extraction mode for every stored item that has no mode yet. */
    static int pinKeepAll(NBTTagCompound cap) {
        NBTTagList inventory = cap.func_150295_c(INVENTORY, TAG_COMPOUND);
        NBTTagList modes = cap.func_150297_b(EXTRACTION, 9) ? cap.func_150295_c(EXTRACTION, TAG_COMPOUND) : new NBTTagList();
        List<NBTTagCompound> known = new ArrayList<>();
        for (int i = 0; i < modes.func_74745_c(); i++) known.add(identity(modes.func_150305_b(i).func_74775_l("Stack")));
        int pinned = 0;
        for (int i = 0; i < inventory.func_74745_c(); i++) {
            NBTTagCompound entry = inventory.func_150305_b(i);
            // DankNull's reader stops at the first duplicate mode entry, so add each item at most once.
            NBTTagCompound id = identity(entry);
            if (known.contains(id)) continue;
            known.add(id);
            NBTTagCompound stack = entry.func_74737_b();
            stack.func_82580_o("Slot");
            stack.func_82580_o("Count");
            stack.func_74774_a("Count", (byte)1);
            NBTTagCompound mode = new NBTTagCompound();
            mode.func_74768_a("Mode", KEEP_ALL);
            mode.func_74782_a("Stack", stack);
            modes.func_74742_a(mode);
            pinned++;
        }
        if (pinned > 0) cap.func_74782_a(EXTRACTION, modes);
        return pinned;
    }

    /** Item identity ignoring count, as DankNull compares it (item, damage, tag); compared with NBT equals. */
    static NBTTagCompound identity(NBTTagCompound stack) {
        NBTTagCompound id = new NBTTagCompound();
        for (String key : new String[]{"id", "Damage", "tag"}) {
            if (stack.func_74764_b(key)) id.func_74782_a(key, stack.func_74781_a(key));
        }
        return id;
    }

    static String summary(NBTTagList inventory) {
        long items = 0;
        for (int i = 0; i < inventory.func_74745_c(); i++) items += inventory.func_150305_b(i).func_74762_e("Count");
        return inventory.func_74745_c() + " slots, " + items + " items";
    }
}
