 
ServerEvents.recipes(event => {

    ////// ores -> raw ores

    // silver -> settings copied from lead recipe
    event.recipes.modern_industrialization.macerator(2, 200) 
        .itemIn("1x #c:silver_ores")
        .itemOut("3x #c:raw_silver_ores");
        
    // only ore that doesnt follow this format
    event.recipes.modern_industrialization.macerator(2, 200)
        .itemIn("1x #c:zinc_ores")
        .itemOut("3x #c:raw_zinc_ores");

    // MI does not have a crushed zinc variant
    event.recipes.modern_industrialization.macerator(2, 200)
        .itemIn("1x #c:raw_zinc_ores")
        .itemOut("create:crushed_raw_zinc", 1.0)
        .itemOut("create:crushed_raw_zinc", 0.5);   //why i cant just use 1.5 is beyond me...

})