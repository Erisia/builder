#loader contenttweaker

import mods.contenttweaker.Color;
import mods.contenttweaker.MaterialSystem;

var color1 = Color.fromHex("5bb9d9") as Color;
var demonSteel1 = MaterialSystem.getMaterialBuilder().setName("Demonic Steel").setColor(color1).build();
demonSteel1.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var molten1 = demonSteel1.registerPart("molten").getData();
molten1.addDataValue("temperature", "400");
molten1.addDataValue("luminosity", "10");
var block1 = demonSteel1.registerPart("block").getData();
block1.addDataValue("hardness", "3");
block1.addDataValue("resistance", "30");
block1.addDataValue("harvestTool", "pickaxe");

var color2 = Color.fromHex("43ba63") as Color;
var demonSteel2 = MaterialSystem.getMaterialBuilder().setName("Corrosive Steel").setColor(color2).build();
demonSteel2.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var molten2 = demonSteel2.registerPart("molten").getData();
molten2.addDataValue("temperature", "400");
molten2.addDataValue("luminosity", "10");
var block2 = demonSteel2.registerPart("block").getData();
block2.addDataValue("hardness", "3");
block2.addDataValue("resistance", "30");
block2.addDataValue("harvestTool", "pickaxe");

var color3 = Color.fromHex("debf59") as Color;
var demonSteel3 = MaterialSystem.getMaterialBuilder().setName("Destructive Steel").setColor(color3).build();
demonSteel3.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var molten3 = demonSteel3.registerPart("molten").getData();
molten3.addDataValue("temperature", "400");
molten3.addDataValue("luminosity", "10");
var block3 = demonSteel3.registerPart("block").getData();
block3.addDataValue("hardness", "3");
block3.addDataValue("resistance", "30");
block3.addDataValue("harvestTool", "pickaxe");

var color4 = Color.fromHex("e05c53") as Color;
var demonSteel4 = MaterialSystem.getMaterialBuilder().setName("Vengeful Steel").setColor(color4).build();
demonSteel4.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var molten4 = demonSteel4.registerPart("molten").getData();
molten4.addDataValue("temperature", "400");
molten4.addDataValue("luminosity", "10");
var block4 = demonSteel4.registerPart("block").getData();
block4.addDataValue("hardness", "3");
block4.addDataValue("resistance", "30");
block4.addDataValue("harvestTool", "pickaxe");

var color5 = Color.fromHex("9364a3") as Color;
var demonSteel5 = MaterialSystem.getMaterialBuilder().setName("Steadfast Steel").setColor(color5).build();
demonSteel5.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var molten5 = demonSteel5.registerPart("molten").getData();
molten5.addDataValue("temperature", "400");
molten5.addDataValue("luminosity", "10");
var block5 = demonSteel5.registerPart("block").getData();
block5.addDataValue("hardness", "3");
block5.addDataValue("resistance", "30");
block5.addDataValue("harvestTool", "pickaxe");

var colorbloodf = Color.fromHex("330909") as Color;
var mastersteel = MaterialSystem.getMaterialBuilder().setName("Bloodmaster Metal").setColor(colorbloodf).build();
mastersteel.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenmast = mastersteel.registerPart("molten").getData();
moltenmast.addDataValue("temperature", "400");
moltenmast.addDataValue("luminosity", "10");
var blockmast = mastersteel.registerPart("block").getData();
blockmast.addDataValue("hardness", "3");
blockmast.addDataValue("resistance", "30");
blockmast.addDataValue("harvestTool", "pickaxe");
var armormast = mastersteel.registerPart("armor").getData();
armormast.addDataValue("durability", "2500");
armormast.addDataValue("enchantability", "10");
armormast.addDataValue("reduction", "4,7,9,5");
armormast.addDataValue("toughness", "6");

var colordread = Color.fromHex("25004a") as Color;
var dreadite = MaterialSystem.getMaterialBuilder().setName("Dreadite").setColor(colordread).build();
dreadite.registerParts(["gear", "plate", "nugget", "ingot", "dust", "rod"] as string[]);
var moltendread = dreadite.registerPart("molten").getData();
moltendread.addDataValue("temperature", "400");
moltendread.addDataValue("luminosity", "10");
var blockdread = dreadite.registerPart("block").getData();
blockdread.addDataValue("hardness", "3");
blockdread.addDataValue("resistance", "30");
blockdread.addDataValue("harvestTool", "pickaxe");

var colordreadal = Color.fromHex("cf80cb") as Color;
var dreaditeall = MaterialSystem.getMaterialBuilder().setName("Dreaded Steel").setColor(colordreadal).build();
dreaditeall.registerParts(["gear", "plate", "nugget", "ingot", "rod", "dust"] as string[]);
var moltendreadal = dreaditeall.registerPart("molten").getData();
moltendreadal.addDataValue("temperature", "400");
moltendreadal.addDataValue("luminosity", "10");
var blockdreadal = dreaditeall.registerPart("block").getData();
blockdreadal.addDataValue("hardness", "3");
blockdreadal.addDataValue("resistance", "30");
blockdreadal.addDataValue("harvestTool", "pickaxe");

var colorsednanite = Color.fromHex("e3d8d8") as Color;
var sednanite = MaterialSystem.getMaterialBuilder().setName("Sednanite").setColor(colorsednanite).build();
sednanite.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltensednanite = sednanite.registerPart("molten").getData();
moltensednanite.addDataValue("temperature", "800");
moltensednanite.addDataValue("luminosity", "12");
var oresednanite = sednanite.registerPart("ore").getData();
oresednanite.addDataValue("variants", "minecraft:stone");
oresednanite.addDataValue("hardness", "3");
oresednanite.addDataValue("resistance", "15");
oresednanite.addDataValue("harvestLevel", "5");
oresednanite.addDataValue("harvestTool", "pickaxe");

var colortartarite = Color.fromHex("1d1f1e") as Color;
var tartarite = MaterialSystem.getMaterialBuilder().setName("Tartarite").setColor(colortartarite).build();
tartarite.registerParts(["dust", "rod"] as string[]);
var oretartarite = tartarite.registerPart("ore").getData();
oretartarite.addDataValue("variants", "minecraft:stone");
oretartarite.addDataValue("hardness", "3");
oretartarite.addDataValue("resistance", "15");
oretartarite.addDataValue("harvestLevel", "5");
oretartarite.addDataValue("harvestTool", "pickaxe");

