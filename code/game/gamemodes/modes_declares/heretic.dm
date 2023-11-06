/datum/game_mode/heretic
	name = "Heretic"
	config_name = "heretic"
	probability = 55
	factions_allowed = list(/datum/faction/heretic)

	minimum_player_count = 2
	minimum_players_bundles = 20

/datum/game_mode/heretic/announce()
	to_chat(world, "<B>The current game mode is - Heretic!</B>")
	to_chat(world, "<B>False gods discovered at the station! Don't let them gain their full power!!</B>")
