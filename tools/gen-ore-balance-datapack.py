#!/usr/bin/env python3
"""Generate the erisia ore-balance datapack for the military pack.

Output lands in base/military/moonlight-global-datapacks/, which Moonlight (Selene)
loads into every world on both sides -- so singleplayer worlds made from the mrpack
get the same ladder as the server.

Ladder (per raw ore):
  furnace                     1.0x
  crushing wheels             1.5x  (1 crushed + 50% second, + 75% xp nugget)
  IE crusher                  2.0x  (2 dusts)
  IE crusher on crushed       1.5x per crushed  -> 2.25x via wheels
  IE arc furnace              2.5x  (2 ingots + 50% third) + slag
  IE arc furnace on crushed   2.0x per crushed  -> 3.0x via wheels
  ore block (silk) keeps a +0.5 bonus at each machine tier
  ore hammer                  1.25x (4 raw + hammer -> 5 dust), metals only
"""
import json, os, shutil

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, '..', 'base', 'military', 'moonlight-global-datapacks', 'erisia-ore-balance')
METALS = ['iron', 'copper', 'gold', 'zinc', 'aluminum', 'lead', 'nickel', 'silver', 'uranium']
HAMMER_METALS = ['iron', 'copper', 'gold']

def w(path, obj):
    p = os.path.join(ROOT, path)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, 'w') as f:
        json.dump(obj, f, indent=2)
        f.write('\n')

def not_empty(tag):
    return {"type": "forge:not", "value": {"type": "forge:tag_empty", "tag": tag}}


# Average vanilla drop per ore block. Copper drops 2-5 raw (avg 3.5); the rest drop 1.
ORE_BASE_DROP = {'copper': 3.5}
ORE_BLOCK_VARIANTS = {
    'iron': ['iron_ore', 'deepslate_iron_ore'],
    'copper': ['copper_ore', 'deepslate_copper_ore'],
    'gold': ['gold_ore', 'deepslate_gold_ore'],
}

def divmod_chance(x):
    """Split an average yield into a whole count plus a chance for one more."""
    whole = int(x)
    return whole, round(x - whole, 3)

def split_count(x, item):
    whole, chance = divmod_chance(x)
    out = [{"count": whole, "item": item}] if whole else []
    if chance:
        out.append({"chance": chance, "item": item})
    return out

if os.path.isdir(ROOT):
    shutil.rmtree(ROOT)

w('pack.mcmeta', {"pack": {"pack_format": 15, "description": "Erisia military: ore processing balance"}})

