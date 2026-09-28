package org.erisia.slimestomach;

import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;
import net.minecraft.nbt.NBTTagCompound;
import net.minecraft.nbt.NBTTagList;
import net.minecraft.nbt.NBTTagString;
import net.minecraft.util.math.AxisAlignedBB;
import net.minecraft.util.math.BlockPos;

/**
 * One slime's stomach: a {@link StomachShape} placed with its box's minimum corner at {@link #origin}.
 */
public class Stomach {
    public int id;
    public UUID slime;
    /** Where the slime was last seen; occupants are returned here. */
    public int slimeDim;
    public double slimeX, slimeY, slimeZ;
    public int dimension;
    public BlockPos origin;
    public StomachShape shape;
    public String wall = "minecraft:slime", light = "minecraft:glowstone", juice = "blueslime";
    /** Wall blocks broken so far; each one makes the juice stronger. */
    public int wounds;
    /** Ticks spent digesting with someone inside. */
    public int digestTicks;
    public boolean digesting;
    /** Number of juice layers placed so far, 0..layers(). */
    public int fillLevel;
    public int fillTimer;
    public final Set<UUID> occupants = new LinkedHashSet<>();
    public String origName = "";
    public boolean origAlwaysRender;
    /** Consecutive checks in which the slime's chunk was loaded but the slime was missing. */
    public transient int missingChecks;

    public Theme theme() {
        return Theme.of(wall, light, juice);
    }

    public int layers() {
        return shape.maxY - shape.minY + 1;
    }

    public BlockPos spawn() {
        int i = shape.spawn;
        return origin.add(StomachShape.x(i), StomachShape.y(i), StomachShape.z(i));
    }

    public AxisAlignedBB box() {
        return new AxisAlignedBB(origin, origin.add(StomachShape.N, StomachShape.N, StomachShape.N));
    }

    public byte cellAt(BlockPos pos) {
        return shape.at(pos.getX() - origin.getX(), pos.getY() - origin.getY(), pos.getZ() - origin.getZ());
    }

    /** Is pos part of this stomach's structure? */
    public boolean contains(BlockPos pos) {
        return cellAt(pos) != StomachShape.OUTSIDE;
    }

    /** Somewhere a player may legitimately be: the cavity, or a hole broken into the wall. */
    public boolean isInside(BlockPos pos) {
        byte c = cellAt(pos);
        return c == StomachShape.CAVITY || c == StomachShape.WALL;
    }

    public NBTTagCompound write() {
        NBTTagCompound tag = new NBTTagCompound();
        tag.setInteger("id", id);
        tag.setUniqueId("slime", slime);
        tag.setInteger("slimeDim", slimeDim);
        tag.setDouble("slimeX", slimeX);
        tag.setDouble("slimeY", slimeY);
        tag.setDouble("slimeZ", slimeZ);
        tag.setInteger("dim", dimension);
        tag.setLong("origin", origin.toLong());
        tag.setIntArray("cavity", shape.cavity());
        tag.setInteger("spawn", shape.spawn);
        tag.setBoolean("digesting", digesting);
        tag.setString("wall", wall);
        tag.setString("light", light);
        tag.setString("juice", juice);
        tag.setInteger("wounds", wounds);
        tag.setInteger("digestTicks", digestTicks);
        tag.setInteger("fillLevel", fillLevel);
        tag.setInteger("fillTimer", fillTimer);
        NBTTagList list = new NBTTagList();
        for (UUID u : occupants) list.appendTag(new NBTTagString(u.toString()));
        tag.setTag("occupants", list);
        tag.setString("origName", origName);
        tag.setBoolean("origAlwaysRender", origAlwaysRender);
        return tag;
    }

    public static Stomach read(NBTTagCompound tag) {
        Stomach s = new Stomach();
        s.id = tag.getInteger("id");
        s.slime = tag.getUniqueId("slime");
        s.slimeDim = tag.getInteger("slimeDim");
        s.slimeX = tag.getDouble("slimeX");
        s.slimeY = tag.getDouble("slimeY");
        s.slimeZ = tag.getDouble("slimeZ");
        s.dimension = tag.getInteger("dim");
        s.origin = BlockPos.fromLong(tag.getLong("origin"));
        if (!tag.hasKey("cavity")) return null; // from the cube-shaped version
        s.shape = StomachShape.fromCavity(tag.getIntArray("cavity"), tag.getInteger("spawn"));
        s.digesting = tag.getBoolean("digesting");
        if (tag.hasKey("wall")) {
            s.wall = tag.getString("wall");
            s.light = tag.getString("light");
            s.juice = tag.getString("juice");
        }
        s.wounds = tag.getInteger("wounds");
        s.digestTicks = tag.getInteger("digestTicks");
        s.fillLevel = tag.getInteger("fillLevel");
        s.fillTimer = tag.getInteger("fillTimer");
        NBTTagList list = tag.getTagList("occupants", 8);
        for (int i = 0; i < list.tagCount(); i++) s.occupants.add(UUID.fromString(list.getStringTagAt(i)));
        s.origName = tag.getString("origName");
        s.origAlwaysRender = tag.getBoolean("origAlwaysRender");
        return s;
    }
}
