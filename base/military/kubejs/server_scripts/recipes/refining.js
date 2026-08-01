// priority: 50
// IT ore-refining pipeline (user-specified). Crusher -> Mixer -> Solar Melter
// -> Distiller. The heated-salt-slurry the Mixer needs comes from an IT Solar
// Tower, so the whole line is gated on a running IT heat setup. 1 chunk ->
// 128 ingots (2x). Items/fluids in startup_scripts/refining_intermediates.js.
// STEP 4 (distiller -> ingots) is the least-verified stage in-world.
// Gems: chunk -> Create Crushing -> gems (you don't smelt gems).
ServerEvents.recipes((event) => {
  const r = {
    "kubejs:crush_iron_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_iron_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_iron_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_iron_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_iron_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_iron_ore_slurry"
      }
    },
    "kubejs:melt_iron_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_iron_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_iron_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_iron": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_iron_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "minecraft:iron_ingot",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_iron": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_iron_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "minecraft:iron_ingot",
          "count": 2
        }
      ]
    },
    "kubejs:crush_copper_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_copper_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_copper_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_copper_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_copper_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_copper_ore_slurry"
      }
    },
    "kubejs:melt_copper_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_copper_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_copper_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_copper": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_copper_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "minecraft:copper_ingot",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_copper": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_copper_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "minecraft:copper_ingot",
          "count": 2
        }
      ]
    },
    "kubejs:crush_gold_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_gold_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_gold_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_gold_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_gold_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_gold_ore_slurry"
      }
    },
    "kubejs:melt_gold_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_gold_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_gold_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_gold": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_gold_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "minecraft:gold_ingot",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_gold": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_gold_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "minecraft:gold_ingot",
          "count": 2
        }
      ]
    },
    "kubejs:crush_bauxite_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_bauxite_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_bauxite_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_bauxite_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_bauxite_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_bauxite_ore_slurry"
      }
    },
    "kubejs:melt_bauxite_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_bauxite_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_bauxite_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_bauxite": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_bauxite_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "immersiveengineering:ingot_aluminum",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_bauxite": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_bauxite_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "immersiveengineering:ingot_aluminum",
          "count": 2
        }
      ]
    },
    "kubejs:crush_lead_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_lead_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_lead_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_lead_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_lead_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_lead_ore_slurry"
      }
    },
    "kubejs:melt_lead_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_lead_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_lead_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_lead": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_lead_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "immersiveengineering:ingot_lead",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_lead": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_lead_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "immersiveengineering:ingot_lead",
          "count": 2
        }
      ]
    },
    "kubejs:crush_silver_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_silver_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_silver_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_silver_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_silver_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_silver_ore_slurry"
      }
    },
    "kubejs:melt_silver_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_silver_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_silver_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_silver": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_silver_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "immersiveengineering:ingot_silver",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_silver": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_silver_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "immersiveengineering:ingot_silver",
          "count": 2
        }
      ]
    },
    "kubejs:crush_nickel_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_nickel_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_nickel_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_nickel_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_nickel_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_nickel_ore_slurry"
      }
    },
    "kubejs:melt_nickel_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_nickel_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_nickel_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_nickel": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_nickel_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "immersiveengineering:ingot_nickel",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_nickel": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_nickel_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "immersiveengineering:ingot_nickel",
          "count": 2
        }
      ]
    },
    "kubejs:crush_uranium_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_uranium_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_uranium_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_uranium_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_uranium_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_uranium_ore_slurry"
      }
    },
    "kubejs:melt_uranium_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_uranium_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_uranium_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_uranium": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_uranium_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "immersiveengineering:ingot_uranium",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_uranium": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_uranium_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "immersiveengineering:ingot_uranium",
          "count": 2
        }
      ]
    },
    "kubejs:crush_zinc_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_zinc_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_zinc_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_zinc_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_zinc_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_zinc_ore_slurry"
      }
    },
    "kubejs:melt_zinc_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_zinc_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_zinc_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_zinc": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_zinc_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "create:zinc_ingot",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_zinc": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_zinc_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "create:zinc_ingot",
          "count": 2
        }
      ]
    },
    "kubejs:crush_tungsten_chunk": {
      "type": "immersiveengineering:crusher",
      "energy": 25600,
      "input": {
        "item": "kubejs:bedrock_tungsten_ore_chunk"
      },
      "result": {
        "count": 64,
        "item": "kubejs:crushed_bedrock_tungsten_ore"
      },
      "secondaries": []
    },
    "kubejs:mix_tungsten_slurry": {
      "type": "immersiveengineering:mixer",
      "energy": 12800,
      "fluid": {
        "amount": 250,
        "tag": "immersivetechnology:heated_salt_slurry"
      },
      "inputs": [
        {
          "base_ingredient": {
            "item": "kubejs:crushed_bedrock_tungsten_ore"
          },
          "count": 4
        }
      ],
      "result": {
        "amount": 4000,
        "fluid": "kubejs:bedrock_tungsten_ore_slurry"
      }
    },
    "kubejs:melt_tungsten_slurry": {
      "type": "immersivetechnology:melting",
      "input": {
        "amount": 1000,
        "tag": "kubejs:bedrock_tungsten_ore_slurry"
      },
      "output": {
        "amount": 1000,
        "fluid": "kubejs:molten_tungsten_ore_slurry"
      },
      "requiredTemp": 1000.0,
      "time": 40
    },
    "kubejs:distill_tungsten": {
      "type": "immersivetechnology:distiller",
      "energy": 25600,
      "input": {
        "amount": 1000,
        "tag": "kubejs:molten_tungsten_ore_slurry"
      },
      "item_output": {
        "chance": 1.0,
        "item": "superbwarfare:tungsten_ingot",
        "count": 2
      },
      "result": {
        "amount": 100,
        "fluid": "immersivetechnology:molten_salt"
      },
      "time": 20
    },
    "kubejs:press_tungsten": {
      "type": "create:compacting",
      "ingredients": [
        {
          "amount": 1000,
          "fluidTag": "kubejs:molten_tungsten_ore_slurry"
        }
      ],
      "results": [
        {
          "item": "superbwarfare:tungsten_ingot",
          "count": 2
        }
      ]
    }
  };
  Object.keys(r).forEach((id) => event.custom(r[id]).id(id));
  event.custom({type:'create:crushing',ingredients:[{item:'kubejs:bedrock_diamond_ore_chunk'}],results:[{item:'minecraft:diamond',count:24}],processingTime:600}).id('kubejs:crush_diamond_chunk');
  event.custom({type:'create:crushing',ingredients:[{item:'kubejs:bedrock_lapis_ore_chunk'}],results:[{item:'minecraft:lapis_lazuli',count:64}],processingTime:400}).id('kubejs:crush_lapis_chunk');
});
