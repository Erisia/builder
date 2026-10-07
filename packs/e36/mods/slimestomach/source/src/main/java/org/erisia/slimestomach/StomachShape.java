package org.erisia.slimestomach;

import java.util.ArrayDeque;
import java.util.Random;

/**
 * A stomach's layout inside an N^3 box: a lumpy cavity made of a few overlapping random
 * ellipsoids, a slime wall around it (every cell touching the cavity, diagonals included)
 * and bedrock around that. Pure Java so it can be tried out without Minecraft.
 */
public class StomachShape {
    public static final int N = 15;
    public static final byte OUTSIDE = 0, CAVITY = 1, WALL = 2, BEDROCK = 3;

    /** Indexed by {@link #index}. */
    public final byte[] cells = new byte[N * N * N];
    public int spawn = -1;
    public int minY = N, maxY = -1;

    public static int index(int x, int y, int z) {
        return (y * N + z) * N + x;
    }

    public static int x(int i) {
        return i % N;
    }

    public static int z(int i) {
        return (i / N) % N;
    }

    public static int y(int i) {
        return i / (N * N);
    }

    public byte at(int x, int y, int z) {
        if (x < 0 || y < 0 || z < 0 || x >= N || y >= N || z >= N) return OUTSIDE;
        return cells[index(x, y, z)];
    }

    public boolean isCavity(int x, int y, int z) {
        return at(x, y, z) == CAVITY;
    }

    public static StomachShape generate(Random rand) {
        for (int attempt = 0; ; attempt++) {
            StomachShape s = new StomachShape();
            s.carve(rand);
            s.keepConnected();
            s.findSpawn();
            if (s.spawn >= 0 || attempt >= 20) {
                if (s.spawn < 0) s.carveFallback();
                s.buildWalls();
                return s;
            }
        }
    }

    public static StomachShape fromCavity(int[] cavity, int spawn) {
        StomachShape s = new StomachShape();
        for (int i : cavity) s.cells[i] = CAVITY;
        s.spawn = spawn;
        s.buildWalls();
        return s;
    }

    public int[] cavity() {
        int n = 0;
        for (byte b : cells) if (b == CAVITY) n++;
        int[] out = new int[n];
        n = 0;
        for (int i = 0; i < cells.length; i++) if (cells[i] == CAVITY) out[n++] = i;
        return out;
    }

    /** A random walk of lumps. The cavity must stay 2 cells from the box edge for wall and bedrock. */
    private void carve(Random rand) {
        double lo = 3.5, hi = N - 4.5;
        double cx = N / 2.0, cy = 4 + rand.nextDouble() * 2, cz = N / 2.0;
        int lumps = 3 + rand.nextInt(3);
        for (int k = 0; k < lumps; k++) {
            double rx = 1.3 + rand.nextDouble() * 1.2;
            double ry = 1.1 + rand.nextDouble() * 1.0;
            double rz = 1.3 + rand.nextDouble() * 1.2;
            lump(cx, cy, cz, rx, ry, rz);
            double angle = rand.nextDouble() * Math.PI * 2;
            double step = 1.5 + rand.nextDouble() * 1.5;
            cx = clamp(cx + Math.cos(angle) * step, lo, hi);
            cz = clamp(cz + Math.sin(angle) * step, lo, hi);
            cy = clamp(cy + (rand.nextDouble() - 0.5) * 2.5, lo, hi);
        }
    }

    private void lump(double cx, double cy, double cz, double rx, double ry, double rz) {
        for (int y = 2; y < N - 2; y++)
            for (int z = 2; z < N - 2; z++)
                for (int x = 2; x < N - 2; x++) {
                    double dx = (x + 0.5 - cx) / rx, dy = (y + 0.5 - cy) / ry, dz = (z + 0.5 - cz) / rz;
                    if (dx * dx + dy * dy + dz * dz <= 1) cells[index(x, y, z)] = CAVITY;
                }
    }

    private static double clamp(double v, double lo, double hi) {
        return Math.max(lo, Math.min(hi, v));
    }

