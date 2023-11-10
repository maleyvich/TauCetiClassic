/datum/objective/heretic_maxpath
	explanation_text = "Вы должны максимально возвыситься, как минимум в одном пути."

/datum/objective/heretic_maxpath/check_completion()

/datum/objective/heretic_rampage
	explanation_text = "Вы не должны допустить возвышения других ложных богов. Они должны быть уничтожены в зародыше."

/datum/objective/heretic_rampage/check_completion()
	var/list/all_eheretics = find_factions_by_type(/datum/faction/heretic)
	if(!all_eheretics.len)
		return OBJECTIVE_LOSS

	var/list/detect_aliveheretics = find_faction_by_member(datum/role/R, datum/mind/M)
		for(var/datum/faction/F in SSticker.mode.factions)
			for(var/datum/role/RR in F.members)
				if(RR == R || RR.antag == M)
					return F


