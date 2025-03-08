---
navigation:
  title: "Basic Steam Power Setup"
  icon: "oritech:steam_engine_block"
  position: 252
  parent: oritech:steam.md
item_ids:
  - oritech:lava_generator_block
  - oritech:steam_engine_block
  - oritech:steam_boiler_addon
---

# Basic Steam Power Setup



### How To Set Up Steam Power

<GameScene zoom="4" interactive={true}>
    <ImportStructure src="steam_setup.nbt" />
    <IsometricCamera yaw="165" pitch="30" />
    <BoxAnnotation color="#dddddd" min="5 0 0" max="6 1 1">
        Lava Source pumping into Magmatic Boiler
    </BoxAnnotation>
    <BoxAnnotation color="#dddddd" min="6 0 4" max="5 1 5">
        Water Source pumping into Steam Boiler Addon
    </BoxAnnotation>
    <DiamondAnnotation pos="3.5 0.5 2.5" color="#00ff00">
        Steam Pumping Into Steam Engine
    </DiamondAnnotation>
    <DiamondAnnotation pos="2.5 0.5 3.5" color="#ADD8E6">
        Excess Water Being Voided Into Fluid Trashcan
    </DiamondAnnotation>
    <DiamondAnnotation pos="0.5 0.5 2.5" color="#FF0000">
        Power Going Out To Storage
    </DiamondAnnotation>
</GameScene>

