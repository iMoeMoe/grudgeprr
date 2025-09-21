/*
* basically there just to store the abstract items, those used for climbing and flying,
* where they are used to prevent interaction by taking up a slot
* and providing a bit better controls, I guess
*/

/obj/item/clothing/wall_grab
	name = "wall"
	item_state = "grabbing"
	icon_state = "grabbing"
	icon = 'icons/mob/roguehudgrabs.dmi'
	max_integrity = 10
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	no_effect = TRUE

/obj/item/clothing/wall_grab/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)
	var/turf/openspace = user.loc
	openspace.zFall(user) // slop?

/obj/item/clothing/wall_grab/intercept_zImpact(atom/movable/AM, levels = 1) // with this shit it doesn't generate "X falls through open space". thank u guppyluxx
    . = ..()
    . |= FALL_NO_MESSAGE

/obj/item/clothing/active_wing
	name = "wing"
	item_state = "grabbing"
	icon_state = "grabbing"
	icon = 'icons/mob/roguehudgrabs.dmi'
	max_integrity = 10
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	no_effect = TRUE

/obj/item/clothing/active_wing/dropped(mob/living/carbon/human/user)
	. = ..()
	if(QDELETED(src))
		return
	qdel(src)
//	var/turf/openspace = user.loc
	user.remove_status_effect(/datum/status_effect/debuff/harpy_flight)
//	openspace.zFall(user) // slop?

/obj/item/clothing/active_wing/intercept_zImpact(atom/movable/AM, levels = 1) // with this shit it doesn't generate "X falls through open space". thank u guppyluxx
    . = ..()
    . |= FALL_NO_MESSAGE
