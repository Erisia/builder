import mods.dropt.Dropt;

Dropt.list("list_name")
 
    .add(Dropt.rule()
      .matchBlocks(["redstone_lock:presstreasure"])
      .addDrop(Dropt.drop()
          .items([<lootbags:itemlootbag:3>])
      )
  );
