/datum/job/roguetown/minor_noble
	title = "Noble"
	flag = NOBLE
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 6
	spawn_positions = 6
	allowed_races = RACES_NOBILITY_ELIGIBLE_UP
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_COUNCILLOR

	outfit = /datum/outfit/job/lessernoble

	whitelist_req = FALSE
	advclass_cat_rolls = list(CTAT_LESSER_NOBLE = 2)
	give_bank_account = 40
	min_pq = 10
	max_pq = null
	round_contrib_points = 2
	cmode_music = 'sound/music/combat_noble.ogg'
	social_rank = SOCIAL_RANK_MINOR_NOBLE

	job_traits = list(TRAIT_NOBLE)
	job_subclasses = list(
		/datum/advclass/knight,
		/datum/advclass/councillor,
	)

/datum/outfit/job/lessernoble
	job_bitflag = BITFLAG_ROYALTY
	beltl = /obj/item/storage/keyring/lessernoble

