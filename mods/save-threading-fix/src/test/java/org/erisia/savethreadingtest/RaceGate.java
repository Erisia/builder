package org.erisia.savethreadingtest;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

public final class RaceGate {
    public static volatile RaceGate active;
    public final Object loader;
    public final String point;
    public final Thread owner;
    public final CountDownLatch entered = new CountDownLatch(1);
    public final CountDownLatch release = new CountDownLatch(1);

    public RaceGate(Object loader, String point, Thread owner) {
        this.loader = loader;
        this.point = point;
        this.owner = owner;
    }

    public static void pause(Object loader, String point) {
        RaceGate gate = active;
        if (gate == null || gate.loader != loader || !gate.point.equals(point)
                || gate.owner != Thread.currentThread()) return;
        gate.entered.countDown();
        try {
            if (!gate.release.await(10, TimeUnit.SECONDS)) throw new AssertionError("Race gate timed out");
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new AssertionError(e);
        }
    }
}
