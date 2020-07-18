/obj/item/clothing/head/caretakerhood
	name = "holy hood"
	desc = "The hood of a shining white robe, with blue trim. Who would possess this robe and still want to hide themself away?"
	icon_state = ICON_STATE_WORLD
	icon = 'icons/clothing/head/caretaker.dmi'
	on_mob_icon = 'icons/clothing/head/caretaker.dmi'
	armor = list(
		melee = ARMOR_MELEE_KNIVES, 
		bullet = ARMOR_BALLISTIC_MINOR, 
		laser = ARMOR_LASER_SMALL,
		energy = ARMOR_ENERGY_SMALL, 
		rad = ARMOR_RAD_SHIELDED
	)
	bodytype_restricted = list(BODYTYPE_HUMANOID)
	flags_inv = HIDEEARS | BLOCKHAIR

/obj/item/clothing/suit/caretakercloak
	name = "holy cloak"
	desc = "A shining white and blue robe. For some reason, it reminds you of the holidays."
	icon_state = "caretakercloak"
	armor = list(
		melee = ARMOR_MELEE_RESISTANT, 
		bullet = ARMOR_BALLISTIC_PISTOL, 
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_RESISTANT, 
		rad = ARMOR_RAD_SHIELDED
	)

/obj/item/clothing/under/caretaker
	name = "caretaker's jumpsuit"
	desc = "A holy jumpsuit. Treat it well."
	icon_state = "caretaker"
	bodytype_restricted = list(BODYTYPE_HUMANOID)

/obj/item/clothing/shoes/dress/caretakershoes
	name = "black leather shoes"
	desc = "Dress shoes. These aren't as shiny as usual."
	inset_color = COLOR_SKY_BLUE
	shine = 30
	armor = list(
		rad = ARMOR_RAD_SHIELDED
	)