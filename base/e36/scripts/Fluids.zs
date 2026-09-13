#loader contenttweaker
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;

var molten_duskstone = VanillaFactory.createFluid("molten_duskstone", Color.fromHex("FFFFFF"));
molten_duskstone.temperature = 1500;
molten_duskstone.luminosity = 10;
molten_duskstone.stillLocation = "contenttweaker:fluids/molten_duskstone_still";
molten_duskstone.flowingLocation = "contenttweaker:fluids/molten_duskstone_still_flowing";
molten_duskstone.material = <blockmaterial:water>;
molten_duskstone.register();

var nital = VanillaFactory.createFluid("nital", Color.fromHex("E88484"));
nital.material = <blockmaterial:water>;
nital.register();

var nitalConcentrated = VanillaFactory.createFluid("nital_concentrated", Color.fromHex("C64B4B"));
nitalConcentrated.material = <blockmaterial:water>;
nitalConcentrated.register();

var infinityFluid = VanillaFactory.createFluid("infinity_fluid", Color.fromHex("E0C1FF"));
infinityFluid.material = <blockmaterial:water>;
infinityFluid.register();
