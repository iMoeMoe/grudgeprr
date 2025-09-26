/datum/sex_action/grind_body
	name = "Grind against them"
	check_same_tile = FALSE

/datum/sex_action/grind_body/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/grind_body/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_CHEST, FALSE))
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, FALSE))
		return FALSE
	return TRUE

/datum/sex_action/grind_body/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls themselves onto [target]..."))

/datum/sex_action/grind_body/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] grinds [target]'s body..."))
	if(user.sexcon.force > SEX_FORCE_HIGH)
		playsound(target, 'sound/misc/mat/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	else
		user.make_sucking_noise()
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 0.5, 0.5, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0.5, 0.5, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/grind_body/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops grinding against [target]'s body ..."))

/datum/sex_action/grind_body/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
