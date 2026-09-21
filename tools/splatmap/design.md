# Splatmap design

Status: draft for review, 2026-09-21. No implementation or performance measurements
exist yet. The initial experiment and its deferred scope are agreed; implementation
details below are proposals unless identified as existing configuration.

## Purpose

Build a potential Dynmap replacement for a heavily modded Minecraft server. Use
Minecraft's own client renderer to capture modded geometry and appearance, then
produce Gaussian splats for an interactive browser map. The intended experience
is a relatively recent bird's-eye view with freely adjustable viewing angles,
eventually including selected building interiors.

The long-term service runs capture and reconstruction overnight on the user's
desktop, avoids competing with desktop use, and updates changed areas in batches.
High-quality shader rendering is desirable because capture does not need to run at
interactive frame rates. Reconstruction quality, resource cost, and shader
compatibility still need to be established experimentally.

## Existing environment

- [e36](../../builder.nix) pins Minecraft **1.12.2** and server Cleanroom
  **0.6.12-alpha**.
- The client configuration specifies Forge **14.23.5.2864**. The
  [manifest](../../manifest/e36.yaml) offers the improved Cleanroom launcher as a
  client mod; the actual Prism instance's runtime must be inspected before choosing
  capture hooks or build dependencies.
- The user has a Prism Launcher instance configured to log into the running
  server with their normal Minecraft account. Spawn has suitable existing buildings.
- The intended capture and training GPU is the user's **RTX 4090 (24 GB VRAM)**.
  CUDA availability and the usable training budget have not been validated.
- [Live inspector](../../mods/live-inspector/README.md) provides an example of
  custom server instrumentation and isolated tests for the pinned Cleanroom
  version. It is a reference for later server work, not a capture dependency.
- No existing empty-server pause mechanism has been established by the repository
  inspection. The design must not assume one.

## First experiment

Use the existing client and account to capture approximately **64×64 blocks around
spawn**, reconstruct one scene, and view it in a browser. This is a trial footprint,
not a permanent tile size. Choose exact bounds, vertical coverage, and camera
positions after inspecting the site.

The first experiment includes a small client capture mod, reusable capture data,
offline training, a local browser viewer, and an evaluation report. Begin with the
instance's existing renderer configuration and record it. A repeat with a deliberate
high-quality shader profile follows once the baseline works.

It excludes server modification tracking, simulation pausing, observer-only
authentication, automatic nightly scheduling, whole-world coverage, and production
hosting. The normal client may advance the world just as an ordinary player does.
An interior is a follow-up experiment after the exterior pipeline works.

The first result should answer:

1. Does the reconstruction retain enough sharp detail to be useful as a Minecraft
   map, including modded blocks and custom renderers?
2. How much capture time, training time, GPU memory, storage, and browser memory
   does one representative area require?
3. Which viewing angles are supported by the captures, and where do holes,
   floating artifacts, blur, or inconsistent lighting appear?
4. Does a shader profile improve the reconstructed result enough to justify its
   capture and integration costs?

## Proposed pipeline

```text
camera route + capture profile
            ↓
Prism Minecraft client + capture mod
            ↓
dataset: colour, depth, camera matrices, metadata
            ↓
offline reconstruction → exported splat scene → browser viewer
```

Keep Minecraft-specific capture separate from the training dataset adapter and
viewer. A saved dataset should support repeated training experiments without
reconnecting to the server. Record versions and parameters so results are
comparable. Run capture and GPU training sequentially by default.

### Capture client

Use a small client mod for explicit camera control and framebuffer export. Prism
continues to handle normal account login. WayVNC or a similar desktop session can
help inspect an unattended client later; it is not the image capture interface.

For each pose, the client should:

1. Move to the requested camera position and orientation.
2. Wait for the required chunk data, client meshes, and lighting work, using
   observable readiness where available and a bounded settling period otherwise.
3. Allow the renderer to settle, including temporal shader history when applicable.
4. Export colour, matching depth, and the actual matrices for the captured frame.
5. Record completion or an explicit failure. A timeout must not silently become a
   successful capture of missing terrain.

The movement mechanism remains open: flight/spectator access or a detached client
camera may suffice. A detached camera does not itself make the server send chunks
around it. Establish permissions and chunk coverage before generating the route.

Disable the HUD, hand, camera bobbing, and camera effects that interfere with
reproducibility. Record render distance, resolution, FOV, resource packs, shader
settings, and client/mod versions. Hide or mask transient objects where practical.
Do not assume that loading chunks guarantees all mod-specific visual data has
arrived; inspect representative machines and custom renderers in the actual pack.

One saved image per pose may require multiple rendered frames for convergence.
Colour and depth must correspond to the same camera and scene state. Shader depth
buffers, temporal jitter, transparent surfaces, and postprocessing need explicit
validation; the final framebuffer depth is not automatically the desired geometry.

### Dataset contract

Choose a concrete, versioned schema during implementation. It must preserve:

- Dataset identity, dimension, target bounds, a local origin, capture profile,
  route, timestamps, and relevant runtime versions.
- Stable frame IDs, requested poses, actual view/projection matrices, image
  dimensions, and the files belonging to each completed frame.
- Documented coordinate axes, handedness, matrix layout and transform direction;
  retain a reversible mapping to Minecraft coordinates, with one block as one unit.
- Lossless colour with a stated colour-space convention, and floating-point or
  equivalently precise depth with explicit units, depth convention, and invalid
  values. Raw nonlinear depth needs sufficient metadata for correct conversion.
- Masks for invalid pixels and, when available, sky, transient objects, or materials
  excluded from depth supervision.
- Separate training and held-out evaluation views, readiness outcomes, and timing.

Use local scene coordinates to avoid unnecessary precision loss far from the world
origin. Keep raw buffers or enough metadata to reproduce conversions. Validation
must catch missing files, invalid matrices, and colour/depth misalignment before
training. Generated data lives outside the source tree; reports can link to it.

### Camera coverage and live-world consistency

Use overlapping views from translated positions at several heights and oblique
angles. Turning in place does not provide the parallax of camera translation.
Include wall and roof coverage; overhead-only capture is insufficient. Camera
positions may lie outside the target bounds, and images will include surroundings.
Distinguish reconstruction bounds from capture bounds and handle background/sky
explicitly so they do not become spurious local geometry.

Capture during a quiet period and keep each pass reasonably short. The first
experiment does not freeze server time, weather, entities, or machines. Record
these changes and inspect their effects. Client-side visual overrides may help,
but cannot be assumed to freeze every mod's animation or state.

Reserve viewpoints for evaluation before training. Include nearby intermediate
views and more difficult angles to distinguish interpolation quality from missing
coverage. Free camera controls do not imply good reconstruction from every angle.

### Reconstruction

Known camera poses remove the need to estimate camera motion. They do not supply
surface geometry. Export the actual projection as well as the pose, back-project
valid depth pixels into an initial point cloud, and evaluate depth-supervised
training to keep surfaces near their observed positions.

Use valid opaque depth first; glass, water, foliage cutouts, and shader effects
need material-aware treatment or exclusion where depth is unreliable. Keep depth
supervision optional in the dataset adapter so its benefit can be measured.

[gsplat](https://github.com/nerfstudio-project/gsplat) is a candidate foundation,
not a selected or integrated trainer. Prototype data loading, initialization,
depth losses, training settings, and export compatibility before committing to a
particular pipeline. Known poses and the local coordinate system must stay fixed
unless an experiment explicitly documents otherwise.

Record training parameters, seed, runtime, peak memory, splat count, output size,
and checkpoints. The 4090 is a promising starting point, not evidence that an
arbitrary area or full nightly workload will fit.

### Browser viewer and evaluation

Start with one local scene and basic orbit/free-camera navigation.
[Spark](https://sparkjs.dev/docs/lod-getting-started/) is a candidate viewer with
streaming and level-of-detail support for later regional maps. Validate the chosen
trainer's export format in the viewer early.

Compare rendered splats against held-out Minecraft captures with the same camera
projection. Inspect sharp block edges, rooflines, fences, foliage, glass, water,
small textures/text, and modded machinery where present. Record omissions rather
than requiring the first site to contain every material. Also inspect movement
through the scene: still images alone can hide unstable appearance and holes.

Report visual comparisons alongside download size, load time, browser frame time,
and memory where measurable. Numeric image metrics can supplement inspection, but
live-world animation and lighting changes may confound them. The user judges
whether the result is useful enough to continue; no quality threshold is yet set.

## Later unattended service

These are future design directions, not prerequisites for the first scene.

### Server observer and scheduling

A server mod would authenticate a dedicated capture observer using a password or
equivalent dedicated credential, separately from normal Microsoft player login.
It would allow rendering clients to receive world data without counting as gameplay
players. The credential must authorize the observer role specifically.

Keeping an observer connected while simulation is frozen requires more than
excluding it from a player count: networking, chunk loading, lighting, and mod
synchronization may depend on work normally driven by ticks. Define and test that
boundary on the full pack. Loading chunks can also invoke mod callbacks even when
ordinary world ticking is disabled.

Capture should yield when a real player joins. The nightly worker should stop or
checkpoint GPU work when desktop use resumes and respect a configured work window.
Keep scheduling, capture eligibility, and training eligibility separate: training
uses saved data, whereas capture touches the server. Decide the exact player-online
policy during this phase. Interrupted captures must not mix incompatible world
states silently.

A separate instance reading a consistent saved-world snapshot remains an
alternative if serving chunks from a frozen live server is impractical. It adds
storage and synchronization work; it is not the selected architecture today.

### Regional updates and publication

Track dirty regions conservatively, including relevant block-entity and other
visual state changes, not only player block placement. Account for neighboring
geometry, shadows, and occlusion; the invalidation radius remains experimental.
Periodic refreshes can cover changes the hooks cannot observe reliably.

Train replaceable regions with surrounding context. Establish boundary ownership
or another tested composition method to avoid seams and doubled surfaces. Keep a
region's local origin and Minecraft transform in its published metadata. Browser
streaming and level of detail should bound memory as coverage grows.

Publish completed versions atomically while preserving the previous usable map.
Associate jobs with region revisions so edits during processing stay dirty and an
older completed job cannot overwrite a newer result. Record capture age for users.

Interior routes need explicit coverage of rooms and corridors. Their discovery,
navigation, and presentation alongside exterior scenes remain later decisions.

## Decisions to resolve through the prototype

- Actual Prism runtime, renderer, camera movement access, spawn coordinates, and
  suitable capture bounds.
- Practical readiness checks and RGB/depth extraction points on this client stack.
- Route density, image resolution, depth sampling, and treatment of backgrounds.
- Trainer, depth supervision, splat representation/export, and browser viewer.
- Whether block edges and modded details remain sufficiently crisp at useful sizes.
- Whether shader capture and interiors warrant the additional work.

## Technical references

- [Original Gaussian splatting implementation](https://github.com/graphdeco-inria/gaussian-splatting):
  synthetic dataset support, point-cloud initialization, and depth regularization.
- [DN-Splatter](https://arxiv.org/abs/2403.17822): depth and normal supervision as
  supporting evidence for using geometry cues. It does not establish Minecraft
  compatibility or expected performance.
- [gsplat](https://github.com/nerfstudio-project/gsplat): candidate CUDA training
  foundation.
- [Spark LOD and streaming](https://sparkjs.dev/docs/lod-getting-started/): candidate
  browser rendering foundation.
