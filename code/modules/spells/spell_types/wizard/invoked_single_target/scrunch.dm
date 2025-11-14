/obj/effect/proc_holder/spell/invoked/gravity/scrunch
	name = "Power Word: Scrunch"
	desc = "Twist thine foe's body in ways that should not be possible."
	releasedrain = 50
	chargedrain = 1
	chargetime = 50
	recharge_time = 60 SECONDS // One target only so lower CD than meteor storm and its equivalents
	delay = 3
	invocation = "Torquent!"

/obj/effect/proc_holder/spell/invoked/gravity/scrunch/do_grav_effect(mob/living/target)
	ASSERT(target)

	playsound(get_turf(target), 'sound/combat/gib (1).ogg', 100, FALSE, -1)
	target.visible_message(span_cult("[target]'s limbs twist and bend in ways that should not be possible!"))
	target.Stun(60)
	target.Knockdown(60)
	to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
	target.emote("Agony")
	target.spin(32, 2)
	for(var/zone in list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_LAMIAN_TAIL))
		var/obj/item/bodypart/limb = target.get_bodypart(zone)
		var/dam = rand(20, 60)
		if(limb && target.apply_damage(dam, BRUTE, target, target.run_armor_check(target, "blunt", damage = dam)))
			limb.try_crit(BCLASS_BLUNT, 300)

	target.visible_message(
		span_danger("[target] writhes in unimaginable pain!"),
		span_userdanger("IT HURTS! IT BURNS!")
	)
	target.emote("painscream", forced = TRUE)
