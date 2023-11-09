/datum/faction/heretic
	name = F_HERETIC
	ID = F_HERETIC
	required_pref = ROLE_HERETIC

	initroletype = /datum/role/heretic
	roletype = /datum/role/heretic

	min_roles = 1
	max_roles = 3
	accept_latejoiners = FALSE

	logo_state = "change-logoa"

/datum/faction/heretic/can_setup(num_players)
	max_roles = 1 + round(num_players / 10)
	return TRUE

/datum/faction/heretic/GetFactionHeader()
	var/icon/logo_left = get_logo_icon("change-logoa")
	var/icon/logo_right = get_logo_icon("change-logob")
	var/header = {"[bicon(logo_left, css = "style='position:relative; top:10px;'")] <FONT size = 2><B>[capitalize(name)]</B></FONT> [bicon(logo_right, css = "style='position:relative; top:10px;'")]"}
	return header

/datum/faction/heretic/forgeObjectives()
	. = ..()
	AppendObjective(/datum/objective/heretic_maxpath)
	AppendObjective(/datum/objective/heretic_rampage)
	for(var/datum/role/R in members)
		R.forgeObjectives()
	return TRUE
