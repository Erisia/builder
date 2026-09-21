# Splatmap

An experimental Dynmap replacement: capture the modded Minecraft client's rendered
world, reconstruct Gaussian splats, and display them in a browser. The initial
experiment uses the existing Prism Launcher instance and the user's normal account
to capture an approximately 64×64-block area around e36 spawn on an RTX 4090.

## Documents

- [Design](design.md): goals, proposed architecture, capture and reconstruction
  requirements, tradeoffs, and open questions.
- [Plan](plan.md): phased work, validation, and completion criteria.
- [Pack configuration](../../builder.nix): e36 versions and packaging.
- [Existing server mod](../../mods/live-inspector/README.md): relevant build and
  isolated Cleanroom test patterns.

Read the design and plan before working here. Keep them current when decisions or
scope change; distinguish proposals from verified behavior and record experimental
results in linked reports. Keep this file short and update its links as needed.

Current scope is documentation for user review. Implementation follows that review.
The first experiment needs no server mod, replacement authentication, modification
tracking, or server pausing. Those belong to later phases.

Keep generated captures, models, checkpoints, and account credentials out of the
repository. Prefer reproducible datasets and meaningful visual comparisons; use
isolated worlds for tests that change server behavior.
