/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_APPOINTED_OUTCASTS_UP		//Nobility, no construct
	disallowed_races = list(
		/datum/species/lamia,
	)
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	display_order = JDO_MAGICIAN
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		You owe your life to the Lord, for it was his coin that allowed you to continue your studies in these dark times. \
		In return, you have proven time and time again as justicar and trusted advisor to their reign."
	whitelist_req = TRUE
	give_bank_account = 47
	min_pq = 15 //High potential for abuse, lovepotion/killersice/greater fireball is not for the faint of heart
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_bandit_mage.ogg'
	advclass_cat_rolls = list(CTAG_COURTMAGE = 2)
	social_rank = SOCIAL_RANK_YEOMAN

	// Can't get very far as a magician if you can't chant spells now can you?
	vice_restrictions = list(/datum/charflaw/mute)

	job_traits = list(TRAIT_MAGEARMOR, TRAIT_ARCYNE_T4, TRAIT_SEEPRICES, TRAIT_INTELLECTUAL)
	job_subclasses = list(
		/datum/advclass/warmagos,
		/datum/advclass/alchmeister,
		/datum/advclass/courtmage,
	)

/datum/advclass/warmagos
	name = "War Magos"
	tutorial = "You have always believed that arcane arts belong not only in the library, but also on a battlefield.\
		Your Lord's patronage has allowed you to practice your slightly unorthodox ways for the duke of Reach has no shortage of enemies. \
		You have becom the flaming fist of their reign, turning the tide of battles with your spells."
	outfit = /datum/outfit/job/roguetown/warmagos
	category_tags = list(CTAG_COURTMAGE)

	subclass_stats = list(
		STATKEY_INT = 4,
		STATKEY_END = 1,
		STATKEY_STR = -1
	)

	subclass_spellpoints = 30

	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_EXPERT,
		/datum/skill/magic/arcane = SKILL_LEVEL_LEGENDARY,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
	)

/datum/advclass/alchmeister
	name = "Alchemy Meister"
	tutorial = "The master of the cauldron, your creed is one steeped in transmutation and the secrets hidden within matter itself.\
		You owe your life to the Lord, for it was his resources that funded your experiments when coin was scarce.\
		In return, you have served as the unseen pillar of their power, supplying the Duke with both elixirs and your wisdom."
	outfit = /datum/outfit/job/roguetown/alchmeister
	category_tags = list(CTAG_COURTMAGE)

	subclass_stats = list(
		STATKEY_INT = 6, // Smart as fuck, weaker
		STATKEY_STR = -1,
		STATKEY_CON = -1,
		STATKEY_END = -1,
	)

	subclass_spellpoints = 36

	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_LEGENDARY,
		/datum/skill/craft/alchemy = SKILL_LEVEL_LEGENDARY,
		/datum/skill/magic/arcane = SKILL_LEVEL_MASTER,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/swords = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/knives = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/advclass/courtmage
	name = "Court Magician"
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		You owe your life to the Lord, for it was his coin that allowed you to continue your studies in these dark times. \
		In return, you have proven time and time again as justicar and trusted advisor to their reign."
	outfit = /datum/outfit/job/roguetown/magician
	category_tags = list(CTAG_COURTMAGE)

	subclass_stats = list(
		STATKEY_INT = 5, // Guaranteed 15 INT 
		STATKEY_STR = -1,
		STATKEY_CON = -1,
	)

	subclass_spellpoints = 36

	subclass_skills = list(
		/datum/skill/misc/reading = SKILL_LEVEL_LEGENDARY,
		/datum/skill/craft/alchemy = SKILL_LEVEL_MASTER,
		/datum/skill/magic/arcane = SKILL_LEVEL_LEGENDARY,
		/datum/skill/misc/riding = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/polearms = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/knives = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
	)

/datum/outfit/job/roguetown/magician
	job_bitflag = BITFLAG_ROYALTY
	has_loadout = TRUE

/datum/outfit/job/roguetown/magician/choose_loadout(mob/living/carbon/human/H)
	. = ..()
	if(H.age == AGE_OLD)
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
		H?.mind.adjust_spellpoints(6)
		if(ishumannorthern(H))
			belt = /obj/item/storage/belt/rogue/leather/plaquegold
			cloak = null
			head = /obj/item/clothing/head/roguetown/wizhat
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
			H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo,
	  		/datum/patron/inhumen/matthios,
	   		/datum/patron/inhumen/graggar,
	   		/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/combat_cult.ogg'
			ADD_TRAIT(H, TRAIT_HERESIARCH, TRAIT_GENERIC)

/datum/outfit/job/roguetown/alchmeister/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	beltl = /obj/item/storage/magebag/starter/double
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff/riddle_of_steel/magos
	l_hand = /obj/item/storage/belt/rogue/pouch/gempouch
	backl = /obj/item/storage/backpack/rogue/satchel

	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/poison, 
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
		/obj/item/recipe_book/alchemy,
		/obj/item/recipe_book/magic,
		/obj/item/book/spellbook,
		/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
	)

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	beltl = /obj/item/storage/magebag/starter
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff/riddle_of_steel/magos
	backl = /obj/item/storage/backpack/rogue/satchel

	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/poison, 
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
		/obj/item/recipe_book/alchemy,
		/obj/item/recipe_book/magic,
		/obj/item/book/spellbook,
		/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
	)

/datum/outfit/job/roguetown/warmagos/pre_equip(mob/living/carbon/human/H)
	. = ..()
	neck = /obj/item/clothing/neck/roguetown/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/otavan
	pants = /obj/item/clothing/under/roguetown/heavy_leather_pants
	shoes = /obj/item/clothing/shoes/roguetown/boots/nobleboot
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/heavy
	cloak = /obj/item/clothing/cloak/black_cloak
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	gloves = /obj/item/clothing/gloves/roguetown/angle
	id = /obj/item/scomstone/bad/garrison
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	r_hand = /obj/item/rogueweapon/woodstaff/riddle_of_steel/magos
	backl = /obj/item/storage/backpack/rogue/satchel

	backpack_contents = list(
		/obj/item/reagent_containers/glass/bottle/rogue/poison, 
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot,
		/obj/item/recipe_book/alchemy,
		/obj/item/recipe_book/magic,
		/obj/item/book/spellbook,
		/obj/item/rogueweapon/huntingknife/idagger/silver/arcyne
	)
