# IE Mixer — Fluid Tank Model (Minecraft 1.20.1)

Research date: 2026-07-08
Repo: https://github.com/BluSunrize/ImmersiveEngineering — branch `1.20.1`

## TL;DR

- The Mixer has **ONE** internal fluid tank, but it is a `MultiFluidTank` — a single
  **8000 mB** (8 buckets) pool that can hold **multiple distinct fluids at once** as separate
  entries in a list, all sharing the same 8000 mB capacity.
- **Input and output fluids live in the SAME tank.** A craft drains the input fluid and adds
  the output fluid into the same pool as a second entry.
- **The conversion is strictly 1:1 by volume.** Every tick it drains N mB of input and fills
  the *same* N mB of output. The tank volume is conserved during a craft, so it can never
  overflow from the conversion itself (the code says so explicitly).
- The recipe's declared **`fluidInput` amount is only a match threshold**; the amount actually
  consumed equals the **output** amount (`fluidOutput.getAmount()`), 1 mB per process-tick.

## Files read (branch 1.20.1)

- `src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/logic/mixer/MixerLogic.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/logic/mixer/MixerLogic.java
- `src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/logic/mixer/MixingProcess.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/logic/mixer/MixingProcess.java
- `src/api/java/blusunrize/immersiveengineering/api/crafting/MixerRecipe.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/api/java/blusunrize/immersiveengineering/api/crafting/MixerRecipe.java
- `src/main/java/blusunrize/immersiveengineering/common/util/inventory/MultiFluidTank.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/main/java/blusunrize/immersiveengineering/common/util/inventory/MultiFluidTank.java
- `src/api/java/blusunrize/immersiveengineering/api/crafting/FluidTagInput.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/api/java/blusunrize/immersiveengineering/api/crafting/FluidTagInput.java
- `src/api/java/blusunrize/immersiveengineering/api/crafting/MultiblockRecipe.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/api/java/blusunrize/immersiveengineering/api/crafting/MultiblockRecipe.java
- `src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/process/MultiblockProcessInMachine.java`
  https://github.com/BluSunrize/ImmersiveEngineering/blob/1.20.1/src/main/java/blusunrize/immersiveengineering/common/blocks/multiblocks/process/MultiblockProcessInMachine.java

Note: the 1.20.1 Mixer is implemented in the newer "multiblock logic" architecture
(`logic/mixer/…`), NOT the older `metal/MixerTileEntity`. There is no
`MixerBlockEntity.java` on this branch.

---

## Q1. Tank model & capacity

**One tank, of type `MultiFluidTank`, capacity 8000 mB.** `MixerLogic.State`:

```java
public static final int TANK_VOLUME = 8*FluidType.BUCKET_VOLUME;   // = 8000 mB
...
public final MultiFluidTank tank = new MultiFluidTank(TANK_VOLUME);
```

`MultiFluidTank` is a single capacity pool holding a *list* of fluid stacks:

```java
public class MultiFluidTank implements IFluidTank, IFluidHandler {
    public List<FluidStack> fluids = new ArrayList<>();
    private final int capacity;
    ...
    public int getFluidTypes() { return fluids.size(); }

    @Override public int getFluidAmount() {           // total across ALL fluids
        int sum = 0;
        for(FluidStack fs : fluids) sum += fs.getAmount();
        return sum;
    }

    @Override public int fill(FluidStack resource, FluidAction action) {
        int space = this.capacity-getFluidAmount();   // shared capacity
        int toFill = Math.min(resource.getAmount(), space);
        ...
        // merges into an existing matching entry, else adds a new list entry
    }
}
```

So there is a single 8000 mB budget shared by however many distinct fluids are present.
The external capabilities are two *views* of that one tank:

```java
this.fluidInput  = new StoredCapability<>(ArrayFluidHandler.fillOnly(tank, ...));   // fill-only view
this.fluidOutput = new StoredCapability<>(ArrayFluidHandler.drainOnly(tank, ...));  // drain-only view
```

They are fill-only / drain-only wrappers around the *same* `tank`.

## Q2. Where does the output fluid go?

Into the **same tank**, as an additional entry alongside the input fluid. It does NOT replace
the input in place and there is no separate output tank. `MixingProcess.doProcessTick`:

