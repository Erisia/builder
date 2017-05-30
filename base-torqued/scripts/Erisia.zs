#Don't add seeds to petal apothecary recipes!!!

val orechid = <botania:specialFlower>.withTag({type: "orechid"});
val clayconia = <botania:specialFlower>.withTag({type: "clayconia"});
val waterRune = <botania:rune>;
val earthRune = <botania:rune:2>;
val greedRune = <botania:rune:11>;
val slothRune = <botania:rune:12>;
val pixieDust = <botania:manaResource:8>;
val cyanPetal = <botania:petal:9>;
val grayPetal = <botania:petal:7>;
val yellowPetal = <botania:petal:4>;
val redPetal = <botania:petal:13>;
val greenPetal = <botania:petal:14>;
val lightgrayPetal = <botania:petal:8>;


mods.botania.Apothecary.removeRecipe(orechid);
mods.botania.Apothecary.addRecipe(orechid, [greedRune, pixieDust, slothRune, 
                                            grayPetal, grayPetal, redPetal, 
                                            greenPetal]);
                                            
mods.botania.Apothecary.removeRecipe(clayconia);
mods.botania.Apothecary.addRecipe(clayconia, [earthRune, waterRune, cyanPetal,
                                              grayPetal, lightgrayPetal]);

