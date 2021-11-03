import mods.inworldcrafting.FluidToFluid;
import mods.inworldcrafting.FireCrafting;
import mods.inworldcrafting.FluidToItem;


//Fluid to Fluid
mods.inworldcrafting.FluidToFluid.transform(<liquid:redstone>, <liquid:purified_water>, [<ore:blockRedstone>]);

mods.inworldcrafting.FluidToFluid.transform(<liquid:lava>, <liquid:purified_water>, [<toughasnails:magma_shard>]);

mods.inworldcrafting.FluidToFluid.transform(<liquid:creosote>, <liquid:purified_water>, [<redstone_lock:charcoalchunk>]);

mods.inworldcrafting.FluidToFluid.transform(<liquid:lava>, <liquid:water>, [<minecraft:magma>]);

//Fire Crafting
mods.inworldcrafting.FireCrafting.addRecipe(<toughasnails:magma_shard> * 2, <ore:blockCharcoal>, 100);

mods.inworldcrafting.FireCrafting.addRecipe(<intimepresence:crudeironingot> * 9, <ore:blockIron>, 100);

mods.inworldcrafting.FireCrafting.addRecipe(<minecraft:sponge:0>, <minecraft:sponge:1>, 100);

mods.inworldcrafting.FireCrafting.addRecipe(<extratan:tempered_glass_block> * 3, <additionalcompression:blocksand_compressed>, 100);

mods.inworldcrafting.FireCrafting.addRecipe(<embers:ashen_cloth>, <better_diving:silicone_rubber>, 60);

mods.inworldcrafting.FireCrafting.addRecipe(<extratan:flask_with_super_hot_water>, <extratan:flask_with_hot_water>, 100);


// Fluid to Item

mods.inworldcrafting.FluidToItem.transform(<modularmachinery:itemmodularium> * 9, <liquid:redstone>, [<ore:blockConstantan>], true);

mods.inworldcrafting.FluidToItem.transform(<minecraft:ice>, <liquid:water>, [<armorunder:cooling_goo>], true);

mods.inworldcrafting.FluidToItem.transform(<thermaldynamics:duct_64> * 8, <liquid:creosote>, [<thermaldynamics:duct_64:3> * 8], true);

mods.inworldcrafting.FluidToItem.transform(<coralreef:reef>, <liquid:purified_water>, [<coralreef:reef:1>], true);