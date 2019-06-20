# *======= Import =======*
import mods.jei.JEI.removeAndHide as rh;

# *======= Changes =======*	
#Waystone
recipes.remove(<waystones:waystone>); 
<waystones:waystone>.addTooltip(format.red("Crafting is disabled."));

# *======= Removals =======*
rh(<waystones:return_scroll>);
rh(<waystones:bound_scroll>);
rh(<waystones:warp_scroll>);
rh(<waystones:warp_stone>);