import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

 <embers:hoe_copper>, //Embers Rekindled:Copper Hoe
 <embers:shovel_aluminum>, //Embers Rekindled:Aluminium Shovel
 <embers:sword_tin>, //Embers Rekindled:Tin Sword
 <embers:ore_tin>, //Embers Rekindled:Tin Ore
 <embers:ore_silver>, //Embers Rekindled:Silver Ore
 <embers:block_bronze>, //Embers Rekindled:Bronze Block
 <embers:sword_lead>, //Embers Rekindled:Lead Sword
 <embers:nugget_bronze>, //Embers Rekindled:Bronze Nugget
 <embers:sword_copper>, //Embers Rekindled:Copper Sword
 <embers:hoe_bronze>, //Embers Rekindled:Bronze Hoe
 <embers:shovel_electrum>, //Embers Rekindled:Electrum Shovel
 <embers:sword_bronze>, //Embers Rekindled:Bronze Sword
 <embers:nugget_copper>, //Embers Rekindled:Copper Nugget
 <embers:plate_copper>, //Embers Rekindled:Copper Plate
 <embers:block_aluminum>, //Embers Rekindled:Aluminium Block
 <embers:pickaxe_silver>, //Embers Rekindled:Silver Pickaxe
 <embers:shovel_bronze>, //Embers Rekindled:Bronze Shovel
 <embers:pickaxe_tin>, //Embers Rekindled:Tin Pickaxe
 <embers:hoe_lead>, //Embers Rekindled:Lead Hoe
 <embers:ore_nickel>, //Embers Rekindled:Nickel Ore
 <embers:axe_silver>, //Embers Rekindled:Silver Axe
 <embers:axe_electrum>, //Embers Rekindled:Electrum Axe
 <embers:pickaxe_copper>, //Embers Rekindled:Copper Pickaxe
 <embers:shovel_lead>, //Embers Rekindled:Lead Shovel
 <embers:nugget_aluminum>, //Embers Rekindled:Aluminium Nugget
 <embers:axe_tin>, //Embers Rekindled:Tin Axe
 <embers:item_transfer>, //Embers Rekindled:Item Transfer
 <embers:plate_silver>, //Embers Rekindled:Silver Plate
 <embers:nugget_electrum>, //Embers Rekindled:Electrum Nugget
 <embers:block_silver>, //Embers Rekindled:Silver Block
 <embers:plate_tin>, //Embers Rekindled:Tin Plate
 <embers:plate_nickel>, //Embers Rekindled:Nickel Plate
 <embers:ingot_electrum>, //Embers Rekindled:Electrum Ingot
 <embers:pickaxe_lead>, //Embers Rekindled:Lead Pickaxe
 <embers:plate_gold>, //Embers Rekindled:Gold Plate
 <embers:shovel_tin>, //Embers Rekindled:Tin Shovel
 <embers:sword_aluminum>, //Embers Rekindled:Aluminium Sword
 <embers:hoe_aluminum>, //Embers Rekindled:Aluminium Hoe
 <embers:plate_bronze>, //Embers Rekindled:Bronze Plate
 <embers:pickaxe_electrum>, //Embers Rekindled:Electrum Pickaxe
 <embers:mechanical_pump>, //Embers Rekindled:Mechanical Pump
 <embers:plate_electrum>, //Embers Rekindled:Electrum Plate
 <embers:item_pipe>, //Embers Rekindled:Item Pipe
 <embers:axe_bronze>, //Embers Rekindled:Bronze Axe
 <embers:pickaxe_bronze>, //Embers Rekindled:Bronze Pickaxe
 <embers:ore_copper>, //Embers Rekindled:Copper Ore
 <embers:ingot_aluminum>, //Embers Rekindled:Aluminium Ingot
 <embers:shovel_silver>, //Embers Rekindled:Silver Shovel
 <embers:nugget_lead>, //Embers Rekindled:Lead Nugget
 <embers:ingot_copper>, //Embers Rekindled:Copper Ingot
 <embers:nugget_tin>, //Embers Rekindled:Tin Nugget
 <embers:axe_aluminum>, //Embers Rekindled:Aluminium Axe
 <embers:ingot_lead>, //Embers Rekindled:Lead Ingot
 <embers:axe_copper>, //Embers Rekindled:Copper Axe
 <embers:hoe_silver>, //Embers Rekindled:Silver Hoe
 <embers:nugget_nickel>, //Embers Rekindled:Nickel Nugget
 <embers:sword_electrum>, //Embers Rekindled:Electrum Sword
 <embers:hoe_nickel>, //Embers Rekindled:Nickel Hoe
 <embers:shovel_nickel>, //Embers Rekindled:Nickel Shovel
 <embers:sword_silver>, //Embers Rekindled:Silver Sword
 <embers:ingot_tin>, //Embers Rekindled:Tin Ingot
 <embers:ore_aluminum>, //Embers Rekindled:Aluminium Ore
 <embers:sword_nickel>, //Embers Rekindled:Nickel Sword
 <embers:plate_iron>, //Embers Rekindled:Iron Plate
 <embers:hoe_electrum>, //Embers Rekindled:Electrum Hoe
 <embers:nugget_silver>, //Embers Rekindled:Silver Nugget
 <embers:pickaxe_aluminum>, //Embers Rekindled:Aluminium Pickaxe
 <embers:shovel_copper>, //Embers Rekindled:Copper Shovel
 <embers:hoe_tin>, //Embers Rekindled:Tin Hoe
 <embers:plate_aluminum>, //Embers Rekindled:Aluminium Plate
 <embers:ingot_bronze>, //Embers Rekindled:Bronze Ingot
 <embers:ingot_silver>, //Embers Rekindled:Silver Ingot
 <embers:plate_lead>, //Embers Rekindled:Lead Plate
 <embers:block_nickel>, //Embers Rekindled:Nickel Block
 <embers:block_lead>, //Embers Rekindled:Lead Block
 <embers:ore_quartz>, //Embers Rekindled:Quartz Ore
 <embers:ingot_nickel>, //Embers Rekindled:Nickel Ingot
 <embers:block_tin>, //Embers Rekindled:Tin Block
 <embers:pickaxe_nickel>, //Embers Rekindled:Nickel Pickaxe
 <embers:ore_lead> //Embers Rekindled:Lead Ore
 
 ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }