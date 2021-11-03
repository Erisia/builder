import mods.dropt.Dropt;

Dropt.list("list_name")
 
    .add(Dropt.rule()
      .matchBlocks(["lootbags:loot_recycler"])
      .addDrop(Dropt.drop()
          .items([<redstone_lock:dookie>])
      )
  );
