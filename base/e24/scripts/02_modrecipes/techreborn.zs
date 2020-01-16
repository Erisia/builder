import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var disabledItems as IIngredient[] = [

 <techreborn:ore>, //Tech Reborn:Galena Ore
 <techreborn:ore:1>, //Tech Reborn:Iridium Ore
 <techreborn:ore:4>, //Tech Reborn:Bauxite Ore
 <techreborn:ore:6>, //Tech Reborn:Cinnabar Ore
 <techreborn:ore:12>, //Tech Reborn:Lead Ore
 <techreborn:ore:13>, //Tech Reborn:Silver Ore
 <techreborn:bronzeboots>, //Tech Reborn:Bronze Boots
 <techreborn:bronzeaxe>, //Tech Reborn:Bronze Axe
 <techreborn:bronzespade>, //Tech Reborn:Bronze Shovel
 <techreborn:bronzepickaxe>, //Tech Reborn:Bronze Pickaxe
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
