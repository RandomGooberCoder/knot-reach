/datum/runeritual/reality_manipulation
	abstract_type = /datum/runeritual/reality_manipulation
	category = "Reality Manipulation"

/datum/runeritual/reality_manipulation/granter_imbuement
	name = "granter imbuement"
	required_atoms = list(/obj/item/magic/reality_fragment = 1, /obj/item/spellbook_unfinished = 1, /obj/item/magic/melded/t1 = 1)
	result_atoms = list(/obj/item/book/granter/spell_points)

/datum/runeritual/reality_manipulation/unstable_spell_granter
	name = "unstable spell granting" // CASINO ROYALE
	required_atoms = list(/obj/item/magic/reality_fragment = 1, /obj/item/spellbook_unfinished = 1)
	result_atoms = list(/obj/item/book/granter/spell/random)

/datum/runeritual/reality_manipulation/melded_spell_granter
	name = "melded spell granting"
	required_atoms = list(/obj/item/magic/reality_fragment = 1, /obj/item/spellbook_unfinished = 1, /obj/item/magic/melded/t2 = 3)

/datum/runeritual/reality_manipulation/melded_spell_granter/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/spell_choice = tgui_input_list(user, "Choose the spell to imprint in the tome.", "Spell Binding", user.mind?.spell_list)
	if(!spell_choice)
		return FALSE

	var/obj/item/book/granter/spell/spellbook = new(loc)
	spellbook.spell = spell_choice
	spellbook.spellname = spell_choice
	return TRUE

/datum/runeritual/reality_manipulation/stable_spell_granter
	name = "stable spell granting"
	required_atoms = list(/obj/item/magic/reality_fragment = 2, /obj/item/spellbook_unfinished = 1)

/datum/runeritual/reality_manipulation/stable_spell_granter/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/spell_choice = tgui_input_list(user, "Choose the spell to imprint in the tome.", "Spell Binding", user.mind?.spell_list)
	if(!spell_choice)
		return FALSE

	var/obj/item/book/granter/spell/spellbook = new(loc)
	spellbook.spell = spell_choice
	spellbook.spellname = spell_choice
	return TRUE

/datum/runeritual/reality_manipulation/dangerous_spell_granting
	name = "charming spell granting"
	required_atoms = list(/obj/item/magic/reality_fragment = 2, /obj/item/spellbook_unfinished = 1, /obj/item/magic/melded/t3 = 1)

/datum/runeritual/reality_manipulation/dangerous_spell_granting/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/static/list/possible_spells = list(
		/obj/effect/proc_holder/spell/invoked/meteor_storm,
		/obj/effect/proc_holder/spell/invoked/sundering_lightning,
		/obj/effect/proc_holder/spell/invoked/gravity/scrunch,
		/obj/effect/proc_holder/spell/invoked/forcewall/greater/firewall,
	)

	var/obj/effect/proc_holder/spell/spell_choice = pick(possible_spells)

	var/obj/item/book/granter/spell/spellbook = new(loc)
	spellbook.spell = spell_choice
	spellbook.spellname = initial(spell_choice.name)
	return TRUE
