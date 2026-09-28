package org.erisia.slimestomach;

import java.util.Collections;
import java.util.List;
import javax.annotation.Nullable;
import net.minecraft.entity.EnumCreatureType;
import net.minecraft.init.Biomes;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.World;
import net.minecraft.world.biome.Biome;
import net.minecraft.world.chunk.Chunk;
import net.minecraft.world.chunk.ChunkPrimer;
import net.minecraft.world.gen.IChunkGenerator;

/** Empty chunks in the Void biome: nothing generates, nothing populates, nothing spawns. */
public class VoidChunkGenerator implements IChunkGenerator {
    private final World world;

    public VoidChunkGenerator(World world) {
        this.world = world;
    }

    @Override
    public Chunk generateChunk(int x, int z) {
        Chunk chunk = new Chunk(world, new ChunkPrimer(), x, z);
        byte[] biomes = chunk.getBiomeArray();
        byte voidId = (byte) Biome.getIdForBiome(Biomes.VOID);
        for (int i = 0; i < biomes.length; i++) biomes[i] = voidId;
        chunk.generateSkylightMap();
        // Already "populated": keeps other mods' world generators (ores, structures) out of the void.
        chunk.setTerrainPopulated(true);
        return chunk;
    }

    @Override
    public void populate(int x, int z) {
    }

    @Override
    public boolean generateStructures(Chunk chunk, int x, int z) {
        return false;
    }

    @Override
    public List<Biome.SpawnListEntry> getPossibleCreatures(EnumCreatureType type, BlockPos pos) {
        return Collections.emptyList();
    }

    @Nullable
    @Override
    public BlockPos getNearestStructurePos(World world, String name, BlockPos pos, boolean findUnexplored) {
        return null;
    }

    @Override
    public void recreateStructures(Chunk chunk, int x, int z) {
    }

    @Override
    public boolean isInsideStructure(World world, String name, BlockPos pos) {
        return false;
    }
}
