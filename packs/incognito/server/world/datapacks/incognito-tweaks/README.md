Datapack shipped into incognito's world/ by start.py (packs/incognito/server/world is rsynced every start).
- Energized Power fluid_pump / advanced_fluid_pump: uncraftable (Baughn, 2026-10-14, Discord msg 1560022795516125275):
  lake oil should come out through the EA pump; EP pumps would drain it at FE cost.
- Non-EA generators: uncraftable and hidden from JEI via c:hidden_from_recipe_viewers (Baughn, 2026-10-17, Discord msg
  1561014459127042149). EP coal_engine, inventory_coal_engine, heat/thermal/lightning_generator, solar_panel_1..7;
  ID coal_generator; AE2 vibration_chamber. AE2 crystal_resonance_generator is kept on purpose.
  Regenerate with ~minecraft/agent/tools/incognito-disable-generators.py DATAPACK_DIR.
- EA 50V/200V Turbine (the old heat turbines): hidden from JEI only, in the same tag (Baughn, 2026-10-21); not craftable anyway.
