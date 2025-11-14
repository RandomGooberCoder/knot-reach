/// Global object, exists in only one instance, accessible from everywhere
GLOBAL_DATUM_INIT(reality_smash_track, /datum/reality_smash_tracker, new)

#define RIFT_LOWER_INTERVAL (30 MINUTES)
#define RIFT_UPPER_INTERVAL (45 MINUTES)

/**
 * #Reality smash tracker
 *
 * A global singleton data that tracks all the heretic
 * influences ("reality smashes") that we've created,
 * and all of the heretics (minds) that can see them.
 *
 * Handles ensuring all minds can see influences, generating
 * new influences for new heretic minds, and allowing heretics
 * to see new influences that are created.
 */
/datum/reality_smash_tracker
	/// The total number of influences that have been drained, for tracking.
	var/num_drained = 0
	/// List of tracked influences (reality smashes)
	var/list/obj/effect/reality_rift/smashes = list()

/datum/reality_smash_tracker/New()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(spawn_rift)), rand(RIFT_LOWER_INTERVAL, RIFT_UPPER_INTERVAL))

/// Spawns a rift and assigns a timer
/datum/reality_smash_tracker/proc/spawn_rift()
	var/turf/chosen_location = get_safe_random_turf(
		list( \
				subtypesof(/area/rogue/outdoors/woods), \
				subtypesof(/area/rogue/indoors/shelter/woods), \
				subtypesof(/area/rogue/outdoors/beach/forest), \
				subtypesof(/area/rogue/outdoors/beach), \
				subtypesof(/area/rogue/indoors/shelter), \
				subtypesof(/area/rogue/outdoors/mountains/decap), \
			)
	)
	if(!istype(chosen_location))
		return

	new /obj/effect/reality_rift(chosen_location)
	addtimer(CALLBACK(src, PROC_REF(spawn_rift)), rand(RIFT_LOWER_INTERVAL, RIFT_UPPER_INTERVAL))

/datum/reality_smash_tracker/Destroy(force)
	if(GLOB.reality_smash_track == src)
		stack_trace("[type] was deleted. Heretics may no longer access any influences. Fix it, or call coder support.")
		message_admins("The [type] was deleted. Heretics may no longer access any influences. Fix it, or call coder support.")
	QDEL_LIST(smashes)
	return ..()

/obj/effect/reality_rift
	name = "pierced reality"
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "pierced_illusion"

	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_NO_FINGERPRINT_ATTACK_HAND|INTERACT_ATOM_NO_FINGERPRINT_INTERACT
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	invisibility = INVISIBILITY_OBSERVER

	/// Whether we're currently being drained or not.
	var/being_drained = FALSE
	/// The icon state applied to the image created for this influence.
	var/real_icon_state = "reality_smash"
	/// Proximity monitor that gives any nearby heretics x-ray vision
	var/datum/proximity_monitor/influence_monitor/monitor
	
	var/list/datum/piping_minigame/game_list = list()
	var/current_timer_id = FALSE
	var/mob/living/current_user

/obj/effect/reality_rift/Initialize(mapload)
	. = ..()
	GLOB.reality_smash_track.smashes += src
	//name = "\improper" + pick_list(HERETIC_INFLUENCE_FILE, "prefix") + " " + pick_list(HERETIC_INFLUENCE_FILE, "postfix")
	monitor = new(src, 7)

/obj/effect/reality_rift/examine(mob/living/user)
	. = ..()
	. += span_userdanger("Your mind burns as you stare at the tear!")

/obj/effect/reality_rift/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return

	if(!isarcyne(user))
		to_chat(user, span_boldwarning("You know better than to tempt forces out of your control!"))
		return TRUE

	if(being_drained)
		to_chat(user, span_boldwarning("Is already being drained by somebody!"))
		return

	var/mob/living/carbon/human/humen_user = user
	var/used_hand_zone = humen_user.used_hand == 1 ? BODY_ZONE_PRECISE_L_HAND : BODY_ZONE_PRECISE_R_HAND
	var/obj/item/bodypart/limb = humen_user.get_bodypart(used_hand_zone)
	if(!istype(limb))
		return

	if(prob(25))
		to_chat(humen_user, span_hypnophrase("A presence, unnatural and otherwordly, tears and atomizes your [limb.name] as you dare to touch the hole in the very fabric of reality!"))
		if(limb.dismember())
			limb.drop_limb()
			limb.forceMove(get_turf(src))
		return
	else
		to_chat(humen_user, span_danger("You pull your hand away from the hole as the rift in the very fabric of reality flails, trying to latch onto existence itself!"))
	start_draining(user)
	return TRUE

