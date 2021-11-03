import mods.artisanworktables.builder.RecipeBuilder;

    RecipeBuilder.get("mage")
  .setShapeless([<ore:etLaserLensColored>])
    .setFluid(<liquid:xpjuice> * 1000)
  .addOutput(<environmentaltech:laser_lens>)
  .addTool(<ore:artisansLens>, 12)
  .create();
