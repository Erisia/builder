package org.erisia.slimestomach;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import net.minecraft.nbt.NBTTagCompound;
import net.minecraft.nbt.NBTTagList;
import net.minecraft.server.MinecraftServer;
import net.minecraft.world.World;
import net.minecraft.world.storage.MapStorage;
import net.minecraft.world.storage.WorldSavedData;

/** All stomachs, plus players who must be sent somewhere when they next log in. Saved globally. */
public class StomachData extends WorldSavedData {
    private static final String NAME = "slimestomach";

    public final List<Stomach> stomachs = new ArrayList<>();
    /** Player -> {dim, x, y, z}: freed while offline. */
    public final Map<UUID, double[]> pendingReturns = new HashMap<>();
    public int nextId = 1;

    public StomachData(String name) {
        super(name);
    }

    public static StomachData get(MinecraftServer server) {
        World overworld = server.getWorld(0);
        MapStorage storage = overworld.getMapStorage();
        StomachData data = (StomachData) storage.getOrLoadData(StomachData.class, NAME);
        if (data == null) {
            data = new StomachData(NAME);
            storage.setData(NAME, data);
        }
        return data;
    }

    public Stomach bySlime(UUID slime) {
        for (Stomach s : stomachs) if (s.slime.equals(slime)) return s;
        return null;
    }

    public Stomach byOccupant(UUID player) {
        for (Stomach s : stomachs) if (s.occupants.contains(player)) return s;
        return null;
    }

    @Override
    public void readFromNBT(NBTTagCompound tag) {
        stomachs.clear();
        pendingReturns.clear();
        nextId = Math.max(1, tag.getInteger("nextId"));
        NBTTagList list = tag.getTagList("stomachs", 10);
        for (int i = 0; i < list.tagCount(); i++) {
            Stomach s = Stomach.read(list.getCompoundTagAt(i));
            if (s != null) stomachs.add(s);
            else SlimeStomach.LOGGER.warn("Dropping a stomach saved by an older version");
        }
        NBTTagList pending = tag.getTagList("pending", 10);
        for (int i = 0; i < pending.tagCount(); i++) {
            NBTTagCompound p = pending.getCompoundTagAt(i);
            pendingReturns.put(p.getUniqueId("player"),
                    new double[] {p.getInteger("dim"), p.getDouble("x"), p.getDouble("y"), p.getDouble("z")});
        }
    }

    @Override
    public NBTTagCompound writeToNBT(NBTTagCompound tag) {
        tag.setInteger("nextId", nextId);
        NBTTagList list = new NBTTagList();
        for (Stomach s : stomachs) list.appendTag(s.write());
        tag.setTag("stomachs", list);
        NBTTagList pending = new NBTTagList();
        for (Map.Entry<UUID, double[]> e : pendingReturns.entrySet()) {
            NBTTagCompound p = new NBTTagCompound();
            p.setUniqueId("player", e.getKey());
            p.setInteger("dim", (int) e.getValue()[0]);
            p.setDouble("x", e.getValue()[1]);
            p.setDouble("y", e.getValue()[2]);
            p.setDouble("z", e.getValue()[3]);
            pending.appendTag(p);
        }
        tag.setTag("pending", pending);
        return tag;
    }
}
