/turf/unsimulated/floor
	name = "плитка пола"
	cases = list("плитки пола", "плитке пола", "плитку пола", "плиткой пола", "плитке пола")
	icon = 'icons/turf/floors.dmi'
	icon_state = "floor"

/turf/unsimulated/floor/attack_paw(user)
	return attack_hand(user)

/turf/unsimulated/floor/abductor
	name = "иннопланетная плитка"
	cases = list("плитки пола", "плитке пола", "плитку пола", "плиткой пола", "плитке пола")
	icon_state = "alienpod1"

/turf/unsimulated/floor/abductor/atom_init()
	. = ..()
	icon_state = "alienpod[rand(1,9)]"

/turf/unsimulated/floor/fakealien
	name = "иннопланетная трава"
	icon = 'icons/mob/xenomorph.dmi'
	icon_state = "weeds"

/turf/unsimulated/floor/fakealien/weednode
	icon_state = "weednode"

/turf/unsimulated/floor/snow
	name = "снег"
	cases = list("снега", "снегу","снег", "снегом", "снеге")
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"

/turf/unsimulated/floor/fakespace
	name = "space"
	icon = 'icons/turf/space.dmi'
	icon_state = "0"
