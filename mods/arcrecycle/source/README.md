# Arc Recycling Blacklist (arcrecycle)

Server-side Forge 1.12.2 mod for E36. Removes configured items from Immersive Engineering's Arc Furnace
recycling recipes (`config/arcrecycle.cfg`, `blacklist`). Default: steel and aluminium scaffolding, which the
pack's block duplicators make from RF alone; recycling turned them into ~4 nuggets each (lab, 2026-10-02).

Why not CraftTweaker: IE's CT `ArcFurnace.removeRecipe` matches by output, and recycling recipes have none
(generated at startup from the crafting registry). This mod removes them from `ArcFurnaceRecipe.recipeList`
via reflection at load-complete and again at server start. No hard dependency on IE.

Build: `../tools/build.sh`-style gradle build (CleanroomMC TemplateDevEnv).
