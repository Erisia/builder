//Basically this file disables all flight unless you have the flight stage

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;



var flightItems as IIngredient[] = [
  <mekanism:armoredjetpack>,
  <mekanism:jetpack>,
  <simplyjetpacks:itemjetpack:*>,
  <rftools:flight_module>,
  <silentgems:chaosrune>,
  <simplyjetpacks:metaitemmods:6>,
  <simplyjetpacks:metaitemmods:5>,
  <openglider:hang_glider_basic>,
  <openglider:hang_glider_advanced>,
  <enderio:item_dark_steel_upgrade:1>,
  <enderio:item_dark_steel_upgrade:1>,
  <simplyjetpacks:metaitemmods:4>,
  <openglider:hang_glider_part:1>,
  <openglider:hang_glider_part>,
  <enderio:item_material:6>
];




for item in flightItems {

  mods.recipestages.Recipes.setRecipeStage(STAGES.flight, item);

}