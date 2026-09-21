# Splatmap plan

Status: documentation draft, 2026-09-21. Implementation has not started.
Read the [design](design.md) for scope, assumptions, and unresolved choices.

Phases are ordered by dependency. Work on the first capture experiment follows
the user's review of these documents. Later phases depend on experimental results;
they are not commitments to build the complete service.

## Phase 0 — Review the design and plan

- [x] Document the objective, existing e36 environment, and first experiment.
- [x] Separate the regular-client prototype from later server integration.
- [x] Record proposed data flow, validation, risks, and open decisions.
- [ ] User reviews the documents; incorporate agreed changes before implementation.

Completion: the next implementation scope and its success criteria are understood.

## Phase 1 — Establish capture inputs and prove one frame

- [ ] Locate and inspect the existing Prism instance's versions, renderer, mods,
  resource packs, launch environment, and configured server without copying account
  secrets into project files.
- [ ] Verify GPU/CUDA access for the candidate training environment.
- [ ] Choose an approximately 64×64-block spawn area, vertical bounds, and a few
  representative structures. Establish camera movement access and chunk coverage.
- [ ] Choose the capture mod's build integration for the actual client runtime,
  using existing repository patterns where appropriate.
- [ ] Implement export of one aligned colour/depth frame plus actual camera
  matrices and capture metadata. Establish a versioned dataset convention.
- [ ] Validate depth conversion and camera axes using known block positions and
  reprojection into another captured view. Check that HUD/hand are absent and
  incomplete chunk rendering is detected or reported.

Completion: a small inspectable dataset proves correct camera geometry, usable
depth, and correct appearance of representative modded blocks. Resolve capture
alignment before investing in training or route automation.

## Phase 2 — Capture a repeatable exterior dataset

- [ ] Create a deterministic camera route with overlap, translated viewpoints,
  multiple heights, and coverage of walls and roofs.
- [ ] Select held-out evaluation viewpoints before training.
- [ ] Add bounded readiness checks, render settling, per-frame completion records,
  and explicit failure/timeout handling.
- [ ] Capture the area during a quiet period using the existing renderer profile.
  Record changes in daylight, weather, entities, and animated machinery.
- [ ] Validate dataset completeness and inspect colour, depth, and the initialized
  point cloud for missing terrain, invalid background depth, and alignment errors.
- [ ] Keep the route and small reproducibility metadata in source control; store
  bulk captures outside the repository and document their location.

Completion: a reusable exterior dataset with separate evaluation frames and a
measured capture cost. Failed frames are identified explicitly. Retrying after
substantial world changes creates a new pass or recaptures the affected set.

## Phase 3 — Reconstruct and view spawn

- [ ] Choose and pin a trainer, initially evaluating gsplat as a foundation.
- [ ] Implement the dataset adapter, valid-depth point-cloud initialization, and
  explicit scene bounds/background treatment.
- [ ] Run an initial reconstruction with recorded settings and resource usage.
  Evaluate depth supervision; if necessary compare against the same initialization
  without a depth loss.
- [ ] Export a scene and load it in a minimal local browser viewer. Validate format
  compatibility, scale, orientation, and Minecraft coordinate mapping.
- [ ] Render held-out viewpoints with matching projection and inspect interactive
  navigation for blur, holes, floating artifacts, and unstable appearance.
- [ ] Write a report linked from these documents containing representative visual
  comparisons, failure cases, capture/training times, peak GPU memory, splat count,
  file size, and browser performance on a stated device/resolution.

Completion: **a browser-viewable reconstruction of the spawn area and an evidence-based
assessment of its usefulness and cost**. This is the first end-to-end milestone.
Do not extrapolate whole-world throughput from area alone; capture density and
scene complexity also affect cost.

## Phase 4 — Test shaders and one interior

- [ ] Select a shader profile compatible with the actual capture client and verify
  colour/depth alignment, temporal settling, and animation/exposure behavior.
- [ ] Repeat the exterior route and compare against the baseline with comparable
  training settings. Document live-world changes that weaken the comparison.
- [ ] Capture one accessible interior using a separate room/corridor route.
- [ ] Test interior reconstruction, navigation, and its presentation relative to
  the exterior scene.
- [ ] Record whether visual improvements justify the added capture cost and whether
  the resulting quality supports further development.

Completion: a documented decision about the renderer profile, interior support,
and whether to proceed to a regularly updated map. Revisit representation or capture
coverage if splats do not preserve the desired detail.

## Phase 5 — Design and build unattended capture

Expand this phase into a concrete implementation plan after the visual experiments.

- [ ] Define the observer role, authentication, allowed operations, and protocol.
- [ ] Prototype chunk delivery and mod synchronization with simulation frozen on
  an isolated world running the relevant pack; compare a snapshot-based approach
  if live-server freezing proves impractical.
- [ ] Verify observer connections do not trigger normal player-driven simulation,
  and document unavoidable chunk-loading side effects or compatibility limits.
- [ ] Define behavior when real players join, connections fail, and desktop use
  resumes. Exercise those transitions in the isolated environment.
- [ ] Add configurable overnight scheduling, bounded jobs, progress persistence,
  and resumable training. Measure the actual nightly work budget.

Completion: repeatable unattended jobs with verified interruption behavior and an
explicitly tested server simulation contract.

## Phase 6 — Incremental map service

Expand this phase after capture cost and server integration are understood.

- [ ] Choose region sizes from measured quality and resource use.
- [ ] Implement dirty tracking, revision handling, neighbor invalidation, and a
  refresh policy for visual changes that cannot be tracked reliably.
- [ ] Reconstruct adjacent regions and validate boundary composition before
  scaling coverage.
- [ ] Add atomic versioned publication, capture-age metadata, browser streaming,
  level of detail, and dataset/model retention policies.
- [ ] Measure performance across representative terrain and buildings, then choose
  a realistic coverage and freshness target.

Completion: changed regions update within the chosen nightly budget while the
previous published map remains usable throughout capture, training, and failures.

## Validation approach

Documentation-only work needs link and consistency checks, not runtime tests.
During implementation, prioritize meaningful checks of camera transforms, depth
conversion, reprojection, dataset integrity, and interrupted jobs. Use known geometry
for capture checks and held-out views for reconstruction quality. Full-pack visual
inspection remains necessary for custom renderers and shader compatibility.

Use isolated worlds for server pause, observer, and dirty-tracking tests. Keep
experimental results separate from intended behavior, and update the design and
plan when the evidence changes a decision.
