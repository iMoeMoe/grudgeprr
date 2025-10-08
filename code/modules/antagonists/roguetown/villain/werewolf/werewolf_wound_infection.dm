/datum/wound
	/// Werewolf infection probability for bites on this wound
	var/werewolf_infection_probability = 15
	/// Time taken until werewolf infection comes in
	var/werewolf_infection_time = 2 MINUTES
	/// Actual infection timer
	var/werewolf_infection_timer = null
	/// if cap hit, notify
	var/mob/living/werewolf_attacker = null


/datum/wound/proc/werewolf_infect_attempt(mob/living/attacker = null)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return FALSE
	if(werewolf_infection_timer || !ishuman(owner) || !prob(werewolf_infection_probability))
		return
	var/mob/living/carbon/human/human_owner = owner
	if(!human_owner.can_werewolf())
		return
	if(human_owner.stat >= DEAD) //forget it
		return
	to_chat(human_owner, span_danger("I feel horrible... REALLY horrible..."))
	human_owner.mob_timers["puke"] = world.time
	human_owner.vomit(1, blood = TRUE, stun = FALSE)
	// notify later if infection cap hit 
	if(attacker && !QDELETED(attacker))
		werewolf_attacker = attacker
	werewolf_infection_timer = addtimer(CALLBACK(src, PROC_REF(wake_werewolf)), werewolf_infection_time, TIMER_STOPPABLE)
	severity = WOUND_SEVERITY_BIOHAZARD
	if(bodypart_owner)
		sortTim(bodypart_owner.wounds, GLOBAL_PROC_REF(cmp_wound_severity_dsc))
	return TRUE

/datum/wound/proc/wake_werewolf()
	if(QDELETED(src) || QDELETED(owner) || QDELETED(bodypart_owner))
		return FALSE
	if(!ishuman(owner))
		return FALSE
	var/mob/living/carbon/human/human_owner = owner
	// try to make ww, if cap hit, return FALSE
	var/datum/antagonist/werewolf/wolfy = human_owner.werewolf_check()
	if(!wolfy)
		// show a popup for clients and also post to chat so it's always visible
		if(werewolf_attacker && !QDELETED(werewolf_attacker))
			if(werewolf_attacker.client)
				alert(werewolf_attacker, "Dendor's curse growing thin... Slaughter it is")
			// always send a chat line as well (fallback / persistent log)
			to_chat(werewolf_attacker, span_warning("Dendor's curse growing thin... Slaughter it is"))
		return FALSE
	werewolf_infection_timer = null
	owner.flash_fullscreen("redflash3")
	to_chat(owner, span_danger("It hurts... Is this really the end for me?"))
	owner.emote("scream") // heres your warning to others bro
	owner.Knockdown(1)
	return wolfy
