
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

 <mekanism:oreblock:1>, //Mekanism:Copper Ore
 <mekanism:oreblock:2>, //Mekanism:Tin Ore
  <mekanism:nugget:2>, //Mekanism:Bronze Nugget
 <mekanism:nugget:4>, //Mekanism:Steel Nugget
 <mekanism:nugget:5>, //Mekanism:Copper Nugget
 <mekanism:nugget:6>, //Mekanism:Tin Nugget
  <mekanism:basicblock:1>, //Mekanism:Bronze Block
 <mekanism:basicblock:3>, //Mekanism:Charcoal Block
 <mekanism:basicblock:5>, //Mekanism:Steel Block
 <mekanism:basicblock:12>, //Mekanism:Copper Block
 <mekanism:basicblock:13>, //Mekanism:Tin Block
  <mekanism:ingot:2>, //Mekanism:Bronze Ingot
 <mekanism:ingot:4>, //Mekanism:Steel Ingot
 <mekanism:ingot:5>, //Mekanism:Copper Ingot
 <mekanism:ingot:6> //Mekanism:Tin Ingot
  ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }