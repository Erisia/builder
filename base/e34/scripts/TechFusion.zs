mods.techreborn.fusionReactor.addRecipe(<techreborn:ingot:14>, 
<thermalfoundation:material:135>, 
<contenttweaker:superfused_alloy_ingot>*2, 
1000000, -15000, 1000);

mods.techreborn.fusionReactor.removeRecipe(<techreborn:dynamiccell>.withTag({Fluid: {FluidName: "fluidhelium3", Amount: 1000}}));
mods.techreborn.fusionReactor.removeRecipe(<techreborn:dynamiccell>.withTag({Fluid: {FluidName: "fluidheliumplasma", Amount: 1000}}));

mods.techreborn.fusionReactor.addRecipe(<aoa3:divine_enhancer>, 
<techreborn:part:17>*2, 
<techreborn:part:39>*8, 
1000000, -15000, 1000);