#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import mods.contenttweaker.Material;
import mods.contenttweaker.MaterialPartData;
import mods.contenttweaker.MaterialSystem;

var wroughtIron = mods.contenttweaker.VanillaFactory.createItem("wroughtIron");
wroughtIron.register();

var steel = MaterialSystem.getMaterialBuilder().setName("Steel").setColor(Color.fromHex("878787")).build();
var moltenSteelData = steel.registerPart("molten").getData();
moltenSteelData.addDataValue("density", "2000");
moltenSteelData.addDataValue("viscosity", "6000");
moltenSteelData.addDataValue("temperature", "900");
moltenSteelData.addDataValue("luminosity", "15");

var soulSteel = MaterialSystem.getMaterialBuilder().setName("Soul Steel").setColor(Color.fromHex("5E5E5E")).build();
var moltenSoulSteelData = soulSteel.registerPart("molten").getData();
moltenSoulSteelData.addDataValue("density", "2000");
moltenSoulSteelData.addDataValue("viscosity", "6000");
moltenSoulSteelData.addDataValue("temperature", "900");
moltenSoulSteelData.addDataValue("luminosity", "15");