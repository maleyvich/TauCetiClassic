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

	/datum/role/heretic/Greet(greeting, custom)
	. = ..()
	to_chat(antag.current, "<b>Вы - Еретик... На данный момент, вы скрываетесь под личиной одного из сотрудников станции [station_name()].</b>")
	to_chat(antag.current, "<b>На данный момент, вы обладаете лишь способностью Unholy Fire, которая будет улучшаться прогрессивно выбранному вами пути.</b>")
	to_chat(antag.current, "<b>Вы враждебны ко всем остальным еретикам на станции, ведь они могут помешать выполнению ваших целей..</b>")
	to_chat(antag.current, "<b>Если вы впервые играете за Еретика и хотите ознакомиться со всеми путями и способностями - пройдите на эту страницу - https://wiki.taucetistation.org</b><br>")

	/datum/role/heretic/OnPostSetup(laterole)
	. = ..()
	var/mob/living/carbon/human/H = antag.current

	if(antag.assigned_role == "Clown")
		to_chat(H, "<span class='notice'>Вы перестали быть типичным клоуном. Теперь - вы само Божество!</span>")
		REMOVE_TRAIT(H, TRAIT_CLUMSY, GENETIC_MUTATION_TRAIT)
