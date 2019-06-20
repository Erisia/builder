# *======= Changes =======*
#Glider wings
recipes.remove(<openglider:hang_glider_part>);	
recipes.addShaped(<openglider:hang_glider_part>, [
	[null, <immersiveengineering:material>, <ore:glue>],
	[<immersiveengineering:material>, <betterwithmods:material:4>, <betterwithmods:material:4>],
	[<ore:glue>, <betterwithmods:material:4>, <betterwithmods:material:4>]
]);
recipes.remove(<openglider:hang_glider_part:1>);
recipes.addShaped(<openglider:hang_glider_part:1>, [
	[<ore:glue>, <immersiveengineering:material>, null],
	[<betterwithmods:material:4>, <betterwithmods:material:4>, <immersiveengineering:material>],
	[<betterwithmods:material:4>, <betterwithmods:material:4>, <ore:glue>]
]);