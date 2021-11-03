import mods.dropt.Dropt;

Dropt.list("list_name")
 
    .add(Dropt.rule()
      .matchBlocks(["deliverymerchants:merchant_spawner"])
      .addDrop(Dropt.drop()
          .items([<redstone_lock:dookie>])
      )
  );