```java
int amount = levelData.recipe().fluidAmount/levelData.maxTicks();   // per-step mB
...
FluidStack drained = this.tank.drain(levelData.recipe().fluidInput.withAmount(amount), FluidAction.EXECUTE);
if(!drained.isEmpty()) {
    ...
    FluidStack output = levelData.recipe().getFluidOutput(drained, components);
    FluidStack fs = Utils.copyFluidStackWithAmount(output, drained.getAmount(), false);  // amount == drained
    this.tank.fill(fs, FluidAction.EXECUTE);    // added into the SAME tank
}
```

Critical detail: the output stack's amount is forced to `drained.getAmount()` — i.e. the tank
fills **exactly as much output as it just drained of input.** The conversion is volume-neutral,
1 mB output per 1 mB input, and it happens incrementally (roughly 1 mB per process-tick, since
`amount = fluidAmount/maxTicks` and `maxTicks = fluidOutput.getAmount()`; see Q4).

While a craft runs, the tank therefore holds two entries: the shrinking input fluid A and the
growing output fluid B. `MultiFluidTank.getFluid()` returns the **last** list entry
("//grabbing the last fluid, for output reasons") — i.e. the freshly-added product B — which is
what the auto-output pushes out (Q5).

## Q3. When does the Mixer refuse to start / continue?

Three gates, none of which is a "not enough room for output" check.

**(a) Enqueue gate** — `MixerLogic.enqueueNewRecipes` won't queue a new craft unless there is
energy and fluid present:

```java
if(state.energy.getEnergyStored() <= 0 || processQueue.size() >= state.processor.getMaxQueueSize())
    return RecipeEnqueueState.NOP;
if(state.tank.getFluidAmount() <= 0)
    return RecipeEnqueueState.NOP;
```

and the recipe must `match` — `MixerRecipe.matches` → `FluidTagInput.test`:

```java
@Override public boolean test(FluidStack fluidStack) {
    return testIgnoringAmount(fluidStack) && fluidStack.getAmount() >= this.amount;
}
```

So to *start*, the tank must contain at least the recipe's declared `fluidInput` amount of the
input fluid (this is the *only* place that amount is used).

**(b) Per-tick continue gate** — `MixingProcess.canProcess`:

```java
@Override public boolean canProcess(ProcessContextInMachine<MixerRecipe> context, Level level) {
    ...
    // we don't need to check filling since after draining 1 mB of input fluid there will be space for 1 mB of output fluid
    return context.getEnergy().extractEnergy(levelData.energyPerTick(), true)==levelData.energyPerTick()
        && !tank.drain(levelData.recipe().fluidInput.withAmount(1), FluidAction.SIMULATE).isEmpty();
}
```

To advance a tick it needs (1) enough energy for that tick, and (2) at least **1 mB of the
input fluid** still drainable. If the input fluid runs dry the process simply **pauses** (waits)
until refilled — it is not cleared.

**There is deliberately NO "room for output" check.** The comment spells it out: because each
tick drains 1 mB of input *before* filling 1 mB of output, the freed space always fits the
output. This means:

- A tank that is **completely full (8000/8000) of pure input fluid can still process** — it
  drains 1, fills 1, forever volume-neutral.
- Different input A and output B **coexist** in the one tank (it is multi-fluid); the tank holds
  both, capped only by the shared 8000 mB total.

The only way "fullness" hurts you is indirectly: if the tank is full you cannot *add more input*
via the input port (`fill` returns 0 once `getFluidAmount()==capacity`). Processing of what's
already inside continues regardless.

## Q4. Your "250 mB in → 4000 mB out" recipe — trace

**Important correction to the premise: the IE Mixer cannot multiply fluid volume. It is
hard-wired 1:1.** In `MixerRecipe` the recipe's process length and consumed amount are both
derived from the **output** amount:

```java
this.fluidAmount = fluidOutput.getAmount();          // = 4000 in your recipe
setTimeAndEnergy(fluidOutput.getAmount(), energy);   // totalProcessTime (maxTicks) = 4000
```

