//This file adds all teleportation items to the teleportation stage, otherwise its disabled for you

import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var teleportationItems as IIngredient[] = [
  <rftools:matter_receiver>,
  <rftools:matter_transmitter>,
  <rftools:matter_booster>,
  <rftools:matter_beamer>,
  <mekanism:portableteleporter>,
  <mekanism:machineblock:11>,
  <mekanism:basicblock:7>,
  <rats:rat_upgrade_ender>,
  <bloodmagic:teleposer>,
  <silentgems:returnhomecharm>,
  <rftools:powercell_card>,
  <appliedenergistics2:quantum_ring>,
  <appliedenergistics2:quantum_link>,
  <mekanism:machineblock3>,
  <enderstorage:ender_pouch>,
  <enderstorage:ender_storage:1>,
  <enderstorage:ender_storage>
];





for item in teleportationItems {

  mods.recipestages.Recipes.setRecipeStage(STAGES.teleportation, item);

}