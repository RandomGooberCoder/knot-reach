/datum/antagonist/pale_plague
	var/static/list/applied_traits = list(
		TRAIT_CRITICAL_RESISTANCE,
	)

/datum/antagonist/pale_plague/New()
	. = ..()
	pass()

/datum/antagonist/pale_plague/on_gain()
	var/mob/living/carbon/target = owner.current

	for(var/trait in applied_traits)
		ADD_TRAIT(target, trait, "[REF(src)]")

	target.change_stat(STATKEY_CON, -2)
	target.change_stat(STATKEY_END, 2)
	target.change_stat(STATKEY_LCK, 2)

	RegisterSignal(target, COMSIG_MOB_ADJUST_NUTRITION, PROC_REF(on_nutrition_change))
	RegisterSignal(target, COMSIG_MOB_HEAL_WOUNDS, PROC_REF(on_heal_wounds))

	target.add_mob_descriptor(/datum/mob_descriptor/skin/diseased)
	// Hollow cheeks
	// Light/blanched eyes - change color
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/cache_eyes = human_target.cache_eye_color()
		human_target.set_eye_color(ColorTone(cache_eyes["eye_color"], rgb(96, 88, 80)), ColorTone(cache_eyes["second_color"], rgb(96, 88, 80)), TRUE)

/datum/antagonist/pale_plague/on_removal()
	var/mob/living/carbon/target = owner.current

	for(var/trait in applied_traits)
		REMOVE_TRAIT(target, trait, "[REF(src)]")

	UnregisterSignal(target, list(
		COMSIG_MOB_ADJUST_NUTRITION,
		COMSIG_MOB_HEAL_WOUNDS
	))

/datum/antagonist/pale_plague/proc/on_nutrition_change(mob/source, change)
	SIGNAL_HANDLER

	return (change * PALE_PLAGUE_NUTRITION_CHANGE_DIVISOR)

/datum/antagonist/pale_plague/proc/on_heal_wounds(mob/source, change)
	SIGNAL_HANDLER

	return (change * PALE_PLAGUE_HEAL_WOUDNS_DIVISOR)
