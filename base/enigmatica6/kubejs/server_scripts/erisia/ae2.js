onEvent('recipes', event => {
    event.custom({
      "type": "appliedenergistics2:inscriber",
      "mode": "inscribe",
      "result": {
        "item": "appliedenergistics2:printed_silicon"
      },
      "ingredients": {
        "top": {
            "item": "appliedenergistics2:silicon_press"
        },
        "middle": {
            "item": "emendatusenigmatica:silicon_gem"
        }
     }
  })
})

//Fluix using EE
events.listen('recipes', function (event) {
    event.recipes.interactio.item_fluid_transform({
        inputs: [
            {
                tag: 'forge:dusts/redstone',
                count: 1
            },
            {
                tag: 'forge:gems/charged_certus_quartz',
                count: 1
            },
            {
                tag: 'forge:gems/quartz',
                count: 1
            }
        ],
        fluid: {
            fluid: 'water'
        },
        output: {
            item: 'emendatusenigmatica:gem_fluix',
            count: 2
        },

        consume_fluid: 0.0
    });
});

//Powah Integration Charging
events.listen('recipes', function (event) {
    event.recipes.powah.energizing({
        ingredients: [{ tag: 'forge:gems/certus_quartz' }],
        energy: 10000,
        result: {
            item: getPreferredItemInTag(ingredient.of('#forge:gems/charged_certus_quartz')).id
        }
    });
    event.recipes.powah.energizing({
        ingredients: [
            { tag: 'forge:gems/charged_certus_quartz' },
            { tag: 'forge:dusts/redstone' },
            { tag: 'forge:gems/quartz' }
        ],
        energy: 4000,
        result: {
            item: getPreferredItemInTag(ingredient.of('#forge:gems/fluix')).id,
            count: 2
        }
    });
});

// adds recipes to switch between ee and ae2 items
onEvent('recipes', (event) => {

    const recipes = [
        {
            output: 'appliedenergistics2:certus_quartz_crystal',
            inputs: ['emendatusenigmatica:certus_quartz_gem']
        },
        {
            output: 'emendatusenigmatica:certus_quartz_gem',
            inputs: ['appliedenergistics2:certus_quartz_crystal']
        },
        {
            output: 'emendatusenigmatica:charged_certus_quartz_gem',
            inputs: ['appliedenergistics2:charged_certus_quartz_crystal']
        },
        {
            output: 'appliedenergistics2:charged_certus_quartz_crystal',
            inputs: ['emendatusenigmatica:charged_certus_quartz_gem']
        },
        {
            output: 'emendatusenigmatica:fluix_gem',
            inputs: ['appliedenergistics2:fluix_crystal']
        },
        {
            output: 'appliedenergistics2:fluix_crystal',
            inputs: ['emendatusenigmatica:fluix_gem']
        }
    ];

    recipes.forEach((recipe) => {
        recipe.id
            ? event.shapeless(recipe.output, recipe.inputs).id(recipe.id)
            : event.shapeless(recipe.output, recipe.inputs);
    });
});

onEvent('item.tags', event => {
  event.add('appliedenergistics2:dusts/ender', 'emendatusenigmatica:ender_dust')
})
