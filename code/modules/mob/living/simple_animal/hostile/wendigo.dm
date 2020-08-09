
/mob/living/simple_animal/hostile/wendigo
	name = "Wendigo"
	desc = "You feel the sudden urge to run."
	icon = 'icons/mob/animal_64.dmi'
	icon_state = "wendigo"
	icon_living = "wendigo"
	icon_dead = "wendigo_dead"
	icon_gib = "wendigo_dead"
	speak = list("Savage...","Murder...","Maim...")
	speak_emote = list("howls", "screams")
	emote_hear = list("howls","screams")
	emote_see = list("stares", "howls")
	speak_chance = TRUE
	move_to_delay = 24
	see_in_dark = 2//Much, much less so you don't run into it as easily.
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/wendigo
	response_help  = "pokes"
	response_disarm = "swats at"
	response_harm   = "pokes"
	stop_automated_movement_when_pulled = FALSE
	maxHealth = 840//You're not meant to kill it. :)
	health = 840
	melee_damage_lower = 25
	melee_damage_upper = 80
	mob_size = MOB_HUGE//Safeguard against locker Wendigos.
	faction = "neutral"

//meat
/obj/item/weapon/reagent_containers/food/snacks/meat/wendigo
	name = "Wendigo slurry"
	desc = "Probably not a good idea to eat, unless you like prions. Looks and feels as if it's turning into a liquid as well. Nasty."
	icon_state = "rottenmeat"
	var/uses = 1//haha not anything more than one bucko, especially not with the below.
	New()
		..()
		reagents.add_reagent("plague", 10)
		reagents.add_reagent("mindbreaker", 30)

/obj/item/weapon/reagent_containers/food/snacks/meat/wendigo/attack_self(mob/user as mob)

	var/obj/item/ammo_casing/CURRENT = null
	if (user.l_hand == src && istype(user.r_hand, /obj/item/ammo_casing/arrow) && uses >= 1)
		CURRENT = user.r_hand
	else if (user.r_hand == src && istype(user.l_hand, /obj/item/ammo_casing/arrow) && uses >= 1)
		CURRENT = user.l_hand
	if (CURRENT)
		if (istype(CURRENT, /obj/item/ammo_casing/arrow))
			user << "You dip the arrow into the noxious slurry."
			CURRENT.name = "odd arrow"
			CURRENT.icon_state = "arrowp"
			CURRENT.projectile_type = /obj/item/projectile/arrow/arrow/vial
			CURRENT.damtype = HALLOSS
			CURRENT.BB = new/obj/item/projectile/arrow/arrow/vial/poisonous(CURRENT)
			CURRENT.contents = list(CURRENT.BB)
			uses = (uses - 1)
		else if (istype(CURRENT, /obj/item/ammo_casing/bolt))
			user << "You dip the bolt into the noxious slurry."
			CURRENT.name = "odd bolt"
			CURRENT.icon_state = "boltp"
			CURRENT.projectile_type = /obj/item/projectile/arrow/bolt/vial
			CURRENT.damtype = HALLOSS
			CURRENT.BB = new/obj/item/projectile/arrow/bolt/vial/poisonous(CURRENT)
			CURRENT.contents = list(CURRENT.BB)
			uses = (uses - 1)
		return
	else
		return