/obj/effect/reality_rift/proc/start_draining(mob/user)
	ASSERT(user)

	being_drained = TRUE
	game_list = list()
	current_user = user

	var/diffrences = 8 - user.get_skill_level(/datum/skill/magic/arcane)
	var/size = 8 - get_user_spell_tier(user)

	diffrences = max(1, diffrences--)
	if(!length(game_list))
		for(var/i in 1 to diffrences)
			var/datum/piping_minigame/game = new/datum/piping_minigame(size)
			game.generate()
			game_list += game

	var/mutable_appearance/draining_overlay = mutable_appearance('icons/effects/heretic_aura.dmi', "heretic_eye_dripping")
	add_overlay(draining_overlay)

	ui_interact(user)

/obj/effect/reality_rift/ui_host(mob/user)
	return user

/obj/effect/reality_rift/ui_state(mob/user)
	return GLOB.physical_state

/obj/effect/reality_rift/ui_data(mob/user)
	var/list/data = list()

	data["timeleft"] = current_timer_id ? timeleft(current_timer_id) : 0
	for(var/datum/piping_minigame/game in game_list)
		data["games"] += list(game.get_simplified_image())
		data["finished_states"] += list(game.finished)

	return data

/obj/effect/reality_rift/ui_assets(mob/user)
	. = ..()
	. += get_asset_datum(/datum/asset/simple/reality_rift)

/obj/effect/reality_rift/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		if(!current_timer_id)
			var/time_left = (game_list.len * 10  - 2 * (game_list.len-1) + user.get_skill_level(/datum/skill/magic/arcane)) SECONDS
			current_timer_id = addtimer(CALLBACK(src,PROC_REF(game_update), TRUE),time_left,TIMER_STOPPABLE)
		ui = new(user, src, "PipeMinigame", name)
		ui.open()

/obj/effect/reality_rift/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return TRUE

	if(action == "click")
		var/xcord = text2num(params["xcord"]) + 1
		var/ycord = text2num(params["ycord"]) + 1 //we need to slightly offset these so they work properly
		var/minigame_id = text2num(params["id"]) + 1
		if(game_list[minigame_id] && !game_list[minigame_id].finished)
			game_list[minigame_id].board[xcord][ycord].rotate()
			game_list[minigame_id].game_check()
			game_update()
		return TRUE

/obj/effect/reality_rift/proc/game_update(end_game = FALSE)
	var/finished = TRUE
	var/failed = 0

	for(var/datum/piping_minigame/game in game_list)
		if(!game.finished)
			finished = FALSE
			failed++

	if(finished)
		accession_success(length(game_list))

	if(end_game)
		accession_failure(failed)

/obj/effect/reality_rift/proc/accession_success(success as num)
	ui_close(current_user)
	cleanup()
	visible_message(span_warning("[src] begins to fade!"))
	GLOB.reality_smash_track.num_drained++
	new /obj/item/magic/reality_fragment(get_turf(src))
	qdel(src)

/obj/effect/reality_rift/proc/accession_failure(failed as num)
	cut_overlays()
	current_user.adjust_experience(/datum/skill/magic/arcane, (4 - failed) * 2)
	ui_close(current_user)
	cleanup()

/obj/effect/reality_rift/proc/cleanup()
	being_drained = FALSE
	current_user = null
	QDEL_LIST(game_list)

/obj/effect/reality_rift/Destroy()
	GLOB.reality_smash_track.smashes -= src
	QDEL_NULL(monitor)
	cleanup()
	return ..()

/datum/proximity_monitor/influence_monitor
	/// Cooldown before we can give another heretic xray
	COOLDOWN_DECLARE(xray_cooldown)

/datum/proximity_monitor/influence_monitor/HandleMove()
	//arrived_living.apply_status_effect(/datum/status_effect/temporary_xray/eldritch)
	COOLDOWN_START(src, xray_cooldown, 3 MINUTES)
