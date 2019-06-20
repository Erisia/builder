#Credit to ATM team, thanks.

print(" =================== Akashic Tome =================== ");
print(" ==================================================== ");
/*
	Script just for the "all books included" tome to make it easier
	to see/find/edit/organize things related to just this tome
*/
#Credit to all the mods team, thanks for your work.
//====== Ahashic Tome ======
//
	var completeTome = <akashictome:tome>.withTag(

	{
		"akashictome:is_morphing": 1 as byte,
		"akashictome:data": {
			astralsorcery: {
				id: "astralsorcery:itemjournal",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "astralsorcery"
				},
				Damage: 0 as short
			},
			betterwithmods: {
				id: "betterwithmods:manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "betterwithmods"
				},
				Damage: 0 as short
			},
			bloodmagic: {
				id: "guideapi:bloodmagic-guide",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "bloodmagic"
				},
				Damage: 0 as short
			},
			botania: {
				id: "botania:lexicon",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "botania"
				},
				Damage: 0 as short
			},
			cookingforblockheads: {
				id: "cookingforblockheads:recipe_book",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "cookingforblockheads"
				},
				Damage: 1 as short
			},
			deepresonance: {
				id: "deepresonance:dr_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "deepresonance"
				},
				Damage: 0 as short
			},
			embers: {
				id: "embers:codex",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "embers"
				},
				Damage: 0 as short
			},
			forestry: {
				id: "forestry:book_forester",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "forestry"
				},
				Damage: 0 as short
			},
			immersiveengineering: {
				id: "immersiveengineering:tool",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "immersiveengineering"
				},
				Damage: 3 as short
			},
			integratedtunnels: {
				id: "integrateddynamics:on_the_dynamics_of_integration",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "integratedtunnels"
				},
				Damage: 0 as short
			},
			rftools: {
				id: "rftools:rftools_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rftools"
				},
				Damage: 0 as short
			},
			/*
			rftools: {
				id: "rftools:rftools_shape_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rftools"
				},
				Damage: 0 as short
			},
			*/
			rustic: {
				id: "rustic:book",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rustic"
				},
				Damage: 0 as short
			},
			techreborn: {
				id: "techreborn:techmanuel",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "techreborn"
				},
				Damage: 0 as short
			},
			thaumcraft: {
				id: "thaumcraft:thaumonomicon",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "thaumcraft"
				},
				Damage: 0 as short
			},
			theoneprobe: {
				id: "theoneprobe:probenote",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "theoneprobe"
				},
				Damage: 0 as short
			},
			thermalfoundation: {
				id: "thermalfoundation:tome_lexicon",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "thermalfoundation"
				},
				Damage: 0 as short
			},
			xnet: {
				id: "xnet:xnet_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "xnet"
				},
				Damage: 0 as short
			}
		}
	}
	
	);

	//metadata to item
	completeTome.addTooltip(format.aqua("Contains most modded manuals!"));

	//add the full book to JEI as it's own entry
	mods.jei.JEI.addItem(completeTome);

	//1 dirt = book
	recipes.addShapeless(completeTome, [<minecraft:book>]);
	
	// Starting item
	mods.initialinventory.InvHandler.addStartingItem(completeTome);
