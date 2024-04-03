 
ServerEvents.tags('item', event => {

    // silver ore
    event.get("c:raw_ores").add("galosphere:raw_silver")
    event.get("c:raw_silver_ores").add("galosphere:raw_silver")
})
