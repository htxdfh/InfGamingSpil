extends "res://ShopItem.gd"

func _ready():
	UpdateUI("Damage: ", Global.player_damage_lvl)

func BoughtItem():
	Global.player_damage_lvl += 1
	UpdateUI("Damage: ", Global.player_damage_lvl)
	

