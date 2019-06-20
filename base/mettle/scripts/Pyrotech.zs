# *======= Import =======*
import crafttweaker.item.IItemStack;
import mods.jei.JEI.removeAndHide as rh;
import mods.pyrotech.Bloomery;
import mods.pyrotech.SoakingPot;
import mods.pyrotech.GraniteAnvil;
import mods.pyrotech.IroncladAnvil;

# *======= Changes =======*
#Glass from shard
recipes.addShaped(<minecraft:glass>, [
	[<pyrotech:material:32>, <pyrotech:material:32>],
	[<pyrotech:material:32>, <pyrotech:material:32>]
]);

#Brick from shard
recipes.addShaped(<minecraft:brick>, [	
	[<ore:pottery>, <ore:pottery>],
	[<ore:pottery>, <ore:pottery>]
]);

#Chopping block
rh(<pyrotech:chopping_block>);
#recipes.remove(<pyrotech:chopping_block>);
#recipes.addShapeless(<pyrotech:chopping_block>, [<pyrotech:crude_axe>, <ore:logWood>]);

#Worktable
recipes.remove(<pyrotech:worktable>);
recipes.addShaped(<pyrotech:worktable>, [
	[null, <ore:plankWood>],
	[null, <ore:logWood>]
]);

#Sawmill
recipes.remove(<pyrotech:stone_sawmill>);
recipes.addShaped(<pyrotech:stone_sawmill>, [
	[<pyrotech:stone_bricks>, <pyrotech:material:16>, <pyrotech:stone_bricks>],
	[<pyrotech:stone_bricks>, <pyrotech:cog_stone>, <pyrotech:stone_bricks>],
	[<pyrotech:stone_bricks>, <pyrotech:stone_bricks>, <pyrotech:stone_bricks>]
]);

#Diamond Hammer
recipes.remove(<pyrotech:diamond_hammer>);
recipes.addShaped(<pyrotech:diamond_hammer>, [
	[null, <betterwithmods:material:45>, <pyrotech:material:26>],
	[null, <ore:stickWood>, <betterwithmods:material:45>],
	[<ore:stickWood>]
]);

#Travertine
<pyrotech:limestone>.displayName = "Travertine";
<pyrotech:cobblestone:3>.displayName = "Cobbled Travertine";
<pyrotech:material:28>.displayName = "Crushed Travertine"; 
<pyrotech:rock:8>.displayName = "Travertine Rock"; 

# *======= Implementations =======*
#Wrought iron bloom
Bloomery.createBloomeryBuilder(
        "bloom_from_iron_slag",  
        <contenttweaker:wroughtiron>,  
        <pyrotech:generated_slag_iron>  
    )
    .setAnvilTiers(["granite", "ironclad"])
    .setBurnTimeTicks(4800)
    .setBloomYield(3, 5)
    .setSlagItem(<pyrotech:slag>, 1)
    .register();

#Clay hardened brick
SoakingPot.addRecipe("Clay_hardened_brick_from_clay", <forestry:ash_brick>, <liquid:clay>*1000, <quark:basalt>, 1200);

# *----- Plates -----*
#Brass
GraniteAnvil.addRecipe("brass_plate_from_brass", <techreborn:plates:17>, <techreborn:ingot:1>, 3, "hammer");
IroncladAnvil.addRecipe("ibrass_plate_from_brass", <techreborn:plates:17>, <techreborn:ingot:1>, 3, "hammer");

#Thaumium 
GraniteAnvil.addRecipe("thaumium_plate_from_thaumium", <thaumcraft:plate:2>, <thaumcraft:ingot>, 3, "hammer");
IroncladAnvil.addRecipe("ithaumium_plate_from_thaumium", <thaumcraft:plate:2>, <thaumcraft:ingot>, 3, "hammer");

#Redstone 
GraniteAnvil.addRecipe("redstone_plate_from_redstone", <techreborn:plates:4>, <minecraft:redstone>, 3, "hammer");
IroncladAnvil.addRecipe("iredstone_plate_from_redstone", <techreborn:plates:4>, <minecraft:redstone>, 3, "hammer");

#Iron 
GraniteAnvil.addRecipe("iron_plate_from_iron", <thermalfoundation:material:32>, <minecraft:iron_ingot>, 3, "hammer");
IroncladAnvil.addRecipe("iiron_plate_from_iron", <thermalfoundation:material:32>, <minecraft:iron_ingot>, 3, "hammer");

#Copper
GraniteAnvil.addRecipe("copper_plate_from_copper", <thermalfoundation:material:320>, <thermalfoundation:material:128>, 3, "hammer");
IroncladAnvil.addRecipe("icopper_plate_from_copper", <thermalfoundation:material:320>, <thermalfoundation:material:128>, 3, "hammer");

#Nickel 
GraniteAnvil.addRecipe("nickle_plate_from_nickle", <thermalfoundation:material:325>, <thermalfoundation:material:133>, 3, "hammer");
IroncladAnvil.addRecipe("inickle_plate_from_nickle", <thermalfoundation:material:325>, <thermalfoundation:material:133>, 3, "hammer");

#Bronze
GraniteAnvil.addRecipe("bronze_plate_from_bronze", <thermalfoundation:material:355>, <thermalfoundation:material:163>, 3, "hammer");
IroncladAnvil.addRecipe("ibronze_plate_from_bronze", <thermalfoundation:material:355>, <thermalfoundation:material:163>, 3, "hammer");

#Steel
GraniteAnvil.addRecipe("steel_plate_from_steel", <thermalfoundation:material:352>, <thermalfoundation:material:160>, 3, "hammer");
IroncladAnvil.addRecipe("isteel_plate_from_steel", <thermalfoundation:material:352>, <thermalfoundation:material:160>, 3, "hammer");

# *======= Removals =======*
val remove = [
	<pyrotech:crude_hoe>,
	<pyrotech:bone_hoe>,
	<pyrotech:flint_hoe>,
	<pyrotech:chopping_block>
	] as IItemStack[];

for item in remove {
	rh(item);
}