import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDict;
import crafttweaker.oredict.IOreDictEntry;


//all credit to the All the Mods team. They do amazing work.


//Gives the player a natures compass
mods.initialinventory.InvHandler.addStartingItem(<naturescompass:naturescompass>.withTag({}));

//Gives Stone AIOT
mods.initialinventory.InvHandler.addStartingItem(<actuallyadditions:stone_paxel>);

//Gives a crafting table
mods.initialinventory.InvHandler.addStartingItem(<actuallyadditions:item_crafter_on_a_stick>);


// All Credit goes to the ATM team for anything related to the AkashicTome

print(" =================== Akashic Tome =================== ");
print(" ==================================================== ");
/*
	Script just for the "all books included" tome to make it easier
	to see/find/edit/organize things related to just this tome
*/

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
			embers: {
				id: "embers:codex",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "embers"
				},
				Damage: 0 as short
			},
			pneumaticcraft: {
				id: "patchouli:guide_book",
				Count: 1 as byte,
				tag: {
					"patchouli:book": "pneumaticcraft:book"
				},
			},
			immersiveengineering: {
				id: "immersiveengineering:tool",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "immersiveengineering"
				},
				Damage: 3 as short
			},
			rftools: {
				id: "rftools:rftools_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rftools"
				},
				Damage: 0 as short
			},
			rustic: {
				id: "rustic:book",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rustic"
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
			thermalfoundation: {
				id: "thermalfoundation:tome_lexicon",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "thermalfoundation"
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
			actuallyadditions: {
				id: "actuallyadditions:item_booklet",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "actuallyadditions"
				},
				Damage: 0 as short
			},
			opencomputers: {
				id: "opencomputers:tool",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "opencomputers"
				},
				Damage: 4 as short
			},
			cookingforblockheads: {
				id: "cookingforblockheads:recipe_book",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "cookingforblockheads"
				},
				Damage: 1 as short
			},
			rftoolscontrol: {
				id: "rftoolscontrol:rftoolscontrol_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rftoolscontrol"
				},
				Damage: 0 as short
			},
			roots: {
				id: "patchouli:guide_book",
				Count: 1 as byte,
				tag: {
					"patchouli:book": "roots_guide"
				},
				Damage: 0 as short
			},
			integratedtunnels: {
				id: "integrateddynamics:on_the_dynamics_of_integration",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "integratedtunnels"
				},
				Damage: 0 as short
			},
			rftools1: {
				id: "rftools:rftools_shape_manual",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "rftools1"
				},
				Damage: 0 as short
			},
			tetra: {
				id: "tetra:journal",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "tetra"
				},
				Damage: 0 as short
			},
			totemic: {
				id: "totemic:totempedia",
				Count: 1 as byte,
				tag: {
					"akashictome:definedMod": "totemic"
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
			}
		}
	}
	);

	//metadata to item
	completeTome.addTooltip(format.aqua("Contains all basic mod manuals/guides already included"));
	mods.jei.JEI.addDescription(completeTome, "The Akashic tome is a book for your books...",
											  "This recipe of 1 dirt = full book is added by All The Mods to ALREADY contain most/all modded manuals as a convenience for our players");

	//add the full book to JEI as it's own entry
	mods.jei.JEI.addItem(completeTome);

	//1 dirt = book
	recipes.addShapeless(completeTome, [<minecraft:dirt>]);

	// Starting item
	mods.initialinventory.InvHandler.addStartingItem(completeTome);


//====== Tooltip for added books ======
//
	var addedBooks = [
		<astralsorcery:itemjournal>,
		<immersiveengineering:tool:3>,
		<embers:codex>.withTag({"akashictome:definedMod": "embers"}),
		<rftools:rftools_manual>,
		<rustic:book>,
		<botania:lexicon>,
		<thermalfoundation:tome_lexicon>,
		<guideapi:bloodmagic-guide>,
		<actuallyadditions:item_booklet>,
		<opencomputers:tool:4>,
		<cookingforblockheads:recipe_book:1>,
		<patchouli:guide_book>.withTag({"patchouli:book": "roots:roots_guide"}),
		<patchouli:guide_book>.withTag({"patchouli:book": "pneumaticcraft:book"}), 
		<rftoolscontrol:rftoolscontrol_manual>,
		<integrateddynamics:on_the_dynamics_of_integration>,
		<rftools:rftools_shape_manual>,
		<totemic:totempedia>,
		<tetra:journal>,
		<forestry:book_forester>
		] as IItemStack[];

	for itemBook in addedBooks {
		itemBook.addTooltip(format.aqua("Included within the \"default\" Akashic Tome"));
	}
