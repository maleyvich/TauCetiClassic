/datum/role/heretic 
	name = HERETIC
	id = HERETIC
	required_pref = ROLE_HERETIC
	logo_state = "synd-logo"

	restricted_jobs = list("Cyborg", "Security Cadet", "Internal Affairs Agent", "Security Officer", "Warden", "Head of Security", "Captain", "Velocity Officer", "Velocity Chief", "Velocity Medical Doctor", "Blueshield Officer")
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "traitor"

	greets = list(GREET_DEFAULT)

	skillset_type = /datum/skillset/max
	moveset_type = /datum/combat_moveset/cqc
	change_to_maximum_skills = TRUE

/datum/role/traitor/proc/add_one_objective(datum/mind/traitor)
	switch(rand(1,120))
		if(1 to 20)
			AppendObjective(/datum/objective/target/assassinate, TRUE)
		if(21 to 40)
			AppendObjective(/datum/objective/target/harm, TRUE)
		if(41 to 50)
			AppendObjective(/datum/objective/research_sabotage, TRUE)
		if(51 to 115)
			AppendObjective(/datum/objective/steal, TRUE)
		else
			AppendObjective(/datum/objective/target/dehead, TRUE)

/datum/role/traitor/forgeObjectives()
	if(!..())
		return FALSE
	create_traitor_objectives()
	return TRUE

/datum/role/traitor/proc/create_traitor_objectives()
	if(issilicon(antag.current))
		AppendObjective(/datum/objective/target/assassinate, TRUE)
		AppendObjective(/datum/objective/target/assassinate, TRUE)
		AppendObjective(/datum/objective/survive)
		if(prob(10))
			AppendObjective(/datum/objective/block)
	else
		var/objectives_count = pick(1,2,2,3)

		while(objectives_count > 0)
			add_one_objective()
			objectives_count--

		switch(rand(1,120))
			if(1 to 60)
				AppendObjective(/datum/objective/escape)
			if(61 to 119)
				AppendObjective(/datum/objective/survive)
			else
				AppendObjective(/datum/objective/hijack)

/datum/role/traitor/process()
	// For objectives such as "Make an example of...", which require mid-game checks for completion
	if(locate(/datum/objective/target/harm) in objectives.GetObjectives())
		for(var/datum/objective/target/harm/H in objectives.GetObjectives())
			H.check_completion()

/datum/role/traitor/Greet(greeting = GREET_DEFAULT, custom)
	antag.current.playsound_local(null, 'sound/antag/tatoralert.ogg', VOL_EFFECTS_MASTER, null, FALSE)

	if(!greeting)
		return

	var/icon/logo = get_logo_icon()
	switch(greeting)
		if (GREET_DEFAULT)
			to_chat(antag.current, "[bicon(logo, css = "style='position:relative; top:10;'")] <span class='danger'>You are Heretic.</span>")
	return TRUE

/datum/role/traitor/OnPostSetup(laterole)
	. = ..()
	if(issilicon(antag.current))
		add_law_zero(antag.current)
		return
	for(var/datum/objective/O in objectives.GetObjectives())
		O.give_required_equipment()

/datum/role/traitor/RemoveFromRole(datum/mind/M, msg_admins)
	if(isAI(M.current))
		var/mob/living/silicon/ai/AI = M.current
		qdel(AI.aiRadio.keyslot1)
		AI.aiRadio.keyslot1 = new /obj/item/device/encryptionkey()
		AI.aiRadio.recalculateChannels()
	. = ..()

/datum/role/traitor/wishgranter

/datum/role/traitor/wishgranter/forgeObjectives()
	if(!..())
		return FALSE
	AppendObjective(/datum/objective/custom/wishgranter)
	AppendObjective(/datum/objective/escape)
	return TRUE

/datum/role/traitor/syndbeacon

/datum/role/traitor/syndbeacon/forgeObjectives()
	if(!..())
		return FALSE
	AppendObjective(/datum/objective/silence)
	return TRUE

/datum/role/traitor/syndcall

/datum/role/traitor/syndcall/Greet(greeting, custom)
	..()
	to_chat(antag.current, "<span class='userdanger'> <B>ATTENTION:</B> You hear a call from the Syndicate...</span>")

/datum/role/traitor/syndcall/OnPostSetup(laterole)
	. = ..()
	var/mob/living/carbon/human/H = antag.current
	H.equip_or_collect(new /obj/item/device/encryptionkey/syndicate(antag.current), SLOT_R_STORE)