    /** Keep only the largest connected (face-adjacent) part of the cavity. */
    private void keepConnected() {
        int[] label = new int[cells.length];
        int best = 0, bestSize = 0, next = 0;
        ArrayDeque<Integer> queue = new ArrayDeque<>();
        for (int i = 0; i < cells.length; i++) {
            if (cells[i] != CAVITY || label[i] != 0) continue;
            int id = ++next, size = 0;
            label[i] = id;
            queue.add(i);
            while (!queue.isEmpty()) {
                int c = queue.poll();
                size++;
                int x = x(c), y = y(c), z = z(c);
                int[][] nb = {{x + 1, y, z}, {x - 1, y, z}, {x, y + 1, z}, {x, y - 1, z}, {x, y, z + 1}, {x, y, z - 1}};
                for (int[] p : nb) {
                    if (!isCavity(p[0], p[1], p[2])) continue;
                    int j = index(p[0], p[1], p[2]);
                    if (label[j] == 0) {
                        label[j] = id;
                        queue.add(j);
                    }
                }
            }
            if (size > bestSize) {
                bestSize = size;
                best = id;
            }
        }
        for (int i = 0; i < cells.length; i++) if (cells[i] == CAVITY && label[i] != best) cells[i] = OUTSIDE;
    }

    /** A floor cell with headroom for a player, as near the middle of the cavity as possible. */
    private void findSpawn() {
        double sx = 0, sy = 0, sz = 0;
        int n = 0;
        for (int i = 0; i < cells.length; i++) {
            if (cells[i] != CAVITY) continue;
            sx += x(i);
            sy += y(i);
            sz += z(i);
            n++;
        }
        if (n == 0) return;
        sx /= n;
        sy /= n;
        sz /= n;
        double bestDist = Double.MAX_VALUE;
        for (int i = 0; i < cells.length; i++) {
            int x = x(i), y = y(i), z = z(i);
            if (cells[i] != CAVITY || isCavity(x, y - 1, z) || !isCavity(x, y + 1, z)) continue;
            double d = (x - sx) * (x - sx) + (y - sy) * (y - sy) + (z - sz) * (z - sz);
            if (d < bestDist) {
                bestDist = d;
                spawn = i;
            }
        }
    }

    private void carveFallback() {
        java.util.Arrays.fill(cells, OUTSIDE);
        lump(N / 2.0, 5, N / 2.0, 2, 1.5, 2);
        findSpawn();
    }

    private void buildWalls() {
        for (byte pass = WALL; pass <= BEDROCK; pass++) {
            byte inner = pass == WALL ? CAVITY : WALL;
            byte[] copy = cells.clone();
            for (int i = 0; i < cells.length; i++) {
                if (copy[i] != OUTSIDE) continue;
                int x = x(i), y = y(i), z = z(i);
                outer:
                for (int dy = -1; dy <= 1; dy++)
                    for (int dz = -1; dz <= 1; dz++)
                        for (int dx = -1; dx <= 1; dx++) {
                            int ax = x + dx, ay = y + dy, az = z + dz;
                            if (ax < 0 || ay < 0 || az < 0 || ax >= N || ay >= N || az >= N) continue;
                            if (copy[index(ax, ay, az)] == inner) {
                                cells[i] = pass;
                                break outer;
                            }
                        }
            }
        }
        minY = N;
        maxY = -1;
        for (int i = 0; i < cells.length; i++) {
            if (cells[i] != CAVITY) continue;
            minY = Math.min(minY, y(i));
            maxY = Math.max(maxY, y(i));
        }
    }

    /** Wall cells that face the cavity directly. */
    public boolean isVisibleWall(int i) {
        if (cells[i] != WALL) return false;
        int x = x(i), y = y(i), z = z(i);
        return isCavity(x + 1, y, z) || isCavity(x - 1, y, z) || isCavity(x, y + 1, z)
                || isCavity(x, y - 1, z) || isCavity(x, y, z + 1) || isCavity(x, y, z - 1);
    }

    /** Try it out: java StomachShape.java [seed] */
    public static void main(String[] args) {
        long seed = args.length > 0 ? Long.parseLong(args[0]) : System.nanoTime();
        StomachShape s = generate(new Random(seed));
        int cav = s.cavity().length, walls = 0;
        for (byte b : s.cells) if (b == WALL) walls++;
        System.out.printf("seed %d: cavity %d cells, wall %d, y %d..%d, spawn %d,%d,%d%n", seed, cav, walls,
                s.minY, s.maxY, x(s.spawn), y(s.spawn), z(s.spawn));
        for (int y = s.maxY + 1; y >= s.minY - 1; y--) {
            StringBuilder sb = new StringBuilder("y=" + y + "\n");
            for (int z = 0; z < N; z++) {
                for (int x = 0; x < N; x++) sb.append(" .#B".charAt(s.at(x, y, z)));
                sb.append('\n');
            }
            System.out.print(sb);
        }
    }
}
