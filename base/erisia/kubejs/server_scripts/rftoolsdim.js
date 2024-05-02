ServerEvents.recipes(event => {

  event.remove({ mod: 'rftoolsdim' })

})

LootJS.modifiers((event) => {
  event
  .addLootTypeModifier([LootType.CHEST, LootType.ENTITY, LootType.FISHING])
  .removeLoot("@rftoolsdim")
}) 