var colorfluctuatite = Color.fromHex("ffb300") as Color;
var fluctuatite = MaterialSystem.getMaterialBuilder().setName("Fluctuatite").setColor(colorfluctuatite).build();
fluctuatite.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenfluctuatite = fluctuatite.registerPart("molten").getData();
moltenfluctuatite.addDataValue("temperature", "800");
moltenfluctuatite.addDataValue("luminosity", "12");
var orefluctuatite = fluctuatite.registerPart("ore").getData();
orefluctuatite.addDataValue("variants", "minecraft:stone");
orefluctuatite.addDataValue("hardness", "3");
orefluctuatite.addDataValue("resistance", "15");
orefluctuatite.addDataValue("harvestLevel", "5");
orefluctuatite.addDataValue("harvestTool", "pickaxe");

var colorvibranium = Color.fromHex("3e436b") as Color;
var vibranium = MaterialSystem.getMaterialBuilder().setName("Vibranium").setColor(colorvibranium).build();
vibranium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenvibranium = vibranium.registerPart("molten").getData();
moltenvibranium.addDataValue("temperature", "400");
moltenvibranium.addDataValue("luminosity", "10");
var blockvibranium = vibranium.registerPart("block").getData();
blockvibranium.addDataValue("hardness", "3");
blockvibranium.addDataValue("resistance", "30");
blockvibranium.addDataValue("harvestTool", "pickaxe");
var armorvibranium = vibranium.registerPart("armor").getData();
armorvibranium.addDataValue("durability", "2500");
armorvibranium.addDataValue("enchantability", "10");
armorvibranium.addDataValue("reduction", "5,7,8,5");
armorvibranium.addDataValue("toughness", "5");

var colorrhenium = Color.fromHex("302f2f") as Color;
var rhenium = MaterialSystem.getMaterialBuilder().setName("Rhenium").setColor(colorrhenium).build();
rhenium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenrhenium = rhenium.registerPart("molten").getData();
moltenrhenium.addDataValue("temperature", "800");
moltenrhenium.addDataValue("luminosity", "12");
var orerhenium = rhenium.registerPart("ore").getData();
orerhenium.addDataValue("variants", "minecraft:stone");
orerhenium.addDataValue("hardness", "3");
orerhenium.addDataValue("resistance", "15");
orerhenium.addDataValue("harvestLevel", "5");
orerhenium.addDataValue("harvestTool", "pickaxe");

var colormyrmitite = Color.fromHex("735c3b") as Color;
var myrmitite = MaterialSystem.getMaterialBuilder().setName("Myrmitite").setColor(colormyrmitite).build();
myrmitite.registerParts(["nugget", "ingot", "dust", "plate", "rod"] as string[]);
var moltenmyrmitite = myrmitite.registerPart("molten").getData();
moltenmyrmitite.addDataValue("temperature", "800");
moltenmyrmitite.addDataValue("luminosity", "12");
var oremyrmitite = myrmitite.registerPart("ore").getData();
oremyrmitite.addDataValue("variants", "minecraft:stone");
oremyrmitite.addDataValue("hardness", "3");
oremyrmitite.addDataValue("resistance", "15");
oremyrmitite.addDataValue("harvestLevel", "5");
oremyrmitite.addDataValue("harvestTool", "pickaxe");
var blockmyrmitite = myrmitite.registerPart("block").getData();
blockmyrmitite.addDataValue("hardness", "3");
blockmyrmitite.addDataValue("resistance", "30");
blockmyrmitite.addDataValue("harvestTool", "pickaxe");

var colorcandyte = Color.fromHex("c769a9") as Color;
var candyte = MaterialSystem.getMaterialBuilder().setName("Candyte").setColor(colorcandyte).build();
candyte.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltencandyte = candyte.registerPart("molten").getData();
moltencandyte.addDataValue("temperature", "800");
moltencandyte.addDataValue("luminosity", "12");
var orecandyte = candyte.registerPart("ore").getData();
orecandyte.addDataValue("variants", "minecraft:stone");
orecandyte.addDataValue("hardness", "3");
orecandyte.addDataValue("resistance", "15");
orecandyte.addDataValue("harvestLevel", "5");
orecandyte.addDataValue("harvestTool", "pickaxe");
var blockcandyte = candyte.registerPart("block").getData();
blockcandyte.addDataValue("hardness", "3");
blockcandyte.addDataValue("resistance", "30");
blockcandyte.addDataValue("harvestTool", "pickaxe");

var colorpalladium = Color.fromHex("917a8a") as Color;
var palladium = MaterialSystem.getMaterialBuilder().setName("Palladium").setColor(colorpalladium).build();
palladium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenpalladium = palladium.registerPart("molten").getData();
moltenpalladium.addDataValue("temperature", "800");
moltenpalladium.addDataValue("luminosity", "12");
var orepalladium = palladium.registerPart("ore").getData();
orepalladium.addDataValue("variants", "minecraft:stone");
orepalladium.addDataValue("hardness", "3");
orepalladium.addDataValue("resistance", "15");
orepalladium.addDataValue("harvestLevel", "5");
orepalladium.addDataValue("harvestTool", "pickaxe");
var blockpalladium = palladium.registerPart("block").getData();
blockpalladium.addDataValue("hardness", "3");
blockpalladium.addDataValue("resistance", "30");
blockpalladium.addDataValue("harvestTool", "pickaxe");

var colorvityte = Color.fromHex("0e8f42") as Color;
var vityte = MaterialSystem.getMaterialBuilder().setName("Vityte").setColor(colorvityte).build();
vityte.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenvityte = vityte.registerPart("molten").getData();
moltenvityte.addDataValue("temperature", "800");
moltenvityte.addDataValue("luminosity", "12");
var orevityte = vityte.registerPart("ore").getData();
orevityte.addDataValue("variants", "minecraft:stone");
orevityte.addDataValue("hardness", "3");
orevityte.addDataValue("resistance", "15");
orevityte.addDataValue("harvestLevel", "5");
orevityte.addDataValue("harvestTool", "pickaxe");
var blockvityte = vityte.registerPart("block").getData();
blockvityte.addDataValue("hardness", "3");
blockvityte.addDataValue("resistance", "30");
blockvityte.addDataValue("harvestTool", "pickaxe");

var colorpolonium = Color.fromHex("486e96") as Color;
var polonium = MaterialSystem.getMaterialBuilder().setName("Polonium").setColor(colorpolonium).build();
polonium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenpolonium = polonium.registerPart("molten").getData();
moltenpolonium.addDataValue("temperature", "800");
moltenpolonium.addDataValue("luminosity", "12");
var orepolonium = polonium.registerPart("ore").getData();
orepolonium.addDataValue("variants", "minecraft:stone");
orepolonium.addDataValue("hardness", "3");
orepolonium.addDataValue("resistance", "15");
orepolonium.addDataValue("harvestLevel", "5");
orepolonium.addDataValue("harvestTool", "pickaxe");
var blockpolonium = polonium.registerPart("block").getData();
blockpolonium.addDataValue("hardness", "3");
blockpolonium.addDataValue("resistance", "30");
blockpolonium.addDataValue("harvestTool", "pickaxe");

var colorogerite = Color.fromHex("086600") as Color;
var ogerite = MaterialSystem.getMaterialBuilder().setName("Ogerite").setColor(colorogerite).build();
ogerite.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenogerite = ogerite.registerPart("molten").getData();
moltenogerite.addDataValue("temperature", "800");
moltenogerite.addDataValue("luminosity", "12");
var oreogerite = ogerite.registerPart("ore").getData();
oreogerite.addDataValue("variants", "minecraft:stone");
oreogerite.addDataValue("hardness", "3");
oreogerite.addDataValue("resistance", "15");
oreogerite.addDataValue("harvestLevel", "5");
oreogerite.addDataValue("harvestTool", "pickaxe");
var blockogerite = ogerite.registerPart("block").getData();
blockogerite.addDataValue("hardness", "3");
blockogerite.addDataValue("resistance", "30");
blockogerite.addDataValue("harvestTool", "pickaxe");

var colorprimalogerite = Color.fromHex("14ad07") as Color;
var primalogerite = MaterialSystem.getMaterialBuilder().setName("Primal Ogerite").setColor(colorprimalogerite).build();
primalogerite.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenprimalogerite = primalogerite.registerPart("molten").getData();
moltenprimalogerite.addDataValue("temperature", "800");
moltenprimalogerite.addDataValue("luminosity", "12");

var colorhotvibraniumalloy = Color.fromHex("00ddff") as Color;
var hotvibraniumalloy = MaterialSystem.getMaterialBuilder().setName("Hot Vibranium Alloy").setColor(colorhotvibraniumalloy).build();
hotvibraniumalloy.registerParts(["ingot", "rod"] as string[]);

var colorvibraniumalloy = Color.fromHex("1e2742") as Color;
var vibraniumalloy = MaterialSystem.getMaterialBuilder().setName("Vibranium Alloy").setColor(colorvibraniumalloy).build();
vibraniumalloy.registerParts(["nugget", "ingot", "plate", "gear", "rod"] as string[]);

var colorlunastone = Color.fromHex("945dcf") as Color;
var lunastone = MaterialSystem.getMaterialBuilder().setName("Lunastone").setColor(colorlunastone).build();
lunastone.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenlunastone = lunastone.registerPart("molten").getData();
moltenlunastone.addDataValue("temperature", "800");
moltenlunastone.addDataValue("luminosity", "12");
var orelunastone = lunastone.registerPart("ore").getData();
orelunastone.addDataValue("variants", "minecraft:stone");
orelunastone.addDataValue("hardness", "3");
orelunastone.addDataValue("resistance", "15");
orelunastone.addDataValue("harvestLevel", "5");
orelunastone.addDataValue("harvestTool", "pickaxe");
var blocklunastone = lunastone.registerPart("block").getData();
blocklunastone.addDataValue("hardness", "3");
blocklunastone.addDataValue("resistance", "30");
blocklunastone.addDataValue("harvestTool", "pickaxe");

var colorchalcedony = Color.fromHex("5dc4cf") as Color;
var chalcedony = MaterialSystem.getMaterialBuilder().setName("Chalcedony").setColor(colorchalcedony).build();
chalcedony.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenchalcedony = chalcedony.registerPart("molten").getData();
moltenchalcedony.addDataValue("temperature", "800");
moltenchalcedony.addDataValue("luminosity", "12");
var orechalcedony = chalcedony.registerPart("ore").getData();
orechalcedony.addDataValue("variants", "minecraft:stone");
orechalcedony.addDataValue("hardness", "3");
orechalcedony.addDataValue("resistance", "15");
orechalcedony.addDataValue("harvestLevel", "5");
orechalcedony.addDataValue("harvestTool", "pickaxe");
var blockchalcedony = chalcedony.registerPart("block").getData();
blockchalcedony.addDataValue("hardness", "3");
blockchalcedony.addDataValue("resistance", "30");
blockchalcedony.addDataValue("harvestTool", "pickaxe");

var colorbrightsteel = Color.fromHex("ffffff") as Color;
var brightsteel = MaterialSystem.getMaterialBuilder().setName("Brightsteel").setColor(colorbrightsteel).build();
brightsteel.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenbrightsteel = brightsteel.registerPart("molten").getData();
moltenbrightsteel.addDataValue("temperature", "800");
moltenbrightsteel.addDataValue("luminosity", "12");
var orebrightsteel = brightsteel.registerPart("ore").getData();
orebrightsteel.addDataValue("variants", "minecraft:stone");
orebrightsteel.addDataValue("hardness", "3");
orebrightsteel.addDataValue("resistance", "15");
orebrightsteel.addDataValue("harvestLevel", "5");
orebrightsteel.addDataValue("harvestTool", "pickaxe");
var blockbrightsteel = brightsteel.registerPart("block").getData();
blockbrightsteel.addDataValue("hardness", "3");
blockbrightsteel.addDataValue("resistance", "30");
blockbrightsteel.addDataValue("harvestTool", "pickaxe");
var armorbrightsteel = brightsteel.registerPart("armor").getData();
armorbrightsteel.addDataValue("durability", "1500000");
armorbrightsteel.addDataValue("enchantability", "10");
armorbrightsteel.addDataValue("reduction", "7,10,12,6");
armorbrightsteel.addDataValue("toughness", "15");

var colorcaesium = Color.fromHex("426334") as Color;
var caesium = MaterialSystem.getMaterialBuilder().setName("Caesium").setColor(colorcaesium).build();
caesium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltencaesium = caesium.registerPart("molten").getData();
moltencaesium.addDataValue("temperature", "800");
moltencaesium.addDataValue("luminosity", "12");

var colorstrontium = Color.fromHex("76677a") as Color;
var strontium = MaterialSystem.getMaterialBuilder().setName("Strontium").setColor(colorstrontium).build();
strontium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenstrontium = strontium.registerPart("molten").getData();
moltenstrontium.addDataValue("temperature", "800");
moltenstrontium.addDataValue("luminosity", "12");

var colorrubidium = Color.fromHex("827f68") as Color;
var rubidium = MaterialSystem.getMaterialBuilder().setName("Rubidium").setColor(colorrubidium).build();
rubidium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenrubidium = rubidium.registerPart("molten").getData();
moltenrubidium.addDataValue("temperature", "800");
moltenrubidium.addDataValue("luminosity", "12");

var colorchaos = Color.fromHex("080221") as Color;
var chaos = MaterialSystem.getMaterialBuilder().setName("Chaos").setColor(colorchaos).build();
chaos.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenchaos = chaos.registerPart("molten").getData();
moltenchaos.addDataValue("temperature", "800");
moltenchaos.addDataValue("luminosity", "12");

var colorhassium = Color.fromHex("555559") as Color;
var hassium = MaterialSystem.getMaterialBuilder().setName("Hassium").setColor(colorhassium).build();
hassium.registerParts(["nugget", "ingot", "plate", "gear", "rod"] as string[]);

var colorhalite = Color.fromHex("17c414") as Color;
var halite = MaterialSystem.getMaterialBuilder().setName("Fractallite Halite").setColor(colorhalite).build();
halite.registerParts(["ingot", "rod"] as string[]);
var armorhalite = halite.registerPart("armor").getData();
armorhalite.addDataValue("durability", "9500000");
armorhalite.addDataValue("enchantability", "100");
armorhalite.addDataValue("reduction", "200,200,200,200");
armorhalite.addDataValue("toughness", "200");

var colorabyssite = Color.fromHex("1beb00") as Color;
var abyssite = MaterialSystem.getMaterialBuilder().setName("Abyssite").setColor(colorabyssite).build();
abyssite.registerParts(["ingot", "rod"] as string[]);
var moltenabyssite = abyssite.registerPart("molten").getData();
moltenabyssite.addDataValue("temperature", "800");
moltenabyssite.addDataValue("luminosity", "12");

var colorsacrificemetal = Color.fromHex("210042") as Color;
var sacrificemetal = MaterialSystem.getMaterialBuilder().setName("Sacrifice Metal").setColor(colorsacrificemetal).build();
sacrificemetal.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltensacrificemetal = sacrificemetal.registerPart("molten").getData();
moltensacrificemetal.addDataValue("temperature", "800");
moltensacrificemetal.addDataValue("luminosity", "12");
var blocksacrificemetal = sacrificemetal.registerPart("block").getData();
blocksacrificemetal.addDataValue("hardness", "3");
blocksacrificemetal.addDataValue("resistance", "30");
blocksacrificemetal.addDataValue("harvestTool", "pickaxe");
var armorsacrificemetal = sacrificemetal.registerPart("armor").getData();
armorsacrificemetal.addDataValue("durability", "9500000");
armorsacrificemetal.addDataValue("enchantability", "100");
armorsacrificemetal.addDataValue("reduction", "8,10,15,7");
armorsacrificemetal.addDataValue("toughness", "20");

var colorblackmetal = Color.fromHex("000000") as Color;
var blackmetal = MaterialSystem.getMaterialBuilder().setName("Black Metal").setColor(colorblackmetal).build();
blackmetal.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenblackmetal = blackmetal.registerPart("molten").getData();
moltenblackmetal.addDataValue("temperature", "800");
moltenblackmetal.addDataValue("luminosity", "12");
var blockblackmetal = blackmetal.registerPart("block").getData();
blockblackmetal.addDataValue("hardness", "3");
blockblackmetal.addDataValue("resistance", "30");
blockblackmetal.addDataValue("harvestTool", "pickaxe");
var armorblackmetal = blackmetal.registerPart("armor").getData();
armorblackmetal.addDataValue("durability", "1500000");
armorblackmetal.addDataValue("enchantability", "100");
armorblackmetal.addDataValue("reduction", "8,9,12,7");
armorblackmetal.addDataValue("toughness", "3");

var colorpromethium = Color.fromHex("7df59d") as Color;
var promethium = MaterialSystem.getMaterialBuilder().setName("Promethium").setColor(colorpromethium).build();
promethium.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltenpromethium = promethium.registerPart("molten").getData();
moltenpromethium.addDataValue("temperature", "800");
moltenpromethium.addDataValue("luminosity", "12");

var colordamascus = Color.fromHex("c9cad4") as Color;
var damascussteel = MaterialSystem.getMaterialBuilder().setName("Sideral Damascus Steel").setColor(colordamascus).build();
damascussteel.registerParts(["nugget", "ingot", "dust", "rod"] as string[]);
var moltendamascussteel = damascussteel.registerPart("molten").getData();
moltendamascussteel.addDataValue("temperature", "800");
moltendamascussteel.addDataValue("luminosity", "12");
var armordamascussteel = damascussteel.registerPart("armor").getData();
armordamascussteel.addDataValue("durability", "950000");
armordamascussteel.addDataValue("enchantability", "100");
armordamascussteel.addDataValue("reduction", "10,12,17,9");
armordamascussteel.addDataValue("toughness", "25");

var colorosiris = Color.fromHex("8c443c") as Color;
var osiris = MaterialSystem.getMaterialBuilder().setName("Osiris").setColor(colorosiris).build();
osiris.registerParts(["plate"] as string[]);
var armorosiris = osiris.registerPart("armor").getData();
armorosiris.addDataValue("durability", "5642");
armorosiris.addDataValue("enchantability", "88");
armorosiris.addDataValue("reduction", "4,7,9,5");
armorosiris.addDataValue("toughness", "7");

var colorptah = Color.fromHex("fca532") as Color;
var ptah = MaterialSystem.getMaterialBuilder().setName("Ptah").setColor(colorptah).build();
ptah.registerParts(["plate"] as string[]);
var armorptah = ptah.registerPart("armor").getData();
armorptah.addDataValue("durability", "5642");
armorptah.addDataValue("enchantability", "88");
armorptah.addDataValue("reduction", "4,7,9,5");
armorptah.addDataValue("toughness", "7");

