
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

  <biomesoplenty:gem:2>,
  <biomesoplenty:gem:3>,
  <biomesoplenty:gem:4>,
  <biomesoplenty:gem:5>,
  <biomesoplenty:gem:6>,
  <biomesoplenty:gem:7>,
  <biomesoplenty:biome_finder>.withTag({}),
  <biomesoplenty:gem>,
  <biomesoplenty:gem_block>,
  <biomesoplenty:gem_block:7>,
  <biomesoplenty:biome_essence>,
  <biomesoplenty:biome_block>,
  <biomesoplenty:terrestrial_artifact>,
  <biomesoplenty:brown_dye>,
  <biomesoplenty:green_dye>,
  <biomesoplenty:biome_finder>
  
    ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }