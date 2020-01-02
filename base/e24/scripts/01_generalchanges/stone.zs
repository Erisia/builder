import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;

var purpleSlate = <earthworks:block_slate_purple>;
var greenSlate = <earthworks:block_slate_green>;
var blueSlate = <earthworks:block_slate>;
var slate = <rustic:slate>;
var lightblueSlate = <quark:slate>;
var cookTime = 0.5;

## Slate Conversion
#Green
recipes.addShaped(greenSlate * 8, [[slate, slate, slate], [slate, <ore:dyeGreen>, slate], [slate, slate, slate]]);
#Blue
recipes.addShaped(blueSlate * 8, [[slate, slate, slate], [slate, <ore:dyeBlue>, slate], [slate, slate, slate]]);
#Purple
recipes.addShaped(purpleSlate * 8, [[slate, slate, slate], [slate, <ore:dyePurple>, slate], [slate, slate, slate]]);
#LightBlue
recipes.addShaped(<quark:slate> * 8, [[slate, slate, slate], [slate, <ore:dyeLightBlue>, slate], [slate, slate, slate]]);


# Cook dyed slates back to base slate
furnace.addRecipe(slate, greenSlate, cookTime );
furnace.addRecipe(slate, blueSlate, cookTime );
furnace.addRecipe(slate, purpleSlate, cookTime );
furnace.addRecipe(slate, lightblueSlate, cookTime );