val miner = <bedrockores:bedrock_miner>;
val light = <immersiveengineering:metal_decoration0:4>;
val heavy = <immersiveengineering:metal_decoration0:5>;
val dynamo = <immersiveengineering:metal_device1:2>;
val drill = <immersiveengineering:drillhead>;
val scaffolding = <immersiveengineering:metal_decoration1:5>;

recipes.remove(miner);

recipes.addShaped(miner,
  [[scaffolding, light, scaffolding],
   [scaffolding, dynamo, scaffolding],
   [heavy, drill, heavy]]);
   
//Iridium conversion between TE and IC2.
recipes.addShapeless(<ic2:misc_resource:2>, [<ore:nuggetIridium>]);
