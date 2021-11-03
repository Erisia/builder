import mods.appliedenergistics2.Inscriber;


//TE Transposer
mods.thermalexpansion.Transposer.addFillRecipe(<appliedenergistics2:material:7>, <contenttweaker:omega_gem>, <liquid:nutrient_distillation> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<appliedenergistics2:material:12>, <appliedenergistics2:material:7>, <liquid:purified_water> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<appliedenergistics2:material:11>, <minecraft:quartz>, <liquid:purified_water> * 500, 16000);

mods.thermalexpansion.Transposer.addFillRecipe(<appliedenergistics2:material:10>, <appliedenergistics2:material:1>, <liquid:purified_water> * 500, 16000);

//Inscriber
Inscriber.removeRecipe(<appliedenergistics2:material:22>); 
Inscriber.removeRecipe(<appliedenergistics2:material:23>); 
Inscriber.removeRecipe(<appliedenergistics2:material:24>); 

Inscriber.addRecipe(<appliedenergistics2:material:22>, <enderio:item_material:20>, false, <appliedenergistics2:material:18>, <appliedenergistics2:material:20>);
Inscriber.addRecipe(<appliedenergistics2:material:23>, <enderio:item_material:20>, false, <appliedenergistics2:material:16>, <appliedenergistics2:material:20>);
Inscriber.addRecipe(<appliedenergistics2:material:24>, <enderio:item_material:20>, false, <appliedenergistics2:material:17>, <appliedenergistics2:material:20>);