//TRAIN STATION 13

//A fairly powerful radioisotope thermoelectric generator that runs on tritium isotopes.

/obj/machinery/power/port_gen/rtg
	name = "R.T.G."
	desc = "A radioisotope thermoelectric generator (RTG, RITEG) - a type of nuclear battery that uses an array of thermocouples to convert the heat released by the decay of a suitable radioactive material into electricity by the Seebeck effect."
	anchored = TRUE
	icon = 'trainstation13/icons/64x64.dmi'
	icon_state = "rtg_off" // Sprite by INFRARED_BARON
	icon_state_on = "rtg_on"
	layer = 5
	power_gen = 10000
	pixel_x = -16
	var/sheets = 0
	var/max_sheets = 100
	var/sheet_name = "tritium"
	var/sheet_path = /obj/item/stack/sheet/mineral/tritium
	var/board_path = /obj/item/weapon/circuitboard/pacman
	var/sheet_left = 0 // How much is left of the sheet
	var/time_per_sheet = 80
	var/heat = 0
	var/capacity_scale_with_upgrades = TRUE
	var/rad_cooef = 20
	var/rad_range = 3 // Please remake formula so emission range depends on output power.

/obj/machinery/power/port_gen/rtg/atom_init()
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/matter_bin(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(src, 1)
	component_parts += new /obj/item/stack/cable_coil/red(src, 1)
	component_parts += new /obj/item/stack/cable_coil/red(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/cell/high(src)
	component_parts += new /obj/item/weapon/stock_parts/capacitor(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/capacitor(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/capacitor(src, 1)
	component_parts += new /obj/item/weapon/stock_parts/capacitor(src, 1)
	component_parts += new board_path(src)
	RefreshParts()

/obj/machinery/power/port_gen/rtg/atom_init()
	. = ..()
	if(anchored)
		connect_to_network()

/obj/machinery/power/port_gen/rtg/Destroy()
	DropFuel()
	return ..()

/obj/machinery/power/port_gen/rtg/RefreshParts()
	var/temp_rating = 0
	var/consumption_coeff = 0
	for(var/obj/item/weapon/stock_parts/SP in component_parts)
		if(istype(SP, /obj/item/weapon/stock_parts/matter_bin) && capacity_scale_with_upgrades)
			max_sheets = SP.rating * SP.rating * 50
		else if(istype(SP, /obj/item/weapon/stock_parts/capacitor))
			temp_rating += SP.rating
		else
			consumption_coeff += SP.rating
	power_gen = round(initial(power_gen) * temp_rating * 2)
	consumption = consumption_coeff

/obj/machinery/power/port_gen/rtg/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>The generator has [sheets] units of [sheet_name] fuel left, producing [power_gen] per cycle.</span>")
	if(crit_fail)
		to_chat(user, "<span class='danger'>The generator seems to have broken down.</span>")

/obj/machinery/power/port_gen/rtg/HasFuel()
	if(sheets >= 1 / (time_per_sheet / power_output) - sheet_left)
		return 1
	return 0

/obj/machinery/power/port_gen/rtg/DropFuel()
	if(sheets)
		var/fail_safe = 0
		while(sheets > 0 && fail_safe < 100)
			fail_safe += 1
			var/obj/item/stack/sheet/S = new sheet_path(loc)
			var/amount = min(sheets, S.max_amount)
			S.set_amount(amount)
			sheets -= amount

/obj/machinery/power/port_gen/rtg/UseFuel()
	var/needed_sheets = 1 / (time_per_sheet * consumption / power_output)
	var/temp = min(needed_sheets, sheet_left)
	needed_sheets -= temp
	sheet_left -= temp
	sheets -= round(needed_sheets)
	needed_sheets -= round(needed_sheets)
	if (sheet_left <= 0 && sheets > 0)
		sheet_left = 1 - needed_sheets
		sheets--

	var/lower_limit = 56 + power_output * 10
	var/upper_limit = 76 + power_output * 10
	var/bias = 0
	if (power_output > 4)
		upper_limit = 400
		bias = power_output - consumption * (4 - consumption)
	if (heat < lower_limit)
		heat += 4 - consumption
	else
		heat += rand(-7 + bias, 7 + bias)
		if (heat < lower_limit)
			heat = lower_limit
		if (heat > upper_limit)
			heat = upper_limit

	if (heat > 300)
		overheat()
		qdel(src)
	return

/obj/machinery/power/port_gen/rtg/handleInactive()

	if (heat > 0)
		heat = max(heat - 2, 0)
		updateDialog()

/obj/machinery/power/port_gen/rtg/proc/overheat()
	explosion(src.loc, 6, 5, 4, -1)

/obj/machinery/power/port_gen/rtg/proc/add_sheets(obj/item/I, mob/user, params)
	var/obj/item/stack/addstack = I
	var/amount = min((max_sheets - sheets), addstack.get_amount())
	if(amount < 1)
		to_chat(user, "<span class='notice'>The [name] is full!</span>")
		return
	to_chat(user, "<span class='notice'>You add [amount] sheets to the [name].</span>")
	sheets += amount
	addstack.use(amount)
	playsound(src, 'sound/items/insert_key.ogg', VOL_EFFECTS_MASTER)

/obj/machinery/power/port_gen/rtg/attackby(obj/item/O, mob/user, params)
	if(istype(O, sheet_path))
		add_sheets(O, user, params)
		updateUsrDialog()
	else if(!active)

		if(exchange_parts(user, O))
			return

/* Don't even think about it!
		if(iswrenching(O))

			if(!anchored && !isinspace())
				connect_to_network()
				to_chat(user, "<span class='notice'>You secure the generator to the floor.</span>")
				anchored = TRUE
			else if(anchored)
				disconnect_from_network()
				to_chat(user, "<span class='notice'>You unsecure the generator from the floor.</span>")
				anchored = FALSE

			playsound(src, 'sound/items/Deconstruct.ogg', VOL_EFFECTS_MASTER)
*/

		else if(isscrewing(O))
			panel_open = !panel_open
			playsound(src, 'sound/items/Screwdriver.ogg', VOL_EFFECTS_MASTER)
			if(panel_open)
				to_chat(user, "<span class='notice'>You open the access panel.</span>")
			else
				to_chat(user, "<span class='notice'>You close the access panel.</span>")
		else if(isprying(O) && panel_open)
			default_deconstruction_crowbar(O)

/obj/machinery/power/port_gen/rtg/emag_act(mob/user)
	if(emagged)
		return FALSE
	emagged = 1
	user.SetNextMove(CLICK_CD_INTERACT)
	emp_act(1)
	return TRUE

/obj/machinery/power/port_gen/rtg/ui_interact(mob/user)
	if ((get_dist(src, user) > 1) && !issilicon(user) && !isobserver(user))
		user.unset_machine(src)
		user << browse(null, "window=port_gen")
		return

	var/dat = ""
	if (active)
		dat += text("Generator: <A href='?src=\ref[src];action=disable'>On</A><br>")
	else
		dat += text("Generator: <A href='?src=\ref[src];action=enable'>Off</A><br>")
	dat += text("[capitalize(sheet_name)]: [sheets] - <A href='?src=\ref[src];action=eject'>Eject</A><br>")
	var/stack_percent = round(sheet_left * 100, 1)
	dat += text("Current stack: [stack_percent]% <br>")
	dat += text("Power output: <A href='?src=\ref[src];action=lower_power'>-</A> [power_gen * power_output] <A href='?src=\ref[src];action=higher_power'>+</A><br>")
	dat += text("Power current: [(powernet == null ? "Unconnected" : "[avail()]")]<br>")
	dat += text("Heat: [heat]<br>")

	var/datum/browser/popup = new(user, "port_gen", src.name)
	popup.set_content(dat)
	popup.open()

/obj/machinery/power/port_gen/rtg/is_operational()
	return TRUE

/obj/machinery/power/port_gen/rtg/Topic(href, href_list)
	. = ..()
	if(!.)
		return

	if(href_list["action"])
		if(href_list["action"] == "enable")
			if(!active && HasFuel() && !crit_fail)
				playsound(src, 'trainstation13/sound/machines/rtg_on.ogg', VOL_EFFECTS_MASTER, vol = 250, vary = FALSE, extrarange = 5)
				VARSET_IN(src, active, TRUE, 13 SECONDS)
				VARSET_IN(src, icon_state, icon_state_on, 13 SECONDS)
		if(href_list["action"] == "disable")
			if (active)
				playsound(src, 'trainstation13/sound/machines/rtg_off.ogg', VOL_EFFECTS_MASTER, vol = 250, vary = FALSE, extrarange = 5)
				VARSET_IN(src, active, FALSE, 22 SECONDS)
				VARSET_IN(src, icon_state, initial(icon_state), 22 SECONDS)
		if(href_list["action"] == "eject")
			if(!active)
				DropFuel()
		if(href_list["action"] == "lower_power")
			if (power_output > 1)
				power_output--
		if (href_list["action"] == "higher_power")
			if (power_output < 4 || emagged)
				power_output++

	updateUsrDialog()

/obj/machinery/power/port_gen/rtg/process()

	if(active  && !crit_fail && anchored && powernet)
		add_avail(power_gen * power_output)
		UseFuel()
		irradiate_in_dist(get_turf(src), rad_cooef, rad_range)
		updateDialog()

	else
		active = 0
		icon_state = initial(icon_state)
		handleInactive()

//RTG CIRCUITBOARD

/obj/item/weapon/circuitboard/rtg
	name = "circuit board (RTG)"
	build_path = /obj/machinery/power/port_gen/rtg
	board_type = "machine"
	origin_tech = "programming=4;powerstorage=5;engineering=5"
	req_components = list(
							/obj/item/stack/cable_coil = 2,
							/obj/item/weapon/stock_parts/matter_bin = 2,
							/obj/item/weapon/stock_parts/micro_laser = 4,
							/obj/item/weapon/stock_parts/cell/high = 1,
							/obj/item/weapon/stock_parts/capacitor = 4)