var colorhator = Color.fromHex("e3702d") as Color;
var hator = MaterialSystem.getMaterialBuilder().setName("Hator").setColor(colorhator).build();
hator.registerParts(["plate"] as string[]);
var armorhator = hator.registerPart("armor").getData();
armorhator.addDataValue("durability", "5642");
armorhator.addDataValue("enchantability", "88");
armorhator.addDataValue("reduction", "4,7,9,5");
armorhator.addDataValue("toughness", "7");

var coloreuropa = Color.fromHex("9cbee6") as Color;
var europa = MaterialSystem.getMaterialBuilder().setName("Europa").setColor(coloreuropa).build();
europa.registerParts(["plate"] as string[]);
var armoreuropa = europa.registerPart("armor").getData();
armoreuropa.addDataValue("durability", "5642");
armoreuropa.addDataValue("enchantability", "88");
armoreuropa.addDataValue("reduction", "4,7,9,5");
armoreuropa.addDataValue("toughness", "7");

var coloroi = Color.fromHex("736c43") as Color;
var oi = MaterialSystem.getMaterialBuilder().setName("Oi").setColor(coloroi).build();
oi.registerParts(["plate"] as string[]);
var armoroi = oi.registerPart("armor").getData();
armoroi.addDataValue("durability", "5642");
armoroi.addDataValue("enchantability", "88");
armoroi.addDataValue("reduction", "4,7,9,5");
armoroi.addDataValue("toughness", "7");

var colorfalacer = Color.fromHex("508754") as Color;
var falacer = MaterialSystem.getMaterialBuilder().setName("Falacer").setColor(colorfalacer).build();
falacer.registerParts(["plate"] as string[]);
var armorfalacer = falacer.registerPart("armor").getData();
armorfalacer.addDataValue("durability", "5642");
armorfalacer.addDataValue("enchantability", "88");
armorfalacer.addDataValue("reduction", "4,7,9,5");
armorfalacer.addDataValue("toughness", "7");

var colororcus = Color.fromHex("87505b") as Color;
var orcus = MaterialSystem.getMaterialBuilder().setName("Orcus").setColor(colororcus).build();
orcus.registerParts(["plate"] as string[]);
var armororcus = orcus.registerPart("armor").getData();
armororcus.addDataValue("durability", "5642");
armororcus.addDataValue("enchantability", "88");
armororcus.addDataValue("reduction", "4,7,9,5");
armororcus.addDataValue("toughness", "7");

var colorhaumea = Color.fromHex("de7eb5") as Color;
var haumea = MaterialSystem.getMaterialBuilder().setName("Haumea").setColor(colorhaumea).build();
haumea.registerParts(["plate"] as string[]);
var armorhaumea = haumea.registerPart("armor").getData();
armorhaumea.addDataValue("durability", "5642");
armorhaumea.addDataValue("enchantability", "88");
armorhaumea.addDataValue("reduction", "4,7,9,5");
armorhaumea.addDataValue("toughness", "7");

var colorsedna = Color.fromHex("e6e8ff") as Color;
var sedna = MaterialSystem.getMaterialBuilder().setName("Sedna").setColor(colorsedna).build();
sedna.registerParts(["plate"] as string[]);
var armorsedna = sedna.registerPart("armor").getData();
armorsedna.addDataValue("durability", "5642");
armorsedna.addDataValue("enchantability", "88");
armorsedna.addDataValue("reduction", "4,7,9,5");
armorsedna.addDataValue("toughness", "7");

var colorphasing = Color.fromHex("2bffc3") as Color;
var phasing = MaterialSystem.getMaterialBuilder().setName("Phasing Alloy").setColor(colorphasing).build();
phasing.registerParts(["nugget"] as string[]);
var armorphasing = phasing.registerPart("armor").getData();
armorphasing.addDataValue("durability", "4000");
armorphasing.addDataValue("enchantability", "10");
armorphasing.addDataValue("reduction", "5,8,8,6");
armorphasing.addDataValue("toughness", "6");

var colorwrought = Color.fromHex("636666") as Color;
var wrought = MaterialSystem.getMaterialBuilder().setName("Wrought Plate").setColor(colorwrought).build();
wrought.registerParts(["nugget"] as string[]);
var armorwrought = wrought.registerPart("armor").getData();
armorwrought.addDataValue("durability", "3000");
armorwrought.addDataValue("enchantability", "99");
armorwrought.addDataValue("reduction", "5,6,8,5");
armorwrought.addDataValue("toughness", "5");

var colorchampion = Color.fromHex("ff9747") as Color;
var championtoken = MaterialSystem.getMaterialBuilder().setName("Champion Token").setColor(colorchampion).build();
championtoken.registerParts(["nugget"] as string[]);
var armorchampiontoken = championtoken.registerPart("armor").getData();
armorchampiontoken.addDataValue("durability", "3000");
armorchampiontoken.addDataValue("enchantability", "99");
armorchampiontoken.addDataValue("reduction", "6,9,12,7");
armorchampiontoken.addDataValue("toughness", "7");

var coloreliteeden = Color.fromHex("ffe9a6") as Color;
var eliteeden = MaterialSystem.getMaterialBuilder().setName("Elite Eden").setColor(coloreliteeden).build();
eliteeden.registerParts(["nugget"] as string[]);
var armoreliteeden = eliteeden.registerPart("armor").getData();
armoreliteeden.addDataValue("durability", "5100");
armoreliteeden.addDataValue("enchantability", "99");
armoreliteeden.addDataValue("reduction", "8,14,18,7");
armoreliteeden.addDataValue("toughness", "15");

var colorelitewildwood = Color.fromHex("96e7ff") as Color;
var elitewildwood = MaterialSystem.getMaterialBuilder().setName("Elite Wildwood").setColor(colorelitewildwood).build();
elitewildwood.registerParts(["nugget"] as string[]);
var armorelitewildwood = elitewildwood.registerPart("armor").getData();
armorelitewildwood.addDataValue("durability", "3900");
armorelitewildwood.addDataValue("enchantability", "99");
armorelitewildwood.addDataValue("reduction", "10,16,20,9");
armorelitewildwood.addDataValue("toughness", "20");

var coloreliteapalachia = Color.fromHex("f39cff") as Color;
var eliteapalachia = MaterialSystem.getMaterialBuilder().setName("Elite Apalachia").setColor(coloreliteapalachia).build();
eliteapalachia.registerParts(["nugget"] as string[]);
var armoreliteapalachia = eliteapalachia.registerPart("armor").getData();
armoreliteapalachia.addDataValue("durability", "6900");
armoreliteapalachia.addDataValue("enchantability", "99");
armoreliteapalachia.addDataValue("reduction", "12,18,22,11");
armoreliteapalachia.addDataValue("toughness", "25");

var coloreliteskythern = Color.fromHex("ffffff") as Color;
var eliteskythern = MaterialSystem.getMaterialBuilder().setName("Elite Skythern").setColor(coloreliteskythern).build();
eliteskythern.registerParts(["nugget"] as string[]);
var armoreliteskythern = eliteskythern.registerPart("armor").getData();
armoreliteskythern.addDataValue("durability", "55555");
armoreliteskythern.addDataValue("enchantability", "99");
armoreliteskythern.addDataValue("reduction", "16,20,26,18");
armoreliteskythern.addDataValue("toughness", "25");

var colorelitemortum = Color.fromHex("967e7e") as Color;
var elitemortum = MaterialSystem.getMaterialBuilder().setName("Elite Mortum").setColor(colorelitemortum).build();
elitemortum.registerParts(["nugget"] as string[]);
var armorelitemortum = elitemortum.registerPart("armor").getData();
armorelitemortum.addDataValue("durability", "66666");
armorelitemortum.addDataValue("enchantability", "99");
armorelitemortum.addDataValue("reduction", "16,20,26,18");
armorelitemortum.addDataValue("toughness", "35");

var colorabysstoken = Color.fromHex("2e3033") as Color;
var abysstoken = MaterialSystem.getMaterialBuilder().setName("Abyss Token").setColor(colorabysstoken).build();
abysstoken.registerParts(["nugget"] as string[]);
var armorabysstoken = abysstoken.registerPart("armor").getData();
armorabysstoken.addDataValue("durability", "2000");
armorabysstoken.addDataValue("enchantability", "99");
armorabysstoken.addDataValue("reduction", "2,5,6,2");
armorabysstoken.addDataValue("toughness", "1");

var colorbarontoken = Color.fromHex("7a3d56") as Color;
var barontoken = MaterialSystem.getMaterialBuilder().setName("Baron Token").setColor(colorbarontoken).build();
barontoken.registerParts(["nugget"] as string[]);
var armorbarontoken = barontoken.registerPart("armor").getData();
armorbarontoken.addDataValue("durability", "2000");
armorbarontoken.addDataValue("enchantability", "99");
armorbarontoken.addDataValue("reduction", "2,5,6,2");
armorbarontoken.addDataValue("toughness", "1");

var colorboreantoken = Color.fromHex("763d99") as Color;
var boreantoken = MaterialSystem.getMaterialBuilder().setName("Borean Token").setColor(colorboreantoken).build();
boreantoken.registerParts(["nugget"] as string[]);
var armorboreantoken = boreantoken.registerPart("armor").getData();
armorboreantoken.addDataValue("durability", "2000");
armorboreantoken.addDataValue("enchantability", "99");
armorboreantoken.addDataValue("reduction", "2,5,6,2");
armorboreantoken.addDataValue("toughness", "3");

var colorcandylandtoken = Color.fromHex("21f8ff") as Color;
var candylandtoken = MaterialSystem.getMaterialBuilder().setName("Candyland Token").setColor(colorcandylandtoken).build();
candylandtoken.registerParts(["nugget"] as string[]);
var armorcandylandtoken = candylandtoken.registerPart("armor").getData();
armorcandylandtoken.addDataValue("durability", "2000");
armorcandylandtoken.addDataValue("enchantability", "99");
armorcandylandtoken.addDataValue("reduction", "2,5,6,2");
armorcandylandtoken.addDataValue("toughness", "2");

var colorcelevetoken = Color.fromHex("872d96") as Color;
var celevetoken = MaterialSystem.getMaterialBuilder().setName("Celeve Token").setColor(colorcelevetoken).build();
celevetoken.registerParts(["nugget"] as string[]);
var armorcelevetoken = celevetoken.registerPart("armor").getData();
armorcelevetoken.addDataValue("durability", "2000");
armorcelevetoken.addDataValue("enchantability", "99");
armorcelevetoken.addDataValue("reduction", "2,5,6,2");
armorcelevetoken.addDataValue("toughness", "2");

var colorcreeponiatoken = Color.fromHex("148f14") as Color;
var creeponiatoken = MaterialSystem.getMaterialBuilder().setName("Creeponia Token").setColor(colorcreeponiatoken).build();
creeponiatoken.registerParts(["nugget"] as string[]);
var armorcreeponiatoken = creeponiatoken.registerPart("armor").getData();
armorcreeponiatoken.addDataValue("durability", "2000");
armorcreeponiatoken.addDataValue("enchantability", "99");
armorcreeponiatoken.addDataValue("reduction", "2,5,6,2");
armorcreeponiatoken.addDataValue("toughness", "1");

var colorcrysteviatoken = Color.fromHex("3f0257") as Color;
var crysteviatoken = MaterialSystem.getMaterialBuilder().setName("Crystevia Token").setColor(colorcrysteviatoken).build();
crysteviatoken.registerParts(["nugget"] as string[]);
var armorcrysteviatoken = crysteviatoken.registerPart("armor").getData();
armorcrysteviatoken.addDataValue("durability", "2000");
armorcrysteviatoken.addDataValue("enchantability", "99");
armorcrysteviatoken.addDataValue("reduction", "2,5,6,2");
armorcrysteviatoken.addDataValue("toughness", "2");

var colordeeplandstoken = Color.fromHex("5c5c5c") as Color;
var deeplandstoken = MaterialSystem.getMaterialBuilder().setName("Deeplands Token").setColor(colordeeplandstoken).build();
deeplandstoken.registerParts(["nugget"] as string[]);
var armordeeplandstoken = deeplandstoken.registerPart("armor").getData();
armordeeplandstoken.addDataValue("durability", "2000");
armordeeplandstoken.addDataValue("enchantability", "99");
armordeeplandstoken.addDataValue("reduction", "2,5,6,2");
armordeeplandstoken.addDataValue("toughness", "1");

