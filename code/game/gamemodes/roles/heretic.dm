/datum/role/heretic
	name = HERETIC
	id = HERETIC
	required_pref = ROLE_HERETIC

	restricted_jobs = list("Cyborg", "Security Cadet", "Internal Affairs Agent", "Security Officer", "Warden", "Head of Security", "Captain", "Velocity Officer", "Velocity Chief", "Velocity Medical Doctor", "Blueshield Officer")
	antag_hud_type = ANTAG_HUD_HER
	antag_hud_name = "heretic"

	greets = list(GREET_LATEJOIN, GREET_ROUNDSTART, GREET_DEFAULT)

	skillset_type = /datum/skillset/max
	moveset_type = /datum/combat_moveset/cqc
	change_to_maximum_skills = FALSE

/datum/role/heretic/New()
	..()
	AddComponent(/datum/component/gamemode/heretic, "heretic")

/datum/role/heretic/proc/add_one_objective(datum/mind/heretic)
	switch(rand(1,120))
		if(1 to 20)
			AppendObjective(/datum/objective/target/assassinate, TRUE)
		if(21 to 55)
			AppendObjective(/datum/objective/target/dehead, TRUE)

/datum/role/heretic/forgeObjectives()
	if(!..())
		return FALSE
	if(issilicon(antag.current))
		AppendObjective(/datum/objective/target/assassinate, TRUE)
		AppendObjective(/datum/objective/target/assassinate, TRUE)
		AppendObjective(/datum/objective/survive)
		if(prob(10))
			AppendObjective(/datum/objective/block)
	else
		var/objectives_count = pick(1,2,2,3)