for m in METALS:
    crushed = f"create:crushed_raw_{m}"
    dust, ingot, raw = f"forge:dusts/{m}", f"forge:ingots/{m}", f"forge:raw_materials/{m}"

    # --- Create: crushing wheels, raw ore -> 1.5x
    w(f'data/create/recipes/crushing/raw_{m}.json', {
        "type": "create:crushing",
        "ingredients": [{"tag": raw}],
        "processingTime": 400,
        "results": [
            {"item": crushed},
            {"chance": 0.5, "item": crushed},
            {"chance": 0.75, "item": "create:experience_nugget"},
        ],
    })

    # --- IE crusher: raw ore -> 2.0x
    w(f'data/immersiveengineering/recipes/crusher/raw_ore_{m}.json', {
        "type": "immersiveengineering:crusher",
        "conditions": [not_empty(dust)],
        "energy": 6000,
        "input": {"tag": raw},
        "result": {"base_ingredient": {"tag": dust}, "count": 2},
        "secondaries": [],
    })

    # --- IE crusher: crushed -> 1.5x per crushed (2.25x via wheels)
    w(f'data/erisia_ore_balance/recipes/crusher/crushed_{m}.json', {
        "type": "immersiveengineering:crusher",
        "conditions": [not_empty(dust)],
        "energy": 4000,
        "input": {"item": crushed},
        "result": {"tag": dust},
        "secondaries": [{"chance": 0.5, "output": {"tag": dust}}],
    })

    # --- IE arc furnace: raw ore -> 2.5x + slag
    w(f'data/immersiveengineering/recipes/arcfurnace/raw_ore_{m}.json', {
        "type": "immersiveengineering:arc_furnace",
        "conditions": [not_empty(ingot)],
        "additives": [],
        "energy": 25600,
        "input": {"tag": raw},
        "results": [{"base_ingredient": {"tag": ingot}, "count": 2}],
        "secondaries": [{"chance": 0.5, "output": {"tag": ingot}}],
        "slag": {"tag": "forge:slag"},
        "time": 100,
    })

    # --- IE arc furnace: crushed -> 2.0x per crushed (3.0x via wheels)
    w(f'data/erisia_ore_balance/recipes/arcfurnace/crushed_{m}.json', {
        "type": "immersiveengineering:arc_furnace",
        "conditions": [not_empty(ingot)],
        "additives": [],
        "energy": 20480,
        "input": {"item": crushed},
        "results": [{"base_ingredient": {"tag": ingot}, "count": 2}],
        "slag": {"tag": "forge:slag"},
        "time": 100,
    })

    # --- raw storage blocks: 9x the raw-ore ratios
    w(f'data/create/recipes/crushing/raw_{m}_block.json', {
        "type": "create:crushing",
        "ingredients": [{"tag": f"forge:storage_blocks/raw_{m}"}],
        "processingTime": 400,
        "results": [
            {"count": 13, "item": crushed},
            {"chance": 0.5, "item": crushed},
            {"chance": 0.75, "count": 9, "item": "create:experience_nugget"},
        ],
    })
    w(f'data/immersiveengineering/recipes/crusher/raw_block_{m}.json', {
        "type": "immersiveengineering:crusher",
        "conditions": [not_empty(dust)],
        "energy": 54000,
        "input": {"tag": f"forge:storage_blocks/raw_{m}"},
        "result": {"base_ingredient": {"tag": dust}, "count": 18},
        "secondaries": [],
    })
    w(f'data/immersiveengineering/recipes/arcfurnace/raw_block_{m}.json', {
        "type": "immersiveengineering:arc_furnace",
        "conditions": [not_empty(ingot)],
        "additives": [],
        "energy": 230400,
        "input": {"tag": f"forge:storage_blocks/raw_{m}"},
        "results": [{"base_ingredient": {"tag": ingot}, "count": 22}],
        "secondaries": [{"chance": 0.5, "output": {"tag": ingot}}],
        "slag": {"tag": "forge:slag"},
        "time": 900,
    })

    # --- ore blocks (silk touch): scale by the ore's BASE DROP COUNT, using the
    #     same tier multipliers as raw ore. Silk is "same yield, fewer steps";
    #     Fortune stays the only bonus lever. Flat counts would nerf multi-drop
    #     ores (copper drops 2-5 raw, avg 3.5) and let them run away downstream.
    base = ORE_BASE_DROP.get(m, 1)
    for variant in ORE_BLOCK_VARIANTS.get(m, []):
        w(f'data/create/recipes/crushing/{variant}.json', {
            "type": "create:crushing",
            "ingredients": [{"item": f"minecraft:{variant}"}],
            "processingTime": 400,
            "results": split_count(base * 1.5, crushed) + [
                {"chance": 0.75, "item": "create:experience_nugget"},
            ],
        })
    w(f'data/immersiveengineering/recipes/crusher/ore_{m}.json', {
        "type": "immersiveengineering:crusher",
        "conditions": [not_empty(dust)],
        "energy": 6000,
        "input": {"tag": f"forge:ores/{m}"},
        "result": {"base_ingredient": {"tag": dust}, "count": int(base * 2)},
        "secondaries": [],
    })
    arc_whole, arc_chance = divmod_chance(base * 2.5)
    w(f'data/immersiveengineering/recipes/arcfurnace/ore_{m}.json', {
        "type": "immersiveengineering:arc_furnace",
        "conditions": [not_empty(ingot)],
        "additives": [],
        "energy": 102400,
        "input": {"tag": f"forge:ores/{m}"},
        "results": [{"base_ingredient": {"tag": ingot}, "count": arc_whole}],
        "secondaries": ([{"chance": arc_chance, "output": {"tag": ingot}}]
                        if arc_chance else []),
        "slag": {"tag": "forge:slag"},
        "time": 200,
    })

# --- Ore Hammer: 4 raw + hammer -> 5 dust (1.25x), metals only
for m in HAMMER_METALS:
    w(f'data/ore_hammer/recipes/{m}_dust_recipe.json', {
        "type": "minecraft:crafting_shapeless",
        "category": "misc",
        "ingredients": [
            {"tag": f"forge:raw_materials/{m}"},
            {"tag": f"forge:raw_materials/{m}"},
            {"tag": f"forge:raw_materials/{m}"},
            {"tag": f"forge:raw_materials/{m}"},
            {"item": "ore_hammer:crushing_hammer"},
        ],
        "result": {"item": f"ore_hammer:{m}_dust", "count": 5},
    })

# --- Ore Hammer: kill every ore-block ("duplication") recipe; silk-touch
#     multiplication belongs to the machine tiers, not the crafting grid.
DISABLED = [
    'amethyst_duplication', 'ancient_debris_duplication',
    'coal_duplication', 'coal_duplication_deepslate',
    'copper_duplication', 'copper_duplication_deepslate',
    'diamond_duplication', 'diamond_duplication_deepslate',
    'emerald_duplication', 'emerald_duplication_deepslate',
    'gold_duplication', 'gold_duplication_deepslate',
    'iron_duplication', 'iron_duplication_deepslate',
    'lapis_lazuli_duplication', 'lapis_lazuli_duplication_deepslate',
    'nether_gold_duplication', 'nether_quartz_duplication',
    'redstone_duplication', 'redstone_duplication_deepslate',
]
for r in DISABLED:
    w(f'data/ore_hammer/recipes/{r}.json', {
        "type": "minecraft:crafting_shapeless",
        "conditions": [{"type": "forge:false"}],
        "ingredients": [{"item": "minecraft:stone"}],
        "result": {"item": "minecraft:stone"},
    })

print("wrote", sum(len(files) for _, _, files in os.walk(ROOT)), "files to", ROOT)
