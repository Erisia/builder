//REMOVE RECIPES
recipes.remove(<harvestcraft:juiceritem>);//JUICER
recipes.remove(<harvestcraft:mortarandpestleitem>);//MORTAR AND PESTLE
recipes.remove(<harvestcraft:saucepanitem>);//SAUCEPAN
recipes.remove(<harvestcraft:mixingbowlitem>);//MIXING BOWL
recipes.remove(<harvestcraft:skilletitem>);//SKILLET
recipes.remove(<harvestcraft:bakewareitem>);//BAKEWARE
recipes.remove(<harvestcraft:cuttingboarditem>);//CUTTING BOARD
recipes.remove(<harvestcraft:potitem>);//POT
recipes.remove(<harvestcraft:presser>);//PRESSER
//ADD RECIPES
recipes.addShapeless(<harvestcraft:juiceritem>,[<botania:livingrock:0>,<minecraft:stone_pressure_plate>]);//JUICER
recipes.addShaped(<harvestcraft:mortarandpestleitem>,[[null,null,null],
																[<botania:livingrock:0>,<ore:stickWood>,<botania:livingrock:0>],
																[null,<botania:livingrock:0>,null]]);//MORTAR AND PESTLE
recipes.addShapeless(<harvestcraft:saucepanitem>,[<ore:ingotSteel>,<ore:stickWood>]);//SAUCEPAN
recipes.addShaped(<harvestcraft:mixingbowlitem>,[[null,null,null],
																[<astralsorcery:blockinfusedwood>,<ore:stickWood>,<astralsorcery:blockinfusedwood>],
																[null,<astralsorcery:blockinfusedwood>,null]]);//MIXING BOWL
recipes.addShapeless(<harvestcraft:skilletitem>,[<jaopca:item_platedensesilver>,<ore:stickWood>]);//SKILLET
recipes.addShaped(<harvestcraft:bakewareitem>,[[<ore:ingotAstralStarmetal>,<ore:ingotAstralStarmetal>,<ore:ingotAstralStarmetal>],
																[<ore:ingotAstralStarmetal>,null,<ore:ingotAstralStarmetal>],
																[<ore:ingotAstralStarmetal>,<ore:ingotAstralStarmetal>,<ore:ingotAstralStarmetal>]]);//BAKEWARE
recipes.addShapeless(<harvestcraft:cuttingboarditem>,[<ore:ingotInvar>,<ore:stickWood>,<ore:plankWood>]);//CUTTING BOARD
recipes.addShaped(<harvestcraft:potitem>,[[<ore:ingotElvenElementium>,<ore:ingotElvenElementium>,<ore:stickWood>],
																[<ore:ingotElvenElementium>,<ore:ingotElvenElementium>,null],
																[null,null,null]]);//POT
recipes.addShapeless(<harvestcraft:vegetarianlettucewrapitem>,[<actuallyadditions:item_knife>.anyDamage().transformDamage(),<harvestcraft:cucumberitem>,<harvestcraft:tomatoitem>,<harvestcraft:lettuceitem>]);//LETTUCE WRAP
recipes.addShapeless(<harvestcraft:springsaladitem>,[<actuallyadditions:item_knife>.anyDamage().transformDamage(),<harvestcraft:lettuceitem>,<ore:listAllveggie>]);//LETTUCE WRAP

recipes.addShapeless(<harvestcraft:stockitem>*2,[<minecraft:bowl>.reuse(),<ore:listAllveggie>]);//STOCK

recipes.addShapeless(<harvestcraft:vinegaritem>,[<minecraft:bowl>.reuse(),<harvestcraft:grapejuiceitem>]);//VINEGAR

recipes.addShapeless(<harvestcraft:tomatosoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<ore:cropTomato>]);//TOMATO SOUP

recipes.addShapeless(<harvestcraft:teaitem>,[<minecraft:bowl>.reuse(),<harvestcraft:tealeafitem>]);//TEA

recipes.addShapeless(<harvestcraft:sweetpickleitem>,[<minecraft:bowl>.reuse(),<harvestcraft:vinegaritem>,<harvestcraft:cucumberitem>,<ore:listAllsugar>]);//SWEET PICKLE

recipes.addShapeless(<harvestcraft:vegetablesoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<minecraft:carrot>,<minecraft:potato>,<ore:listAllmushroom>]);//VEGETABLE SOUP

recipes.addShapeless(<harvestcraft:steamedspinachitem>,[<minecraft:bowl>.reuse(),<harvestcraft:spinachitem>,<ore:listAllwater>]);//STEAMED SPINACH

recipes.addShapeless(<harvestcraft:steamedspinachitem>,[<minecraft:bowl>.reuse(),<harvestcraft:peasitem>,<ore:listAllwater>,<ore:itemSalt>]);//STEAMED PEAS

recipes.addShapeless(<harvestcraft:splitpeasoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<harvestcraft:peasitem>,<harvestcraft:blackpepperitem>,<ore:listAllporkcooked>]);//SPLIT PEA SOUP


recipes.addShapeless(<harvestcraft:seedsoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<ore:listAllseed>]);//SEED SOUP

recipes.addShapeless(<harvestcraft:ricesoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<ore:listAllrice>]);//RICE SOUP

recipes.addShapeless(<harvestcraft:potroastitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<minecraft:carrot>,<minecraft:potato>,<ore:listAllbeefcooked>]);//POT ROAST

recipes.addShapeless(<harvestcraft:potatosoupitem>,[<minecraft:bowl>.reuse(),<harvestcraft:stockitem>,<minecraft:potato>,<ore:itemSalt>]);//POTATO SOUP

recipes.addShapeless(<harvestcraft:potatochipsitem>,[<minecraft:bowl>.reuse(),<harvestcraft:oliveoilitem>,<minecraft:potato>,<ore:itemSalt>]);//POTATO CHIPS

recipes.addShapeless(<harvestcraft:picklesitem>,[<minecraft:bowl>.reuse(),<harvestcraft:cucumberitem>,<harvestcraft:vinegaritem>,<ore:itemSalt>]);//PICKLES

recipes.addShapeless(<harvestcraft:pickledonionsitem>,[<minecraft:bowl>.reuse(),<harvestcraft:onionitem>,<harvestcraft:vinegaritem>,<ore:itemSalt>]);//PICKLED ONIONS

recipes.addShapeless(<harvestcraft:pickledbeetsitem>,[<minecraft:bowl>.reuse(),<harvestcraft:beetitem>,<harvestcraft:vinegaritem>,<ore:itemSalt>]);//PICKLED BEETS

recipes.addShapeless(<harvestcraft:mozzerellasticksitem>,[<minecraft:bowl>.reuse(),<ore:foodCheese>,<harvestcraft:oliveoilitem>,<harvestcraft:batteritem>]);//MOZZARELLA STICKS

recipes.addShapeless(<harvestcraft:bakedbeansitem>,[<minecraft:bowl>.reuse(),<ore:listAllsugar>,<ore:listAllporkcooked>,<harvestcraft:beanitem>]);//BAKED BEANS

recipes.addShapeless(<harvestcraft:springsaladitem>,[<actuallyadditions:item_knife>.anyDamage().transformDamage(),<harvestcraft:lettuceitem>,<ore:listAllveggie>]);//LETTUCE WRAP