/obj/effect/proc_holder/spell/self/shield
	name = "Guarding Shield"
	desc = "guarding shit."
	overlay_state = "light"
	releasedrain = 50
	chargedrain = 1
	chargetime = 50
	recharge_time = 5 MINUTES
	invocation = "Torquent!"
	invocation_type = "shout"

	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 9
	miracle = FALSE

	var/list/atoms_to_orbit = list()
	var/list/atoms_in_orbit = list()

/obj/effect/proc_holder/spell/self/shield/cast(list/targets, mob/user = usr)
	RegisterSignal(user, COMSIG_LIVING_CHECK_PARRY, nameof(.proc/check_shield))
	for(var/obj/item/atom in view(user, 3))
		atom.forceMove(user)
		atoms_to_orbit |= atom
		RegisterSignal(atom, COMSIG_QDELETING, nameof(.proc/remove_atom))

/obj/effect/proc_holder/spell/self/shield/process()
	. = ..()
	if(LAZYLEN(atoms_to_orbit))
		add_atom()

/obj/effect/proc_holder/spell/self/shield/proc/add_atom()
	var/obj/item/atom = pick_n_take(atoms_to_orbit)
	if(QDELETED(atom))
		return

	atom.orbit(action?.owner, 25, TRUE)
	atoms_in_orbit |= atom

	if(LAZYLEN(atoms_to_orbit))
		addtimer(CALLBACK(src, PROC_REF(add_atom)), rand(0.5 SECONDS, 1 SECONDS))

/obj/effect/proc_holder/spell/self/shield/proc/check_shield()
	var/obj/item/blocker = safepick(atoms_in_orbit)
	if(!istype(blocker))
		return FALSE

	qdel(blocker)
	new /obj/item/ash(action?.owner?.loc)
	return COMPONENT_FORCE_PARRY

/obj/effect/proc_holder/spell/self/shield/proc/remove_atom(atom/movable/qdeleted_atom)
	SIGNAL_HANDLER
	qdeleted_atom.stop_orbit(action?.owner?.orbiters)
	atoms_in_orbit -= qdeleted_atom

/obj/effect/proc_holder/spell/self/shield/Destroy()
	atoms_to_orbit.Cut()
	atoms_in_orbit.Cut()
	return ..()
