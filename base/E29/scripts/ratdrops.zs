import mods.dropt.Dropt;

Dropt.list("list_name")

  .add(Dropt.rule()
      .matchBlocks(["redstone_lock:cheese"])
      .addDrop(Dropt.drop()
          .items([<minecraft:spawn_egg>.withTag({EntityTag: {id: "rats:rat"}})])
      )
  );
