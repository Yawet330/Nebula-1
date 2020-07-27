GLOBAL_DATUM_INIT(commandos, /datum/antagonist/deathsquad/mercenary, new)

/datum/antagonist/deathsquad/mercenary
	id = MODE_COMMANDO
	landmark_id = "Syndicate-Commando"
	role_text = "Syndicate Commando"
	role_text_plural = "Commandos"
	welcome_text = "You are in the employ of a criminal syndicate hostile to corporate interests."
	id_type = /obj/item/card/id/centcom/ERT
	flags = ANTAG_RANDOM_EXCEPTED

	hard_cap = 4
	hard_cap_round = 8
	initial_spawn_req = 4
	initial_spawn_target = 6

/datum/antagonist/deathsquad/mercenary/equip(var/mob/living/carbon/human/player)

	player.equip_to_slot_or_del(new /obj/item/clothing/under/syndicate(player), slot_w_uniform_str)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots/swat(player), slot_shoes_str)
	player.equip_to_slot_or_del(new /obj/item/clothing/glasses/thermal(player), slot_glasses_str)
	player.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/syndicate(player), slot_wear_mask_str)
	player.equip_to_slot_or_del(new /obj/item/storage/box(player), slot_in_backpack_str)
	player.equip_to_slot_or_del(new /obj/item/ammo_magazine/box/pistol(player), slot_in_backpack_str)
	player.equip_to_slot_or_del(new /obj/item/rig/merc(player), slot_back_str)
	player.equip_to_slot_or_del(new /obj/item/gun/energy/laser(player), slot_r_hand_str)
	player.equip_to_slot_or_del(new /obj/item/energy_blade/sword(player), slot_l_hand_str)

	create_id("Commando", player)
	create_radio(SYND_FREQ, player)
	return 1
