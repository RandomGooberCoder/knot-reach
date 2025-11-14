#define WHISPER_COOLDOWN 10 SECONDS

/obj/item/paper/scroll/rift_compass
	name = "enchanted scroll"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "scrollpurple"
	var/last_compass_direction = ""
	var/last_z_level_hint = ""
	var/last_whisper = 0 // Last time the scroll whispered to the user
	var/obj/effect/reality_rift/tracked_rift

/obj/item/paper/scroll/rift_compass/read(mob/user)
	refresh_compass(user)
	return ..()

/obj/item/paper/scroll/rift_compass/process()
	if(world.time > last_whisper + WHISPER_COOLDOWN)
		last_whisper = world.time
		target_whisper()

/obj/item/paper/scroll/rift_compass/proc/refresh_compass(mob/user)
	if(!tracked_rift)
		choose_target(user)

	if(!tracked_rift)
		return

	update_compass(user)

	if(last_compass_direction)
		update_text()
		return TRUE

	return FALSE

/obj/item/paper/scroll/rift_compass/proc/update_text()
	var/scroll_text = "<center>RIFT LOCATOR</center><br>"
	if(last_compass_direction)
		scroll_text += "<b>Direction:</b> The target is [last_compass_direction]. "
		if(last_z_level_hint)
			scroll_text += " ([last_z_level_hint])"
	scroll_text += "<br>"
	scroll_text += "<br><i>The magic in this scroll will update as you progress.</i>"
	info = scroll_text
	update_icon()

/obj/item/paper/scroll/rift_compass/proc/target_whisper()
	if(!tracked_rift)
		return

	var/mob/bearer = loc
	if(open && istype(bearer))
		update_compass(bearer)
		var/message = ""
		message = "[last_compass_direction]"
		if(last_z_level_hint)
			message += " ([last_z_level_hint])"
		to_chat(bearer, span_info("The scroll whispers to you, the target is [message]"))

/obj/item/paper/scroll/rift_compass/proc/choose_target(mob/user)
	var/choice = tgui_input_list(user, "Select your target", "Reality Rift Tracker", GLOB.reality_smash_track.smashes)
	if(!choice)
		return

	if(tracked_rift)
		UnregisterSignal(tracked_rift, COMSIG_QDELETING)

	tracked_rift = choice
	RegisterSignal(tracked_rift, COMSIG_QDELETING, PROC_REF(on_rift_qdel))

/obj/item/paper/scroll/rift_compass/proc/on_rift_qdel()
	SIGNAL_HANDLER
	UnregisterSignal(tracked_rift, COMSIG_QDELETING)
	tracked_rift = null

/obj/item/paper/scroll/rift_compass/proc/update_compass(mob/user)
	var/turf/user_turf = user ? get_turf(user) : get_turf(src)
	if(!user_turf)
		last_compass_direction = "No signal detected"
		last_z_level_hint = ""
		return

	// Reset compass values
	last_compass_direction = "Searching for target..."
	last_z_level_hint = ""

	var/atom/target = tracked_rift
	var/turf/target_turf

	if(!target || !(target_turf = get_turf(target)))
		last_compass_direction = "location unknown"
		last_z_level_hint = ""
		return

	// We want the target to know z level differences but verticality exists
	// We don't want to frustrate player by forcing them to track on the same z level
	// Especially cuz of how many transitions exist
	if(target_turf.z != user_turf.z)
		var/z_diff = abs(target_turf.z - user_turf.z)
		last_z_level_hint = target_turf.z > user_turf.z ? \
			"[z_diff] level\s above you" : \
			"[z_diff] level\s below you"

	// Calculate direction from user to target
	var/dx = target_turf.x - user_turf.x  // EAST direction
	var/dy = target_turf.y - user_turf.y  // NORTH direction
	var/distance = sqrt(dx*dx + dy*dy)

	// If very close, don't show direction
	if(distance <= 7)
		last_compass_direction = "is nearby"
		last_z_level_hint = ""
		return

	// Calculate angle in degrees (0 = east, 90 = north)
	var/angle = ATAN2(dx, dy)
	if(angle < 0)
		angle += 360

	// Get precise direction text
	var/direction_text = get_precise_direction_from_angle(angle)

	// Determine distance description
	var/distance_text
	switch(distance)
		if(0 to 14)
			distance_text = "very close"
		if(15 to 40)
			distance_text = "close"
		if(41 to 100)
			distance_text = ""
		if(101 to INFINITY)
			distance_text = "far away"

	last_compass_direction = "[distance_text] to the [direction_text]"
	if(!last_z_level_hint)
		last_z_level_hint = "on this level"

#undef WHISPER_COOLDOWN
