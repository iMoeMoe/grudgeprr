/obj/item/organ/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	visible_organ = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight
	///What species get flights thanks to those wings. Important for moth wings
	var/list/flight_for_species
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open
	///Whether an openable wing is currently opened
	var/is_open
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight

//TODO: Well you know what this flight stuff is a bit complicated and hardcoded, this is enough for now

/obj/item/organ/wings/moth
	name = "fluvian wings"
	desc = "A pair of fuzzy moth wings."
	flight_for_species = list("moth")

/obj/item/organ/wings/dracon
	name = "drakian wings"
	desc = "A pair of majestic drakian wings."
//	flight_for_species = list("dracon") we'll revisit this later it's probably moth sprite only

/obj/item/organ/wings/anthro
	name = "wild-kin wings"

/obj/item/organ/wings/flight
	unconditional_flight = TRUE
	can_open = TRUE

/obj/item/organ/wings/flight/angel
	name = "angel wings"
	desc = "A pair of magnificent, feathery wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/flight/dragon
	name = "dragon wings"
	desc = "A pair of intimidating, membranous wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/flight/megamoth
	name = "megamoth wings"
	desc = "A pair of horrifyingly large, fuzzy wings. They look strong enough to lift you up in the air."

/obj/item/organ/wings/harpy
	name = "harpy wings"
	desc = "Oh, to fly again and feel the wind..."

/obj/item/organ/wings/harpy/Insert(mob/living/carbon/human/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(M.mind)
		M.mind.AddSpell(new /obj/effect/proc_holder/spell/self/harpy_flight)

/obj/item/organ/wings/harpy/Remove(mob/living/carbon/human/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
//	to_chat(world, "removed wings")
	if(M.mind)
//		to_chat(world, "should remove spell")
		M.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/harpy_flight)

/obj/effect/proc_holder/spell/self/harpy_flight
	name = "Flight"
	releasedrain = 10
	chargedrain = 0
	chargetime = 0
	overlay_state = "zad"
	movement_interrupt = FALSE
	sound = 'sound/misc/astratascream.ogg'
	associated_skill = null
	antimagic_allowed = TRUE
	recharge_time = 1
	miracle = FALSE

/obj/effect/proc_holder/spell/self/harpy_flight/cast(mob/living/carbon/human/user)
	if(!user.has_status_effect(/datum/status_effect/debuff/harpy_flight))
		user.visible_message(
			span_bloody("[user] takes to the skies!!"),
			span_bloody("I take to the skies!"))
		user.say("Aha!")
		user.apply_status_effect(/datum/status_effect/debuff/harpy_flight)
//		animate(user, pixel_y = user.pixel_y + 2, time = 10, loop = -1)
//		sleep(10)
//		animate(user, pixel_y = user.pixel_y - 2, time = 10, loop = -1)
	else
		to_chat(user, "Wah, back on the ground!") // sad emoji
		user.remove_status_effect(/datum/status_effect/debuff/harpy_flight)
/*
//TODO: Better floating
/atom/movable/proc/float(on)
	if(throwing)
		return
	if(on && !(movement_type & FLOATING))
		animate(src, pixel_y = pixel_y + 2, time = 1 SECONDS, loop = -1, flags = ANIMATION_RELATIVE)
		animate(pixel_y = pixel_y - 2, time = 1 SECONDS, loop = -1, flags = ANIMATION_RELATIVE)
		setMovetype(movement_type | FLOATING)
	else if (!on && (movement_type & FLOATING))
		animate(src, pixel_y = initial(pixel_y), time = 1 SECONDS)
		setMovetype(movement_type & ~FLOATING)
*/
