import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

 <nuclearcraft:ingot>, //NuclearCraft:Copper Ingot
 <nuclearcraft:ingot:1>, //NuclearCraft:Tin Ingot
 <nuclearcraft:ingot:2>, //NuclearCraft:Lead Ingot
 <nuclearcraft:ingot:12>, //NuclearCraft:Aluminum Ingot
 <nuclearcraft:ingot:13>, //NuclearCraft:Silver Ingot
 <nuclearcraft:ingot_block>, //NuclearCraft:Copper Block
 <nuclearcraft:ingot_block:1>, //NuclearCraft:Tin Block
 <nuclearcraft:ingot_block:2>, //NuclearCraft:Lead Block
 <nuclearcraft:ingot_block:12>, //NuclearCraft:Aluminum Block
 <nuclearcraft:ingot_block:13>, //NuclearCraft:Silver Block
 <nuclearcraft:dust>, //NuclearCraft:Copper Dust
 <nuclearcraft:dust:1>, //NuclearCraft:Tin Dust
 <nuclearcraft:dust:2>, //NuclearCraft:Lead Dust
 <nuclearcraft:dust:12>, //NuclearCraft:Aluminum Dust
 <nuclearcraft:dust:13>, //NuclearCraft:Silver Dust
 <nuclearcraft:alloy>, //NuclearCraft:Bronze Ingot
 <nuclearcraft:alloy:5>, //NuclearCraft:Steel Ingot
 <nuclearcraft:ore>, //NuclearCraft:Copper Ore
 <nuclearcraft:ore:1>, //NuclearCraft:Tin Ore
 <nuclearcraft:ore:2> //NuclearCraft:Lead Ore
 
  ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }