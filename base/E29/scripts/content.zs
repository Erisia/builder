#loader contenttweaker

import mods.contenttweaker.Color;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.IItemUse;
import mods.contenttweaker.ActionResult;

var liquidGlue = VanillaFactory.createFluid("glue", Color.fromHex("dedbb6"));
liquidGlue.register();

var liquidSolder = VanillaFactory.createFluid("solder", Color.fromHex("deded9"));
liquidSolder.register();

var boolyBar = VanillaFactory.createItem("booly_ingot");
boolyBar.maxStackSize = 64;
boolyBar.register();

var boolyNugget = VanillaFactory.createItem("booly_nugget");
boolyNugget.maxStackSize = 64;
boolyNugget.register();

var boolyPile = VanillaFactory.createItem("booly_pile");
boolyPile.maxStackSize = 64;
boolyPile.register();

var boolyCrystal = VanillaFactory.createItem("booly_crystal");
boolyCrystal.maxStackSize = 64;
boolyCrystal.register();

var wireSolder = VanillaFactory.createItem("wire_solder");
wireSolder.maxStackSize = 64;
wireSolder.register();

var blankUpbase = VanillaFactory.createItem("blank_upgradebase");
blankUpbase.maxStackSize = 64;
blankUpbase.register();

var gilFiveh = VanillaFactory.createItem("fivehundred_gil");
gilFiveh.maxStackSize = 64;
gilFiveh.register();

var dustSolder = VanillaFactory.createItem("dust_solder");
dustSolder.maxStackSize = 64;
dustSolder.register();

var chunkDiamond = VanillaFactory.createItem("diamond_chunk");
chunkDiamond.maxStackSize = 64;
chunkDiamond.register();

var chunkEmerald = VanillaFactory.createItem("emerald_chunk");
chunkEmerald.maxStackSize = 64;
chunkEmerald.register();

var sheetRubber = VanillaFactory.createItem("sheet_rubber");
sheetRubber.maxStackSize = 64;
sheetRubber.register();

var dustDdg = VanillaFactory.createItem("dust_ddg");
dustDdg.maxStackSize = 64;
dustDdg.register();

var emptyCap = VanillaFactory.createItem("emptycap");
emptyCap.maxStackSize = 64;
emptyCap.register();

var omegaFragment = VanillaFactory.createItem("omega_fragment");
omegaFragment.maxStackSize = 64;
omegaFragment.register();

var omegaShard = VanillaFactory.createItem("omega_shard");
omegaShard.maxStackSize = 64;
omegaShard.register();

var omegaFlare = VanillaFactory.createItem("omega_flare");
omegaFlare.maxStackSize = 64;
omegaFlare.register();

var omegaPlate = VanillaFactory.createItem("omega_plate");
omegaPlate.maxStackSize = 64;
omegaPlate.register();

var omegaDust = VanillaFactory.createItem("omega_dust");
omegaDust.maxStackSize = 64;
omegaDust.register();

var omegaGem = VanillaFactory.createItem("omega_gem");
omegaGem.maxStackSize = 64;
omegaGem.register();

var infinityFragment = VanillaFactory.createItem("infinity_fragment");
infinityFragment.maxStackSize = 64;
infinityFragment.register();

var infinityShard = VanillaFactory.createItem("infinity_shard");
infinityShard.maxStackSize = 64;
infinityShard.register();

var infinityFlare = VanillaFactory.createItem("infinity_flare");
infinityFlare.maxStackSize = 64;
infinityFlare.register();

var infinityPlate = VanillaFactory.createItem("infinity_plate");
infinityPlate.maxStackSize = 64;
infinityPlate.register();

var infinityDust = VanillaFactory.createItem("infinity_dust");
infinityDust.maxStackSize = 64;
infinityDust.register();

var infinityGem = VanillaFactory.createItem("infinity_gem");
infinityGem.maxStackSize = 64;
infinityGem.register();

var poopDirt =  VanillaFactory.createBlock("poop_dirt", <blockmaterial:sand>);
poopDirt.setBlockHardness(2.0);
poopDirt.setBlockResistance(8.0);
poopDirt.setToolClass("shovel");
poopDirt.setToolLevel(0);
poopDirt.setBlockSoundType(<soundtype:sand>);
poopDirt.register();