var colordustopiatoken = Color.fromHex("1f1f1f") as Color;
var dustopiatoken = MaterialSystem.getMaterialBuilder().setName("Dustopia Token").setColor(colordustopiatoken).build();
dustopiatoken.registerParts(["nugget"] as string[]);
var armordustopiatoken = dustopiatoken.registerPart("armor").getData();
armordustopiatoken.addDataValue("durability", "2000");
armordustopiatoken.addDataValue("enchantability", "99");
armordustopiatoken.addDataValue("reduction", "2,5,6,2");
armordustopiatoken.addDataValue("toughness", "4");

var colorgardenciatoken = Color.fromHex("2d7536") as Color;
var gardenciatoken = MaterialSystem.getMaterialBuilder().setName("Gardencia Token").setColor(colorgardenciatoken).build();
gardenciatoken.registerParts(["nugget"] as string[]);
var armorgardenciatoken = gardenciatoken.registerPart("armor").getData();
armorgardenciatoken.addDataValue("durability", "2000");
armorgardenciatoken.addDataValue("enchantability", "99");
armorgardenciatoken.addDataValue("reduction", "2,5,6,2");
armorgardenciatoken.addDataValue("toughness", "2");

var colorgreckontoken = Color.fromHex("4e0057") as Color;
var greckontoken = MaterialSystem.getMaterialBuilder().setName("Greckon Token").setColor(colorgreckontoken).build();
greckontoken.registerParts(["nugget"] as string[]);
var armorgreckontoken = greckontoken.registerPart("armor").getData();
armorgreckontoken.addDataValue("durability", "2000");
armorgreckontoken.addDataValue("enchantability", "99");
armorgreckontoken.addDataValue("reduction", "2,5,6,2");
armorgreckontoken.addDataValue("toughness", "4");

var colorhaventoken = Color.fromHex("00ffa2") as Color;
var haventoken = MaterialSystem.getMaterialBuilder().setName("Haven Token").setColor(colorhaventoken).build();
haventoken.registerParts(["nugget"] as string[]);
var armorhaventoken = haventoken.registerPart("armor").getData();
armorhaventoken.addDataValue("durability", "2000");
armorhaventoken.addDataValue("enchantability", "99");
armorhaventoken.addDataValue("reduction", "2,5,6,2");
armorhaventoken.addDataValue("toughness", "2");

var colorirominetoken = Color.fromHex("787000") as Color;
var irominetoken = MaterialSystem.getMaterialBuilder().setName("Iromine Token").setColor(colorirominetoken).build();
irominetoken.registerParts(["nugget"] as string[]);
var armorirominetoken = irominetoken.registerPart("armor").getData();
armorirominetoken.addDataValue("durability", "2000");
armorirominetoken.addDataValue("enchantability", "99");
armorirominetoken.addDataValue("reduction", "2,5,6,2");
armorirominetoken.addDataValue("toughness", "2");

var colorlelyetiatoken = Color.fromHex("a1740b") as Color;
var lelyetiatoken = MaterialSystem.getMaterialBuilder().setName("Lelyetia Token").setColor(colorlelyetiatoken).build();
lelyetiatoken.registerParts(["nugget"] as string[]);
var armorlelyetiatoken = lelyetiatoken.registerPart("armor").getData();
armorlelyetiatoken.addDataValue("durability", "2000");
armorlelyetiatoken.addDataValue("enchantability", "99");
armorlelyetiatoken.addDataValue("reduction", "2,5,6,2");
armorlelyetiatoken.addDataValue("toughness", "1");

var colorlunartoken = Color.fromHex("b500a9") as Color;
var lunartoken = MaterialSystem.getMaterialBuilder().setName("Lunar Token").setColor(colorlunartoken).build();
lunartoken.registerParts(["nugget"] as string[]);
var armorlunartoken = lunartoken.registerPart("armor").getData();
armorlunartoken.addDataValue("durability", "2000");
armorlunartoken.addDataValue("enchantability", "99");
armorlunartoken.addDataValue("reduction", "2,5,6,2");
armorlunartoken.addDataValue("toughness", "3");

var colormysteriumtoken = Color.fromHex("005387") as Color;
var mysteriumtoken = MaterialSystem.getMaterialBuilder().setName("Mysterium Token").setColor(colormysteriumtoken).build();
mysteriumtoken.registerParts(["nugget"] as string[]);
var armormysteriumtoken = mysteriumtoken.registerPart("armor").getData();
armormysteriumtoken.addDataValue("durability", "2000");
armormysteriumtoken.addDataValue("enchantability", "99");
armormysteriumtoken.addDataValue("reduction", "2,5,6,2");
armormysteriumtoken.addDataValue("toughness", "2");

var colornethertoken = Color.fromHex("bd204a") as Color;
var nethertoken = MaterialSystem.getMaterialBuilder().setName("Nether Token").setColor(colornethertoken).build();
nethertoken.registerParts(["nugget"] as string[]);
var armornethertoken = nethertoken.registerPart("armor").getData();
armornethertoken.addDataValue("durability", "2000");
armornethertoken.addDataValue("enchantability", "99");
armornethertoken.addDataValue("reduction", "2,5,6,2");
armornethertoken.addDataValue("toughness", "1");

var colorprecasiatoken = Color.fromHex("7fc227") as Color;
var precasiatoken = MaterialSystem.getMaterialBuilder().setName("Precasia Token").setColor(colorprecasiatoken).build();
precasiatoken.registerParts(["nugget"] as string[]);
var armorprecasiatoken = precasiatoken.registerPart("armor").getData();
armorprecasiatoken.addDataValue("durability", "2000");
armorprecasiatoken.addDataValue("enchantability", "99");
armorprecasiatoken.addDataValue("reduction", "2,5,6,2");
armorprecasiatoken.addDataValue("toughness", "1");

var colorrunandortoken = Color.fromHex("5db7c9") as Color;
var runandortoken = MaterialSystem.getMaterialBuilder().setName("Runandor Token").setColor(colorrunandortoken).build();
runandortoken.registerParts(["nugget"] as string[]);
var armorrunandortoken = runandortoken.registerPart("armor").getData();
armorrunandortoken.addDataValue("durability", "2000");
armorrunandortoken.addDataValue("enchantability", "99");
armorrunandortoken.addDataValue("reduction", "2,5,6,2");
armorrunandortoken.addDataValue("toughness", "3");

