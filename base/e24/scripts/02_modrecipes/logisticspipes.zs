import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var FPGA = <logisticspipes:chip_fpga>;
var ingotIron = <minecraft:iron_ingot>;
var ingotGold = <minecraft:gold_ingot>;
var dustRedstone = <minecraft:redstone>;
var basicLogPipe = <logisticspipes:pipe_basic>;
var craftingTable = <minecraft:crafting_table>;
var gemRuby = <ore:gemRuby>;
var gemSapp = <ore:gemSapphire>;
var cauldron = <minecraft:cauldron>;
var basicChip = <logisticspipes:chip_basic>;
var ingotSteel = <ore:ingotSteel>;
var gemLapis = <ore:gemLapis>;
var advChip = <logisticspipes:chip_advanced>;
var dustGlowstone = <ore:dustGlowstone>;
var chest = <ore:chest>;
var gemQuartz = <ore:gemQuartz>;
var gemDiamond = <ore:gemDiamond>;
var enderPearl = <ore:enderpearl>;
var sign = <minecraft:sign>;
var flintSteel = <minecraft:flint_and_steel>;
var brick = <minecraft:brick_block>;
var bucket = <minecraft:bucket>;
var glass = <ore:blockGlass>;

//Crafting Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_crafting>, [[null, craftingTable, null],[dustRedstone, FPGA, dustRedstone], [null, basicLogPipe, null]]);

//Request Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_request>, [[gemRuby, craftingTable, gemRuby],[dustRedstone, FPGA, dustRedstone], [ingotIron, basicLogPipe, ingotIron]]);

//Request MK2 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_request_mk2>, [[gemSapp, craftingTable, gemSapp],[dustRedstone, advChip, dustRedstone], [ingotGold, <logisticspipes:pipe_request>, ingotGold]]);

//Provider Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_provider>, [[gemSapp, craftingTable, gemSapp],[dustRedstone, FPGA, dustRedstone], [ingotIron, basicLogPipe, ingotIron]]);

//Supplier Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_supplier>, [[gemSapp, chest, gemSapp],[dustRedstone, FPGA, dustRedstone], [ingotIron, basicLogPipe, ingotIron]]);

//Satellite Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_satellite>, [[null, cauldron, null],[dustRedstone, FPGA, dustRedstone], [null, basicLogPipe, null]]);

//MK1 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_chassis_mk1>, [[null, ingotSteel, null],[null, basicChip, null], [FPGA, basicLogPipe, FPGA]]);

//MK2 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_chassis_mk2>, [[null, gemRuby, null],[basicChip, <logisticspipes:pipe_chassis_mk1>, basicChip], [ingotSteel, gemLapis, ingotSteel]]);

//MK3 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_chassis_mk3>, [[null, gemSapp, null],[dustGlowstone, <logisticspipes:pipe_chassis_mk2>, dustGlowstone], [ingotSteel, advChip, ingotSteel]]);

//MK4 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_chassis_mk4>, [[ingotGold, gemRuby, ingotGold],[basicChip, <logisticspipes:pipe_chassis_mk3>, basicChip], [ingotSteel, advChip, ingotSteel]]);

//MK5 Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_chassis_mk5>, [[gemDiamond, gemSapp, gemDiamond],[advChip, <logisticspipes:pipe_chassis_mk4>, advChip], [ingotSteel, gemQuartz, ingotSteel]]);

//Remote Order Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_remote_orderer>, [[null, sign, null],[enderPearl, basicChip, dustRedstone], [ingotSteel, basicLogPipe, ingotSteel]]);

//Inv Connector Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_inventory_system_connector>, [[gemSapp, sign, gemSapp],[enderPearl, basicChip, dustRedstone], [ingotSteel, basicLogPipe, ingotSteel]]);


//System Entrance Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_system_entrance>, [[gemRuby, chest, gemRuby],[enderPearl, basicChip, dustRedstone], [ingotSteel, <logisticspipes:pipe_provider>, ingotSteel]]);

//System Dest Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_system_destination>, [[gemSapp, chest, gemSapp],[enderPearl, basicChip, dustRedstone], [ingotSteel, <logisticspipes:pipe_provider>, ingotSteel]]);

//Firewall Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_firewall>, [[brick, flintSteel, brick],[enderPearl, basicChip, dustRedstone], [ingotSteel, <logisticspipes:pipe_provider>, ingotSteel]]);

//Fluid Basic Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_basic>, [[null, bucket, null],[basicChip, basicLogPipe, basicChip], [ingotGold, bucket, ingotGold]]);

//Fluid Container Supplier Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_supplier>, [[null, bucket, null],[basicChip, basicLogPipe, basicChip], [ingotIron, bucket, ingotIron]]);

//Fluid Insert Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_insertion>, [[null, bucket, null],[dustRedstone, basicChip, dustRedstone], [null, <logisticspipes:pipe_fluid_basic>, null]]);

//Fluid Provider Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_provider>, [[null, bucket, null],[dustRedstone, basicChip, dustRedstone], [ingotSteel, <logisticspipes:pipe_fluid_basic>, ingotSteel]]);

//Fluid Request Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_request>, [[glass, bucket, glass],[dustRedstone, basicChip, dustRedstone], [ingotSteel, <logisticspipes:pipe_fluid_basic>, ingotSteel]]);

//Fluid Extractor Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_extractor>, [[null, bucket, null],[dustRedstone, FPGA, dustRedstone], [glass, <logisticspipes:pipe_fluid_basic>, glass]]);

//Fluid Satelitte Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_satellite>, [[gemSapp, bucket, gemSapp],[dustRedstone, FPGA, dustRedstone], [ingotSteel, <logisticspipes:pipe_fluid_basic>, ingotSteel]]);

//Fluid Satelitte Logistics Pipe
recipes.addShaped(<logisticspipes:pipe_fluid_supplier_mk2>, [[gemSapp, bucket, gemSapp],[dustRedstone, FPGA, dustRedstone], [ingotSteel, <logisticspipes:pipe_fluid_supplier>, ingotSteel]]);









