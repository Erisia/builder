import minetweaker.item.IItemStack;
import mods.nei.NEI;

val disabled = [
// Disabled for performance reasons.
  <ExtraUtilities:nodeUpgrade>, // Speed Upgrade
  <ExtraUtilities:pipes>, // Transfer Pipe
  <ExtraUtilities:pipes.1>, // Hyper-Rationing Pipe
  <Railcraft:cart.loco.electric>, // Electric Locomotive
  <Thaumcraft:blockTube>, // Essentia Tube
// Disabled because of duplication.
  <Magneticraft:electricfurnace>, // Electric Furnace
  <Magneticraft:miner>, // Miner
// Only Eln gets to produce power.
  <Magneticraft:basic_generator>, // Basic Generator
  <Magneticraft:biomassburner>, // Biomass Burner
  <Magneticraft:combustion_engine>, // Combustion Engine
  <Magneticraft:kinetic_generator>, // Kinetic Generator
  <Magneticraft:solarpanel>, // Solar Panel
  <Magneticraft:steam_engine>, // Steam Engine
  <Magneticraft:stirling_generator>, // Stirling Generator Control
  <Magneticraft:thermopile>, // Thermopile
  <Magneticraft:turbine_control>, // Turbine Control
  <Magneticraft:windturbine>,  // Wind turbine
  <Railcraft:cart.redstone.flux>, // Redstone Flux Cart
  <Railcraft:part.turbine.blade>, // Turbine Blade
  <Railcraft:part.turbine.disk>, // Turbine Disk
  <Railcraft:part.turbine.rotor>, // Turbine Rotor
  <Railcraft:machine.alpha:1>, // Steam Turbine Housing
  <ThermalExpansion:Dynamo>, // Steam Dynamo
// I want you to use lots of power.
  <NuclearCraft:upgradeEnergy>,
  <Mekanism:EnergyUpgrade>
] as IItemStack[];


for item in disabled {
  recipes.remove(item);
  NEI.hide(item);
}

