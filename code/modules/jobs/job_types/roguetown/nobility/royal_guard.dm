/datum/job/roguetown/ducalguard
	title = "Ducal Guard"
	flag = DUCAL_GUARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	allowed_races = RACES_NOBILITY_ELIGIBLE_UP
	allowed_patrons = NON_PSYDON_PATRONS
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	tutorial = "Having proven yourself both loyal and capable, you have been elevated to serve as your liege's personal bodyguard."	
	display_order = JDO_KNIGHT
	whitelist_req = TRUE
	outfit = /datum/outfit/job/knight
	advclass_cat_rolls = list(CTAG_ROYALGUARD = 20)
	give_bank_account = 22
	noble_income = 20
	min_pq = 20
	max_pq = null
	round_contrib_points = 3
	social_rank = SOCIAL_RANK_MINOR_NOBLE

	virtue_restrictions = list(
		/datum/virtue/utility/blacksmith // we don't want you repairing your stuff in combat, sorry...
	)
	cmode_music = 'sound/music/combat_knight.ogg'

	job_traits = list(TRAIT_NOBLE, TRAIT_STEELHEARTED, TRAIT_GUARDSMAN_NOBLE)
	job_subclasses = list(
		/datum/advclass/royalguard,
		/datum/virtue/combat/crimson_curse,
		)

/datum/job/roguetown/ducalguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Ser"
		if(get_pronoun_gender(H) == "FEM")
			honorary = "Dame"
		GLOB.chosen_names -= prev_real_name
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		GLOB.chosen_names += H.real_name

		for(var/X in peopleknowme)
			for(var/datum/mind/MF in get_minds(X))
				if(MF.known_people)
					MF.known_people -= prev_real_name
					H.mind.person_knows_me(MF)

/datum/advclass/royalguard
	name = "Royal Champion"
	tutorial = "Veteran among knights, you've proven yourself time and again in service to the crown. \
	Your loyalty is unwaveringly strong, with the sole purpose of defending your liege and their realm. \
	Your experience with both infantry and cavalry tactics makes you a versatile combatant, \
	equally adept whether on foot or mounted. You are a champion of the realm."
	outfit = /datum/outfit/job/knight/champion
	horse = /mob/living/simple_animal/hostile/retaliate/rogue/saiga/saigabuck/tame/saddled
	category_tags = list(CTAG_ROYALGUARD)
	maximum_possible_slots = 1

	traits_applied = list(TRAIT_HEAVYARMOR)
	subclass_stats = list(
		STATKEY_STR = 2,
		STATKEY_CON = 2,
		STATKEY_END = 2,
		STATKEY_INT = 2,
		STATKEY_PER = 1,
		STATKEY_SPD = -1,
		STATKEY_LCK = 1
	)

	subclass_skills = list(
		/datum/skill/combat/swords = SKILL_LEVEL_MASTER,
		/datum/skill/combat/polearms = SKILL_LEVEL_MASTER,
		/datum/skill/combat/wrestling = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/unarmed = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/axes = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/maces = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/shields = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/crossbows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/whipsflails = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/bows = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/climbing = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/riding = SKILL_LEVEL_EXPERT,
	)

/datum/outfit/job/knight/champion/proc/name_tabard(mob/living/carbon/human/H)
	if(!istype(H.cloak, /obj/item/clothing/cloak/stabard/surcoat/guard))
		return
	
	var/list/name_parts = splittext(H.real_name, " ")
	var/first_name = name_parts[2]
	H.cloak.name = "knight's tabard ([first_name])"

/datum/outfit/job/knight/champion/pre_equip(mob/living/carbon/human/H)
	..()
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.verbs |= /mob/proc/haltyell

	// Champion-specific armor
	cloak = /obj/item/clothing/cloak/champion
	armor = /obj/item/clothing/suit/roguetown/armor/champion
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	pants = /obj/item/clothing/under/roguetown/platelegs/champion	// They're unique and also this is the champion
	head = /obj/item/clothing/head/roguetown/helmet/visored/champion
	
	var/char_age = H.age
	if(char_age == AGE_MIDDLEAGED)
		H.change_stat(STATKEY_SPD, 1) // +1 SPD for middle aged
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) 
	else if(char_age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

	H.adjust_blindness(-3)
	var/weapons = list(
		"Law & Order (Sabre & Buckler)",
		"Deliverer (Glaive)"
	)
	var/weapon_choice = input(H, "Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Law & Order (Sabre & Buckler)") // felt the need to specify
			beltr = /obj/item/rogueweapon/sword/championsabre
			backl = /obj/item/rogueweapon/shield/championbuckler
		if("Deliverer (Glaive)")
			r_hand = /obj/item/rogueweapon/halberd/championglaive

	backpack_contents = list(
		/obj/item/rogueweapon/huntingknife/idagger/steel/special = 1,
		/obj/item/rope/chain = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
	)