and each process-tick drains `fluidAmount/maxTicks` (= 1 mB) of the **input** fluid and fills
the same 1 mB of output. Over the whole craft it therefore **drains 4000 mB of the input fluid**
and produces 4000 mB of output — NOT 250 mB in / 4000 mB out.

The `250` you put on `fluidInput` would only act as the *start threshold* in
`FluidTagInput.test` (need ≥250 mB present to begin). Actual consumption tracks the output
amount, 1:1. So:

- With input A and output B being different fluids, across the craft the tank goes from
  "4000 A" → (converts 1 mB/tick) → "0 A + 4000 B", passing through mixed states like
  "3999 A + 1 B", "3998 A + 2 B", … The **total volume in the tank stays constant** at every
  step (drain-then-fill), so it never overflows and never needs headroom.
- It will **not stall on volume**. It *will* pause if the input fluid drops below 1 mB
  (`canProcess`) or if energy is insufficient.

If you genuinely need a 250→4000 multiplier, the IE Mixer is the wrong machine / that recipe
shape is not expressible here — authoring `fluidInput=250, fluidOutput=4000` yields
4000-in → 4000-out behavior, and takes 4000 base ticks (scaled by energy throughput and the
recipe's `getMultipleProcessTicks()==7` batching).

## Q5. Recommended automation pattern

Port layout (relative positions, from `MixerLogic`):

```java
private static final MultiblockFace     OUTPUT_POS   = new MultiblockFace(1, 0, 3, RelativeBlockFace.FRONT); // auto-push target
private static final CapabilityPosition FLUID_OUTPUT = new CapabilityPosition(1, 0, 2, RelativeBlockFace.BACK);  // drain-only port
private static final CapabilityPosition FLUID_INPUT  = new CapabilityPosition(0, 0, 1, RelativeBlockFace.RIGHT); // fill-only port
private static final CapabilityPosition ENERGY_INPUT = new CapabilityPosition(0, 1, 2, RelativeBlockFace.UP);
private static final BlockPos           ITEM_INPUT   = new BlockPos(1, 1, 0);
```

- **Fluid IN:** pump the input fluid into the fill-only fluid port (`FLUID_INPUT`, the
  `ArrayFluidHandler.fillOnly` view).
- **Energy IN:** on `ENERGY_INPUT`. **Items IN:** into `ITEM_INPUT` (8 slots, `ANY_INPUT`).
- **Fluid OUT:** two options —
  1. **Auto-push:** the Mixer actively pushes product out of `OUTPUT_POS` (front) to an adjacent
     fluid handler, up to **1000 mB/tick (one bucket)**. See `MixerLogic.outputFluids`.
  2. **Pull:** drain from the drain-only port `FLUID_OUTPUT` (back).

Auto-output logic (default `outputAll=false`) is selective so it doesn't eject the input fluid:

```java
private boolean outputFluids(State state, boolean foundRecipe) {
    int fluidTypes = state.tank.getFluidTypes();
    if(fluidTypes <= 0 || (fluidTypes <= 1 && foundRecipe && !state.outputAll))
        return false;                              // if only the (matching) input fluid is present, keep it
    ...
    FluidStack inTank = state.tank.getFluid();     // last entry = the product
    final int maxAmount = Math.min(inTank.getAmount(), FluidType.BUCKET_VOLUME);  // ≤1000 mB/tick
    ...
}
```

So while only the input fluid sits in the tank and it matches a recipe, nothing is pushed out;
once conversion produces a *second* fluid (the product), the product (last list entry) is pushed
out at up to 1 bucket/tick. There is also an `outputAll` toggle (GUI) that instead ejects
everything at up to 1 bucket/tick total.

**To keep it running continuously:**
- Keep energy and item ingredients supplied, and keep the input fluid topped up (it needs ≥1 mB
  of input every tick to advance).
- **Continuously drain the output** — either place a tank/pipe on the front `OUTPUT_POS` to catch
  the auto-pushed product, or pull from the back `FLUID_OUTPUT` port. The tank is a shared
  8000 mB pool, so if you never remove product it fills up with product and, once full, no new
  input can be pumped in (in-progress conversion still completes, but throughput halts).
- Because output leaves at ≤1000 mB/tick, sustained throughput is capped at ~1 bucket/tick of
  product regardless of how fast you feed input.
