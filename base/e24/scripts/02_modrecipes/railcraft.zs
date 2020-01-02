import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

<railcraft:plate:1>, //Railcraft:Steel Plate
<railcraft:plate:2>, //Railcraft:Tin Plate
<railcraft:plate:3>, //Railcraft:Copper Plate
<railcraft:plate:4>, //Railcraft:Lead Plate
<railcraft:plate:5>, //Railcraft:Silver Plate
<railcraft:plate:6>, //Railcraft:Bronze Plate
<railcraft:plate:7>, //Railcraft:Gold Plate
<railcraft:plate:8>, //Railcraft:Nickel Plate
<railcraft:plate:9>, //Railcraft:Invar Plate
<railcraft:plate:10>, //Railcraft:Zinc Plate
<railcraft:plate:11>, //Railcraft:Brass Plate
<railcraft:plate>, //Railcraft:Iron Plate
<railcraft:nugget:1>, //Railcraft:Copper Nugget
<railcraft:nugget:2>, //Railcraft:Tin Nugget
<railcraft:nugget:3>, //Railcraft:Lead Nugget
<railcraft:nugget:4>, //Railcraft:Silver Nugget
<railcraft:nugget:5>, //Railcraft:Bronze Nugget
<railcraft:nugget:6>, //Railcraft:Nickel Nugget
<railcraft:nugget:7>, //Railcraft:Invar Nugget
<railcraft:nugget:8>, //Railcraft:Zinc Nugget
<railcraft:nugget:9>, //Railcraft:Brass Nugget
<railcraft:generic:6>, //Railcraft:Block of Coal Coke
<railcraft:tool_shovel_steel>, //Railcraft:Steel Shovel
<railcraft:fuel_coke>, //Railcraft:Coal Coke
<railcraft:ore>, //Railcraft:Sulfur Ore
<railcraft:ore:1>, //Railcraft:Saltpeter Ore
<railcraft:tool_hoe_steel>, //Railcraft:Steel Hoe
<railcraft:ore_metal>, //Railcraft:Copper Ore
<railcraft:ore_metal:1>, //Railcraft:Tin Ore
<railcraft:ore_metal:2>, //Railcraft:Lead Ore
<railcraft:ore_metal:3>, //Railcraft:Silver Ore
<railcraft:ore_metal:4>, //Railcraft:Nickel Ore
<railcraft:ore_metal:5>, //Railcraft:Zinc Ore
<railcraft:worldspike>, //Railcraft:Admin Worldspike
<railcraft:gear>, //Railcraft:Brass Gear
<railcraft:gear:1>, //Railcraft:Iron Gear
<railcraft:gear:2>, //Railcraft:Steel Gear
<railcraft:gear:3>, //Railcraft:Gear Bushing
<railcraft:gear:4>, //Railcraft:Bronze Gear
<railcraft:gear:5>, //Railcraft:Invar Gear
<railcraft:admin_steam_producer>, //Railcraft:Admin Steam Producer
<railcraft:worldlogic>, //Railcraft:Saltpeter Ore Spawner
<railcraft:dust:5>, //Railcraft:Coal Dust
<railcraft:dust:1>, //Railcraft:Sulfur
<railcraft:dust:2>, //Railcraft:Saltpeter
<railcraft:metal>, //Railcraft:Block of Copper
<railcraft:metal:1>, //Railcraft:Block of Tin
<railcraft:metal:2>, //Railcraft:Block of Lead
<railcraft:metal:4>, //Railcraft:Block of Silver
<railcraft:metal:3>, //Railcraft:Block of Steel
<railcraft:metal:5>, //Railcraft:Block of Bronze
<railcraft:metal:6>, //Railcraft:Block of Nickel
<railcraft:metal:7>, //Railcraft:Block of Invar
<railcraft:metal:8>, //Railcraft:Block of Zinc
<railcraft:metal:9>, //Railcraft:Block of Brass
<railcraft:tool_shears_steel>, //Railcraft:Steel Shears
<railcraft:anvil>, //Railcraft:Steel Anvil
<railcraft:anvil:1>, //Railcraft:Slightly Damaged Steel Anvil
<railcraft:anvil:2>, //Railcraft:Very Damaged Steel Anvil
<railcraft:armor_helmet_steel>, //Railcraft:Steel Helmet
<railcraft:tool_axe_steel>, //Railcraft:Steel Axe
<railcraft:ingot>, //Railcraft:Steel Ingot
<railcraft:ingot:1>, //Railcraft:Copper Ingot
<railcraft:ingot:2>, //Railcraft:Tin Ingot
<railcraft:ingot:3>, //Railcraft:Lead Ingot
<railcraft:ingot:4>, //Railcraft:Silver Ingot
<railcraft:ingot:5>, //Railcraft:Bronze Ingot
<railcraft:ingot:6>, //Railcraft:Nickel Ingot
<railcraft:ingot:7>, //Railcraft:Invar Ingot
<railcraft:ingot:8>, //Railcraft:Zinc Ingot
<railcraft:ingot:9>, //Railcraft:Brass Ingot
<railcraft:ore_metal_poor>, //Railcraft:Poor Iron Ore
<railcraft:ore_metal_poor:1>, //Railcraft:Poor Gold Ore
<railcraft:ore_metal_poor:2>, //Railcraft:Poor Copper Ore
<railcraft:ore_metal_poor:3>, //Railcraft:Poor Tin Ore
<railcraft:ore_metal_poor:4>, //Railcraft:Poor Lead Ore
<railcraft:ore_metal_poor:5>, //Railcraft:Poor Silver Ore
<railcraft:ore_metal_poor:6>, //Railcraft:Poor Nickel Ore
<railcraft:ore_metal_poor:7> //Railcraft:Poor Zinc Ore

 ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }