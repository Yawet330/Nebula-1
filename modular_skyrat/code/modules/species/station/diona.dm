/datum/species/diona
	name = SPECIES_DIONA
	name_plural = "Dionaea"
	icobase = 	'modular_skyrat/icons/mob/human_races/species/diona/body.dmi'
	deform = 	'modular_skyrat/icons/mob/human_races/species/diona/deformed_body.dmi'
	preview_icon = 'modular_skyrat/icons/mob/human_races/species/diona/preview.dmi'
	hidden_from_codex = FALSE
	move_intents = list(/decl/move_intent/walk, /decl/move_intent/creep)
	unarmed_attacks = list(/decl/natural_attack/stomp, /decl/natural_attack/kick, /decl/natural_attack/diona)
	//primitive_form = "Nymph"
	slowdown = 2.5
	rarity_value = 3
	hud_type = /datum/hud_data/diona
	siemens_coefficient = 0.3
	show_ssd = "completely quiescent"
	strength = STR_VHIGH
	assisted_langs = list(/decl/language/nabber)
	spawns_with_stack = 0
	health_hud_intensity = 2
	hunger_factor = 3
	thirst_factor = 0.01

	min_age = 18
	max_age = 300

	description = "Commonly referred to (erroneously) as 'plant people', the Dionaea are a strange space-dwelling collective \
	species hailing from Epsilon Ursae Minoris. Each 'diona' is a cluster of numerous cat-sized organisms called nymphs; \
	there is no effective upper limit to the number that can fuse in gestalt, and reports exist	of the Epsilon Ursae \
	Minoris primary being ringed with a cloud of singing space-station-sized entities.<br/><br/>The Dionaea coexist peacefully with \
	all known species, especially the Skrell. Their communal mind makes them slow to react, and they have difficulty understanding \
	even the simplest concepts of other minds. Their alien physiology allows them survive happily off a diet of nothing but light, \
	water and other radiation."

	has_organ = list(
		BP_NUTRIENT = /obj/item/organ/internal/diona/nutrients,
		BP_STRATA =   /obj/item/organ/internal/diona/strata,
		BP_RESPONSE = /obj/item/organ/internal/diona/node,
		BP_GBLADDER = /obj/item/organ/internal/diona/bladder,
		BP_POLYP =    /obj/item/organ/internal/diona/polyp,
		BP_ANCHOR =   /obj/item/organ/internal/diona/ligament
		)

	has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/diona/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/diona/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/diona),
		BP_L_ARM =  list("path" = /obj/item/organ/external/diona/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/diona/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/diona/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/diona/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/diona/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/diona/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/diona/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/diona/foot/right)
		)

	base_auras = list(
		/obj/aura/regenerating/human/diona
		)

	inherent_verbs = list(
		/mob/living/carbon/human/proc/diona_heal_toggle
		)

	warning_low_pressure = 50
	hazard_low_pressure = -1

	cold_level_1 = 50
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 2000
	heat_level_2 = 3000
	heat_level_3 = 4000

	body_temperature = T0C + 15		//make the plant people have a bit lower body temperature, why not

	species_flags = SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_IS_PLANT | SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_SLIP
	appearance_flags = 0
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN | SPECIES_NO_LACE// | SPECIES_IS_WHITELISTED

	blood_color = "#004400"
	flesh_color = "#907e4a"

	reagent_tag = IS_DIONA
	genders = list(PLURAL)

	available_cultural_info = list(
		TAG_CULTURE =   list(CULTURE_DIONA),
		TAG_HOMEWORLD = list(HOME_SYSTEM_DIONAEA),
		TAG_FACTION =   list(FACTION_OTHER),
		TAG_RELIGION =  list(RELIGION_OTHER)
	)

/proc/spawn_diona_nymph(var/turf/target)
	if(!istype(target))
		return 0

	//This is a terrible hack and I should be ashamed.
	var/datum/seed/diona = SSplants.seeds["diona"]
	if(!diona)
		return 0

	spawn(1) // So it has time to be thrown about by the gib() proc.
		var/mob/living/carbon/alien/diona/D = new(target)
		var/datum/ghosttrap/plant/P = get_ghost_trap("living plant")
		P.request_player(D, "A diona nymph has split off from its gestalt. ")
		spawn(60)
			if(D)
				if(!D.ckey || !D.client)
					D.death()
		return 1

#define DIONA_LIMB_DEATH_COUNT 9
/datum/species/diona/handle_death_check(var/mob/living/carbon/human/H)
	var/lost_limb_count = has_limbs.len - H.organs.len
	if(lost_limb_count >= DIONA_LIMB_DEATH_COUNT)
		return TRUE
	for(var/thing in H.bad_external_organs)
		var/obj/item/organ/external/E = thing
		if(E && E.is_stump())
			lost_limb_count++
	return (lost_limb_count >= DIONA_LIMB_DEATH_COUNT)
#undef DIONA_LIMB_DEATH_COUNT

/datum/species/diona/can_understand(var/mob/other)
	var/mob/living/carbon/alien/diona/D = other
	if(istype(D))
		return 1
	return 0

/datum/species/diona/equip_survival_gear(var/mob/living/carbon/human/H)
	if(istype(H.get_equipped_item(slot_back), /obj/item/storage/backpack))
		H.equip_to_slot_or_del(new /obj/item/flashlight/flare(H.back), slot_in_backpack)
	else
		H.equip_to_slot_or_del(new /obj/item/flashlight/flare(H), slot_r_hand)

/datum/species/diona/skills_from_age(age)
	switch(age)
		if(101 to 200)	. = 8 // age bracket before this is 46 to 100 . = 8 making this +4
		if(201 to 300)	. = 8 // + 8
		else			. = ..()

// Dionaea spawned by hand or by joining will not have any
// nymphs passed to them. This should take care of that.
/datum/species/diona/handle_post_spawn(var/mob/living/carbon/human/H)
	H.gender = NEUTER
	. = ..()
	addtimer(CALLBACK(src, .proc/fill_with_nymphs, H), 0)

/datum/species/diona/proc/fill_with_nymphs(var/mob/living/carbon/human/H)

	if(!H || H.species.name != name) return

	var/nymph_count = 0
	for(var/mob/living/carbon/alien/diona/nymph in H)
		nymph_count++
		if(nymph_count >= 3) return

	while(nymph_count < 3)
		new /mob/living/carbon/alien/diona/sterile(H)
		nymph_count++

/datum/species/diona/handle_death(var/mob/living/carbon/human/H)

	if(H.isSynthetic())
		var/mob/living/carbon/alien/diona/S = new(get_turf(H))

		if(H.mind)
			H.mind.transfer_to(S)
		H.visible_message("<span class='danger'>\The [H] collapses into parts, revealing a solitary diona nymph at the core.</span>")
		return
	else
		split_into_nymphs(H)

/datum/species/diona/get_blood_name()
	return "sap"

/datum/species/diona/handle_environment_special(var/mob/living/carbon/human/H)
	if(H.InStasis() || H.stat == DEAD)
		return

	if(H.nutrition < 10)
		H.take_overall_damage(2,0)

	if(H.hydration < 550 && H.loc)
		var/is_in_water = FALSE
		if(H.loc.is_flooded(lying_mob = TRUE))
			is_in_water = TRUE
		else
			for(var/obj/structure/hygiene/shower/shower in H.loc)
				if(shower.on)
					is_in_water = TRUE
					break
		if(is_in_water)
			H.adjust_hydration(100)

/proc/split_into_nymphs(var/mob/living/carbon/human/donor)

	if(!donor || donor.species.name != SPECIES_DIONA)
		return

	// Run through our nymphs and spit them out
	var/list/available_nymphs = list()
	for(var/mob/living/carbon/alien/diona/nymph in donor.contents)
		nymph.dropInto(donor.loc)
		transfer_languages(donor, nymph, (WHITELISTED|RESTRICTED))
		nymph.set_dir(pick(NORTH, SOUTH, EAST, WEST))
		// Collect any available nymphs
		if(!nymph.client && nymph.stat != DEAD)
			available_nymphs += nymph

	// Make sure there's a home for the player
	if(!available_nymphs.len)
		available_nymphs += new /mob/living/carbon/alien/diona/sterile(donor.loc)

	// Link availalbe nymphs together
	var/mob/living/carbon/alien/diona/first_nymph
	var/mob/living/carbon/alien/diona/last_nymph
	for(var/mob/living/carbon/alien/diona/nymph in available_nymphs)
		if(!first_nymph)
			first_nymph = nymph
		else
			nymph.set_previous_nymph(last_nymph)
			last_nymph.set_next_nymph(nymph)
		last_nymph = nymph
	if(available_nymphs.len > 1)
		first_nymph.set_previous_nymph(last_nymph)
		last_nymph.set_next_nymph(first_nymph)

	// Transfer player over
	first_nymph.set_dir(donor.dir)
	transfer_languages(donor, first_nymph)
	if(donor.mind)
		donor.mind.transfer_to(first_nymph)
	else
		first_nymph.key = donor.key

	log_and_message_admins("has split into nymphs; player now controls [key_name_admin(first_nymph)]", donor)

	for(var/obj/item/W in donor)
		donor.drop_from_inventory(W)

	donor.visible_message("<span class='warning'>\The [donor] quivers slightly, then splits apart with a wet slithering noise.</span>")
	qdel(donor)

//This essentially makes dionaea spawned by splitting into a doubly linked
//list that, when the nymph dies, transfers the controler's mind
//to the next nymph in the list.

/mob/living/carbon/alien/diona/proc/set_next_nymph(var/mob/living/carbon/alien/diona/D)
	next_nymph = D

/mob/living/carbon/alien/diona/proc/set_previous_nymph(var/mob/living/carbon/alien/diona/D)
	previous_nymph = D
// When there are only two nymphs left in a list and one is to be removed,
// call this to null it out.
/mob/living/carbon/alien/diona/proc/null_nymphs()
	next_nymph = null
	previous_nymph = null

/mob/living/carbon/alien/diona/proc/remove_from_list()
	// Closes over the gap that's going to be made and removes references to
	// the nymph this is called for.
	var/need_links_null = 0

	if (previous_nymph)
		previous_nymph.set_next_nymph(next_nymph)
		if (previous_nymph.next_nymph == previous_nymph)
			need_links_null = 1
	if (next_nymph)
		next_nymph.set_previous_nymph(previous_nymph)
		if (next_nymph.previous_nymph == next_nymph)
			need_links_null = 1
	// This bit checks if a nymphs is the only nymph in the list
	// by seeing if it points to itself. If it is, it nulls it
	// to stop list behaviour.
	if (need_links_null)
		if (previous_nymph)
			previous_nymph.null_nymphs()
		if (next_nymph)
			next_nymph.null_nymphs()
	// Finally, remove the current nymph's references to other nymphs.
	null_nymphs()

/mob/living/carbon/alien/diona/death(gibbed)

	var/obj/structure/diona_gestalt/gestalt = loc
	if(istype(gestalt))
		gestalt.shed_atom(src, TRUE, FALSE)

	if(holding_item)
		unEquip(holding_item)
	if(hat)
		unEquip(hat)

	jump_to_next_nymph()

	remove_from_list()

	return ..(gibbed,death_msg)

/mob/living/carbon/alien/diona/Destroy()
	if (previous_nymph || next_nymph)
		remove_from_list()
	return ..()

/mob/living/carbon/alien/diona/verb/jump_to_next_nymph()
	set name = "Jump to next nymph"
	set desc = "Switch control to another nymph from your last gestalt."
	set category = "Abilities"

	if (next_nymph && next_nymph.stat != DEAD && !next_nymph.client)

		var/mob/living/carbon/alien/diona/S = next_nymph
		transfer_languages(src, S)

		if(mind)
			to_chat(src, "<span class='info'>You're now in control of [S].</span>")
			mind.transfer_to(S)
			log_and_message_admins("has transfered to another nymph; player now controls [key_name_admin(S)]", src)
	else
		to_chat(src, "<span class='info'>There are no appropriate nymphs for you to jump into.</span>")
