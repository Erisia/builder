#modloaded appliedenergistics2


import crafttweaker.damage.IDamageSource;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.entity.IEntity;




import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.IItemRightClick;
import mods.contenttweaker.Commands;
import mods.contenttweaker.ItemFood;
import mods.contenttweaker.IItemFoodEaten;
import mods.contenttweaker.MutableItemStack;
import mods.contenttweaker.Hand;
import mods.contenttweaker.World;
import mods.contenttweaker.IItemUpdate;
import mods.contenttweaker.Player;
import crafttweaker.player.IPlayer;
import crafttweaker.block.IBlock;
import crafttweaker.data.IData;
import crafttweaker.entity.IEntityEquipmentSlot;



events.onPlayerInteractBlock(function(event as PlayerInteractBlockEvent) {
  if (event.world.isRemote()) {
    return;
  }
  val heldItem = event.item;
  if (!isNull(heldItem)) {
    if (!(heldItem.definition.id.matches(<appliedenergistics2:interface>.definition.id))) {
      if ( !(heldItem.definition.id.matches(<appliedenergistics2:part:440>.definition.id)) ) {
        return;
      }
    }  
    if ( (heldItem.definition.id.matches(<appliedenergistics2:part:440>.definition.id)) ) {
      if ( (heldItem.metadata != 440) ) {
        return;
      }
    }  
    val targetBlock as IBlock = event.block;
    if (targetBlock.definition.id != "appliedenergistics2:cable_bus") {
      return;
    }
    var nbtData = targetBlock.data;
    var part0 as IData = nbtData.memberGet("def:0");
    var part1 as IData = nbtData.memberGet("def:1");
    var part2 as IData = nbtData.memberGet("def:2");
    var part3 as IData = nbtData.memberGet("def:3");
    var part4 as IData = nbtData.memberGet("def:1");
    var part5 as IData = nbtData.memberGet("def:5");
    if (isNull(part0)  ) {
      if (isNull(part1)  ) {
        if (isNull(part2)  ) {
          if (isNull(part3)  ) {
            if (isNull(part4)  ) {
              if (isNull(part5)  ) {
                return;
              }
            }
          }
        }
      }
    }
    if ( !isNull(part0) ){
      //event.player.sendChat(" " + part0);
      if ( (part0.Damage != (460 as short)) ) {
        if ( (part0.Damage != (461 as short)) ) {
          if ( (part0.Damage != (462 as short)) ) {
            if ( (part0.Damage != (463 as short)) ) {
              if ( (part0.Damage != (467 as short)) ) {
                if ( (part0.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    if ( !isNull(part1) ){
      //event.player.sendChat(" " + part1);
      if ( (part1.Damage != (460 as short)) ) {
        if ( (part1.Damage != (461 as short)) ) {
          if ( (part1.Damage != (462 as short)) ) {
            if ( (part1.Damage != (463 as short)) ) {
              if ( (part1.Damage != (467 as short)) ) {
                if ( (part1.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    if ( !isNull(part2) ){
      //event.player.sendChat(" " + part2);
      if ( (part2.Damage != (460 as short)) ) {
        if ( (part2.Damage != (461 as short)) ) {
          if ( (part2.Damage != (462 as short)) ) {
            if ( (part2.Damage != (463 as short)) ) {
              if ( (part2.Damage != (467 as short)) ) {
                if ( (part2.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    if ( !isNull(part3) ){
      //event.player.sendChat(" " + part3);
      if ( (part3.Damage != (460 as short)) ) {
        if ( (part3.Damage != (461 as short)) ) {
          if ( (part3.Damage != (462 as short)) ) {
            if ( (part3.Damage != (463 as short)) ) {
              if ( (part3.Damage != (467 as short)) ) {
                if ( (part3.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    if ( !isNull(part4) ){
      //event.player.sendChat(" " + part4);
      if ( (part4.Damage != (460 as short)) ) {
        if ( (part4.Damage != (461 as short)) ) {
          if ( (part4.Damage != (462 as short)) ) {
            if ( (part4.Damage != (463 as short)) ) {
              if ( (part4.Damage != (467 as short)) ) {
                if ( (part4.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    if ( !isNull(part5) ){
      //event.player.sendChat(" " + part5);
      if ( (part5.Damage != (460 as short)) ) {
        if ( (part5.Damage != (461 as short)) ) {
          if ( (part5.Damage != (462 as short)) ) {
            if ( (part5.Damage != (463 as short)) ) {
              if ( (part5.Damage != (467 as short)) ) {
                if ( (part5.Damage != (469 as short)) ) {
                  return;
                }
              }
            }
          }
        }
      }
    }
    event.player.sendChat("=====================");
    event.player.sendChat("- This clicking function was disabled to prevent a bug with AE2");
    event.player.sendChat("");
    event.player.sendChat("- If you are trying to configure a p2p, use the crafting recipes");
    event.player.sendChat("");
    event.player.sendChat("- If you are holding an ME interface and trying to open a bus or terminal, you cannot, switch to a different hotbar slot");
    event.player.sendChat("");
    event.player.sendChat("- If you are trying to place both a part (flat) Interface and p2p on the same cable, place the Interface first");
    event.cancel();
  }
});


