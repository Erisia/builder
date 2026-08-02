# Granted once per player by the erisia:welcome/first_join advancement.
# Starter kit: survive the first night, then read the book.
# Sleeping bag (Comforts) is the point -- it sleeps anywhere and does NOT move your
# respawn, so night one works before they own a base. The bed is still here because
# it is the only way to move the respawn point once they build one.
give @s comforts:sleeping_bag_green
give @s minecraft:red_bed
give @s minecraft:torch 32
give @s minecraft:bread 32
give @s minecraft:stone_pickaxe
give @s minecraft:stone_axe
give @s minecraft:stone_shovel
give @s minecraft:stone_sword
give @s patchouli:guide_book{"patchouli:book":"patchouli:erisia_welcome"}

# Czech, because the players are Czech kids. Mod UIs stay English -- this message
# and the book are where comprehension is won. This file is UTF-8; keep it that way.
tellraw @s [{"text":"Vítej na Erisii!","color":"gold","bold":true}]
tellraw @s [{"text":"V inventáři máš ","color":"white"},{"text":"příručku","color":"yellow","bold":true},{"text":" – otevři ji, je celá česky.","color":"white"}]
tellraw @s [{"text":"Domov: ","color":"gray"},{"text":"/sethome","color":"aqua"},{"text":" nastavíš, ","color":"gray"},{"text":"/home","color":"aqua"},{"text":" se vrátíš.","color":"gray"}]
tellraw @s [{"text":"Po smrti: ","color":"gray"},{"text":"/back","color":"aqua"},{"text":" tě vrátí zpátky – věci ti do té doby drží hrob.","color":"gray"}]
tellraw @s [{"text":"Za kamarádem: ","color":"gray"},{"text":"/tpa <jméno>","color":"aqua"},{"text":", on potvrdí ","color":"gray"},{"text":"/tpaccept","color":"aqua"},{"text":".","color":"gray"}]
tellraw @s [{"text":"Noc přeskočíte spaním – stačí, když spí jeden z vás.","color":"gray"}]
