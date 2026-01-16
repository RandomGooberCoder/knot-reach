/datum/advclass/councillor
	name = "Councillor"
	tutorial = "You may have inherited this position, bought your way into it, or were appointed to it by merit--perish the thought! Whatever the case though, you work as an assistant and agent of the crown in matters of state. Whether this be aiding the steward, the sheriff, or the crown itself, or simply enjoying the free food of the keep, your duties vary day by day. You may be the lowest rung of the ladder, but that rung still towers over everyone else in town."
	outfit = /datum/outfit/job/lessernoble/councillor
	category_tags = list(CTAT_LESSER_NOBLE)

	subclass_stats = list(
		STATKEY_PER = 2,
		STATKEY_INT = 2,
		STATKEY_END = 1,
		STATKEY_STR = 1,
		STATKEY_SPD = 1,
	)

	subclass_skills = list(
		/datum/skill/misc/riding = SKILL_LEVEL_EXPERT,
		/datum/skill/misc/reading = SKILL_LEVEL_EXPERT,
		/datum/skill/combat/swords = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/wrestling = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/swimming = SKILL_LEVEL_APPRENTICE,
		/datum/skill/combat/unarmed = SKILL_LEVEL_NOVICE,
		/datum/skill/misc/athletics = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/climbing = SKILL_LEVEL_APPRENTICE,
		/datum/skill/misc/music = SKILL_LEVEL_NOVICE,
	)

/datum/outfit/job/lessernoble/councillor/pre_equip(mob/living/carbon/human/H)
	. = ..()
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	cloak = /obj/item/clothing/cloak/stabard/surcoat/councillor

	neck = /obj/item/clothing/neck/roguetown/bevor
	gloves = /obj/item/clothing/gloves/roguetown/plate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	belt = /obj/item/storage/belt/rogue/leather/steel
	backr = /obj/item/storage/backpack/rogue/satchel/black
	id = /obj/item/scomstone/bad/garrison
	backpack_contents = list(/obj/item/storage/keyring/guardknight = 1)
