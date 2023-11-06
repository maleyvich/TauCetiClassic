/obj/effect/proc_holder/spell/targeted/unfire
	name = "Unholy Fire"
	desc = "Stuns target for a decent duration. Improves with learning some paths."
	panel = "Heretic Abilities"
	action_icon_state = "glare"
	charge_max = 150
	clothes_req = 0

/obj/effect/proc_holder/spell/targeted/unfire/cast(list/targets)
	for(var/mob/living/carbon/human/target in targets)
		if(target.species.flags[NO_SCAN] || target.species.flags[IS_SYNTHETIC])
			charge_counter = charge_max
			to_chat(usr, "<span class='warning'>Your glare does not seem to affect [target].</span>")
			return
		if(target.stat != CONSCIOUS)
			charge_counter = charge_max
			return
		if(isshadowling(target) || isshadowthrall(target))
			to_chat(usr, "<span class='danger'>You don't see why you would want to paralyze an ally.</span>")
			charge_counter = charge_max
			return

		usr.visible_message("<span class='warning'><b>[usr]'s eyes flash a blinding red!</b></span>")
		target.visible_message("<span class='danger'>[target] freezes in place, their eyes glazing over...</span>")
		if(in_range(target, usr))
			to_chat(target, "<span class='userdanger'>Your gaze is forcibly drawn into [src]'s eyes, and you are mesmerized by the heavenly lights...</span>")
		else //Only alludes to the shadowling if the target is close by
			to_chat(target, "<span class='userdanger'>Red lights suddenly dance in your vision, and you are mesmerized by their heavenly beauty...</span>")
		target.Stun(10)
		target.silent += 10



