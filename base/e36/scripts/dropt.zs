import mods.dropt.Dropt;

Dropt.list("list_name")

  .add(Dropt.rule()
      .matchBlocks(["draconicevolution:draconium_ore"])
      .addDrop(Dropt.drop()
          .items([<draconicevolution:draconium_ore>])
      )
  );
Dropt.list("list_name")

  .add(Dropt.rule()
      .matchBlocks(["draconicevolution:draconium_ore:1"])
      .addDrop(Dropt.drop()
          .items([<draconicevolution:draconium_ore:1>])
      )
  );
Dropt.list("list_name")

  .add(Dropt.rule()
      .matchBlocks(["draconicevolution:draconium_ore:2"])
      .addDrop(Dropt.drop()
          .items([<draconicevolution:draconium_ore:2>])
      )
  );