var colorshyrelandstoken = Color.fromHex("9c9e65") as Color;
var shyrelandstoken = MaterialSystem.getMaterialBuilder().setName("Shyrelands Token").setColor(colorshyrelandstoken).build();
shyrelandstoken.registerParts(["nugget"] as string[]);
var armorshyrelandstoken = shyrelandstoken.registerPart("armor").getData();
armorshyrelandstoken.addDataValue("durability", "2000");
armorshyrelandstoken.addDataValue("enchantability", "99");
armorshyrelandstoken.addDataValue("reduction", "2,5,6,2");
armorshyrelandstoken.addDataValue("toughness", "5");

var colorvoxpondstoken = Color.fromHex("699438") as Color;
var voxpondstoken = MaterialSystem.getMaterialBuilder().setName("Vox Ponds Token").setColor(colorvoxpondstoken).build();
voxpondstoken.registerParts(["nugget"] as string[]);
var armorvoxpondstoken = voxpondstoken.registerPart("armor").getData();
armorvoxpondstoken.addDataValue("durability", "2000");
armorvoxpondstoken.addDataValue("enchantability", "99");
armorvoxpondstoken.addDataValue("reduction", "2,5,6,2");
armorvoxpondstoken.addDataValue("toughness", "5");

var colorsentientmeatball = Color.fromHex("a80041") as Color;
var sentientmeatball = MaterialSystem.getMaterialBuilder().setName("Sentient Meatball").setColor(colorsentientmeatball).build();
sentientmeatball.registerParts(["nugget"] as string[]);
var armorsentientmeatball = sentientmeatball.registerPart("armor").getData();
armorsentientmeatball.addDataValue("durability", "1000");
armorsentientmeatball.addDataValue("enchantability", "99");
armorsentientmeatball.addDataValue("reduction", "2,6,8,3");
armorsentientmeatball.addDataValue("toughness", "5");

var colorgrevedust = Color.fromHex("0d3785") as Color;
var gravedust = MaterialSystem.getMaterialBuilder().setName("Grave Dust").setColor(colorgrevedust).build();
gravedust.registerParts(["nugget"] as string[]);
var armorgravedust = gravedust.registerPart("armor").getData();
armorgravedust.addDataValue("durability", "99999999");
armorgravedust.addDataValue("enchantability", "99");
armorgravedust.addDataValue("reduction", "2,5,6,2");
armorgravedust.addDataValue("toughness", "1");

var colorichorium = Color.fromHex("a85a00") as Color;
var ichorium = MaterialSystem.getMaterialBuilder().setName("Ichorium").setColor(colorichorium).build();
ichorium.registerParts(["nugget", "ingot", "dust", "rod","plate"] as string[]);
var moltenichorium = ichorium.registerPart("molten").getData();
moltenichorium.addDataValue("temperature", "400");
moltenichorium.addDataValue("luminosity", "10");
var armorichorium = ichorium.registerPart("armor").getData();
armorichorium.addDataValue("durability", "100000");
armorichorium.addDataValue("enchantability", "99");
armorichorium.addDataValue("reduction", "100,100,100,100");
armorichorium.addDataValue("toughness", "100");

var colorascendeddraconicalloy = Color.fromHex("ff7300") as Color;
var ascendeddraconicalloy = MaterialSystem.getMaterialBuilder().setName("Ascended Draconic Alloy").setColor(colorascendeddraconicalloy).build();
ascendeddraconicalloy.registerParts(["nugget"] as string[]);
var armorascendeddraconicalloy = ascendeddraconicalloy.registerPart("armor").getData();
armorascendeddraconicalloy.addDataValue("durability", "100000");
armorascendeddraconicalloy.addDataValue("enchantability", "99");
armorascendeddraconicalloy.addDataValue("reduction", "18,22,26,20");
armorascendeddraconicalloy.addDataValue("toughness", "25");


var colormeatballlegionnaire = Color.fromHex("5559a1") as Color;
var meatballlegionnaire = MaterialSystem.getMaterialBuilder().setName("Meatball Legionnaire").setColor(colormeatballlegionnaire).build();
meatballlegionnaire.registerParts(["nugget"] as string[]);
var armormeatballlegionnaire = meatballlegionnaire.registerPart("armor").getData();
armormeatballlegionnaire.addDataValue("durability", "20000000");
armormeatballlegionnaire.addDataValue("enchantability", "99");
armormeatballlegionnaire.addDataValue("reduction", "100,100,100,100");
armormeatballlegionnaire.addDataValue("toughness", "100");


var colormeatballcenturion = Color.fromHex("853232") as Color;
var meatballcenturion = MaterialSystem.getMaterialBuilder().setName("Meatball Centurion").setColor(colormeatballcenturion).build();
meatballcenturion.registerParts(["nugget"] as string[]);
var armormeatballcenturion = meatballcenturion.registerPart("armor").getData();
armormeatballcenturion.addDataValue("durability", "20000000");
armormeatballcenturion.addDataValue("enchantability", "99");
armormeatballcenturion.addDataValue("reduction", "100,100,100,100");
armormeatballcenturion.addDataValue("toughness", "100");


var colormeatballpraetorian = Color.fromHex("4d8c67") as Color;
var meatballpraetorian = MaterialSystem.getMaterialBuilder().setName("Meatball Praetorian").setColor(colormeatballpraetorian).build();
meatballpraetorian.registerParts(["nugget"] as string[]);
var armormeatballpraetorian = meatballpraetorian.registerPart("armor").getData();
armormeatballpraetorian.addDataValue("durability", "20000000");
armormeatballpraetorian.addDataValue("enchantability", "99");
armormeatballpraetorian.addDataValue("reduction", "200,200,200,200");
armormeatballpraetorian.addDataValue("toughness", "200");

// var colormeatballman = Color.fromHex("242e2e") as Color;
// var meatballman = MaterialSystem.getMaterialBuilder().setName("Meatball Man").setColor(colormeatballman).build();
// meatballman.registerParts(["nugget"] as string[]);
// var armormeatballman = meatballman.registerPart("armor").getData();
// armormeatballman.addDataValue("durability", "20000000");
// armormeatballman.addDataValue("enchantability", "99");
// armormeatballman.addDataValue("reduction", "200,200,200,200");
// armormeatballman.addDataValue("toughness", "200");
