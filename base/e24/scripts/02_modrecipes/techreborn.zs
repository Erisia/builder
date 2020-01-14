import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var ingotIron = <ore:ingotIron>;
var plateIron = <ore:plateIron>;

//fix missing recipe
recipes.addShaped(<techreborn:refined_iron_fence> * 4, [[null, null, null],[ingotIron, plateIron, ingotIron], [ingotIron, plateIron, ingotIron]]);

var disabledItems as IIngredient[] = [

 <techreborn:ore>, //Tech Reborn:Galena Ore
 <techreborn:ore:1>, //Tech Reborn:Iridium Ore
 <techreborn:ore:4>, //Tech Reborn:Bauxite Ore
 <techreborn:ore:6>, //Tech Reborn:Cinnabar Ore
 <techreborn:ore:12>, //Tech Reborn:Lead Ore
 <techreborn:ore:13>, //Tech Reborn:Silver Ore
 <techreborn:plates>, //Tech Reborn:Iron Plate
 <techreborn:plates:1>, //Tech Reborn:Gold Plate
 <techreborn:plates:4>, //Tech Reborn:Redstone Plate
 <techreborn:plates:5>, //Tech Reborn:Diamond Plate
 <techreborn:plates:6>, //Tech Reborn:Emerald Plate
 <techreborn:plates:16>, //Tech Reborn:Aluminium Plate
 <techreborn:plates:17>, //Tech Reborn:Brass Plate
 <techreborn:plates:18>, //Tech Reborn:Bronze Plate
 <techreborn:plates:20>, //Tech Reborn:Copper Plate
 <techreborn:plates:21>, //Tech Reborn:Electrum Plate
 <techreborn:plates:22>, //Tech Reborn:Invar Plate
 <techreborn:plates:23>, //Tech Reborn:Iridium Plate
 <techreborn:plates:24>, //Tech Reborn:Lead Plate
 <techreborn:plates:25>, //Tech Reborn:Nickel Plate
 <techreborn:plates:26>, //Tech Reborn:Platinum Plate
 <techreborn:plates:27>, //Tech Reborn:Silver Plate
 <techreborn:plates:28>, //Tech Reborn:Steel Plate
 <techreborn:plates:29>, //Tech Reborn:Tin Plate
 <techreborn:plates:34>, //Tech Reborn:Refined Iron Plate
 <techreborn:bronzeboots>, //Tech Reborn:Bronze Boots
 <techreborn:nuggets:1>, //Tech Reborn:Brass Nugget
 <techreborn:nuggets:2>, //Tech Reborn:Bronze Nugget
 <techreborn:nuggets>, //Tech Reborn:Aluminium Nugget
 <techreborn:nuggets:4>, //Tech Reborn:Copper Nugget
 <techreborn:nuggets:5>, //Tech Reborn:Electrum Nugget
 <techreborn:nuggets:6>, //Tech Reborn:Invar Nugget
 <techreborn:nuggets:7>, //Tech Reborn:Iridium Nugget
 <techreborn:nuggets:8>, //Tech Reborn:Lead Nugget
 <techreborn:nuggets:9>, //Tech Reborn:Nickel Nugget
 <techreborn:nuggets:10>, //Tech Reborn:Platinum Nugget
 <techreborn:nuggets:11>, //Tech Reborn:Silver Nugget
 <techreborn:nuggets:12>, //Tech Reborn:Steel Nugget
 <techreborn:nuggets:13>, //Tech Reborn:Tin Nugget
 <techreborn:nuggets:19>, //Tech Reborn:Refined Iron Nugget
 <techreborn:nuggets:23>, //Tech Reborn:Iron Nugget
 <techreborn:nuggets:24>, //Tech Reborn:Diamond Nugget
 <techreborn:bronzeaxe>, //Tech Reborn:Bronze Axe
 <techreborn:bronzespade>, //Tech Reborn:Bronze Shovel
 <techreborn:ingot>, //Tech Reborn:Aluminium Ingot
 <techreborn:ingot:1>, //Tech Reborn:Brass Ingot
 <techreborn:ingot:2>, //Tech Reborn:Bronze Ingot
 <techreborn:ingot:4>, //Tech Reborn:Copper Ingot
 <techreborn:ingot:5>, //Tech Reborn:Electrum Ingot
 <techreborn:ingot:6>, //Tech Reborn:Invar Ingot
 <techreborn:ingot:7>, //Tech Reborn:Iridium Ingot
 <techreborn:ingot:8>, //Tech Reborn:Lead Ingot
 <techreborn:ingot:9>, //Tech Reborn:Nickel Ingot
 <techreborn:ingot:10>, //Tech Reborn:Platinum Ingot
 <techreborn:ingot:11>, //Tech Reborn:Silver Ingot
 <techreborn:ingot:12>, //Tech Reborn:Steel Ingot
 <techreborn:ingot:13>, //Tech Reborn:Tin Ingot
 <techreborn:ingot:19>, //Tech Reborn:Refined Iron Ingot
 <techreborn:dust:1>, //Tech Reborn:Aluminium Dust
 <techreborn:dust:6>, //Tech Reborn:Brass Dust
 <techreborn:dust:7>, //Tech Reborn:Bronze Dust
 <techreborn:dust:14>, //Tech Reborn:Copper Dust
 <techreborn:dust:17>, //Tech Reborn:Electrum Dust
 <techreborn:dust:23>, //Tech Reborn:Galena Dust
 <techreborn:dust:24>, //Tech Reborn:Gold Dust
 <techreborn:dust:26>, //Tech Reborn:Invar Dust
 <techreborn:dust:27>, //Tech Reborn:Iron Dust
 <techreborn:dust:29>, //Tech Reborn:Lead Dust
 <techreborn:dust:38>, //Tech Reborn:Platinum Dust
 <techreborn:dust:46>, //Tech Reborn:Saw Dust
 <techreborn:dust:47>, //Tech Reborn:Silver Dust
 <techreborn:dust:51>, //Tech Reborn:Steel Dust
 <techreborn:dust:53>, //Tech Reborn:Tin Dust
 <techreborn:storage2:8>, //Tech Reborn:Block of Copper
 <techreborn:storage2:9>, //Tech Reborn:Block of Tin
 <techreborn:storage2:10>, //Tech Reborn:Block of Refined Iron
 <techreborn:bronzepickaxe>, //Tech Reborn:Bronze Pickaxe
 <techreborn:refined_iron_fence>, //Tech Reborn:Iron Fence
 <techreborn:ore2>, //Tech Reborn:Copper Ore
 <techreborn:ore2:1>, //Tech Reborn:Tin Ore
 <techreborn:bronzeleggings>, //Tech Reborn:Bronze Leggings
 <techreborn:bronzehoe>, //Tech Reborn:Bronze Hoe
 <techreborn:bronzesword>, //Tech Reborn:Bronze Sword
 <techreborn:creative_solar_panel> //Tech Reborn:Creative Solar Panel
 
  ];
 
 for item in disabledItems  {
 
   recipes.remove(item);
   
 }
