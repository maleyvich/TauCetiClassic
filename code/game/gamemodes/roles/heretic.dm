/datum/role/heretic
	name = HERETIC
	id = HERETIC
	required_pref = ROLE_HERETIC
	logo_state = "synd-logo"

	restricted_jobs = list("Cyborg", "Security Cadet", "Internal Affairs Agent", "Security Officer", "Warden", "Head of Security", "Captain", "Velocity Officer", "Velocity Chief", "Velocity Medical Doctor", "Blueshield Officer")
	antag_hud_type = ANTAG_HUD_HERETIC
	antag_hud_name = "heretic"

	skillset_type = /datum/skillset/max
	moveset_type = /datum/combat_moveset/cqc
	change_to_maximum_skills = TRUE
