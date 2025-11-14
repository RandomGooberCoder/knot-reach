/datum/job/roguetown/wapprentice
	title = "Magos Thrall"
	flag = MAGEAPPRENTICE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	allowed_races = RACES_ALL_KINDS
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	advclass_cat_rolls = list(CTAG_WAPPRENTICE = 20)
	social_rank = SOCIAL_RANK_YEOMAN

	tutorial = "Your master once saw potential in you, although you are uncertain if they still do, given how rigorous and difficult your studies have been. The path to using magic is a treacherous and untamed one, and you are still decades away from calling yourself even a journeyman in the field. Listen and serve, and someday you will earn your hat."

	outfit = /datum/outfit/job/roguetown/wapprentice

	display_order = JDO_MAGEAPPRENTICE
	give_bank_account = TRUE

	min_pq = 0
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_bandit_mage.ogg'
	advjob_examine = TRUE // So that Court Magicians can know if they're teachin' a Apprentice or if someone's a bit more advanced of a player. Just makes the title show up as the advjob's name.

	job_traits = list(TRAIT_MAGEARMOR, TRAIT_ARCYNE_T3)
	job_subclasses = list(
		/datum/advclass/wapprentice/warthrall,
		/datum/advclass/wapprentice/summoner,
		/datum/advclass/wapprentice/alchemist,
		/datum/advclass/wapprentice/associate,
	)

/datum/advclass/wapprentice/warthrall
	name = "War Mage"
	tutorial = "Frags for Fraggar"

	outfit = /datum/outfit/job/roguetown/wapprentice/warthrall
	category_tags = list(CTAG_WAPPRENTICE)

	subclass_spellpoints = 21
	subclass_stats = list(
		STATKEY_STR = -1,
		STATKEY_INT = 3,
		STATKEY_PER = 1,
		STATKEY_CON = 1,
		STATKEY_SPD = 1
	)
	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_APPRENTICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_JOURNEYMAN,
	)

/datum/advclass/wapprentice/summoner
	name = "Summoner"
	tutorial = "Gets fragged by hellhounds"

	outfit = /datum/outfit/job/roguetown/wapprentice/associate/summoner
	category_tags = list(CTAG_WAPPRENTICE)

	subclass_spellpoints = 21
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_PER = 2,
		STATKEY_CON = 1,
	)

	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_EXPERT,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
	)

/datum/advclass/wapprentice/alchemist
	name = "Alchemist Associate"
	tutorial = "Slave of the Cauldron"
	outfit = /datum/outfit/job/roguetown/wapprentice/alchemist
	category_tags = list(CTAG_WAPPRENTICE)

	traits_applied = list(TRAIT_SEEDKNOW)
	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_PER = 3,
		STATKEY_END = 1,
	)

	subclass_spellpoints = 21

	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/medicine = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_NOVICE,
		/datum/skill/magic/arcane = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/farming = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/misc/sewing = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/cooking = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/mining = SKILL_LEVEL_APPRENTICE,
		/datum/skill/labor/fishing = SKILL_LEVEL_NOVICE,
	)

/datum/advclass/wapprentice/associate
	name = "Magician's Associate"

	subclass_stats = list(
		STATKEY_INT = 3,
		STATKEY_PER = 2,
		STATKEY_SPD = 1
	)

	subclass_spellpoints = 21

	subclass_skills = list(
		/datum/skill/combat/polearms = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_NOVICE,
		/datum/skill/craft/crafting = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/medicine = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/riding = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/reading = SKILL_LEVEL_MASTER,
		/datum/skill/craft/alchemy = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/magic/arcane = SKILL_LEVEL_JOURNEYMAN,
		/datum/skill/craft/cooking = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/roguetown/wapprentice
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights/random
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/mageapprentice
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff
	shoes = /obj/item/clothing/shoes/roguetown/gladiator

/datum/outfit/job/roguetown/wapprentice/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(istype(H.patron, /datum/patron/inhumen/zizo))
		H.cmode_music = 'sound/music/combat_cult.ogg'

/datum/outfit/job/roguetown/wapprentice/warthrall/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/lord
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	neck = /obj/item/clothing/neck/roguetown/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/angle

/datum/outfit/job/roguetown/wapprentice/associate/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	head = /obj/item/clothing/head/roguetown/roguehood/mage
	beltl = /obj/item/storage/magebag/starter
	backpack_contents = list(
		/obj/item/roguegem/amethyst = 1,
		/obj/item/spellbook_unfinished/pre_arcyne = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/recipe_book/magic = 1,
		/obj/item/ritechalk = 1,
		)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H?.mind.adjust_spellpoints(6)

/datum/outfit/job/roguetown/wapprentice/alchemist/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backpack_contents = list(
		/obj/item/roguegem/amethyst = 1,
		/obj/item/seeds/swampweed = 1,
		/obj/item/seeds/pipeweed = 1,
		/obj/item/recipe_book/alchemy = 1,
		/obj/item/recipe_book/magic = 1,
		/obj/item/ritechalk = 1,
		/obj/item/spellbook_unfinished/pre_arcyne = 1
		)

	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		H.change_stat("perception", -1)
		H.change_stat("intelligence", 1)

/datum/outfit/job/roguetown/wapprentice/associate/summoner/pre_equip(mob/living/carbon/human/H)
	. = ..()
	beltl = /obj/item/storage/magebag/starter/double
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H?.mind.adjust_spellpoints(6)
