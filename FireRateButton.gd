extends "res://ShopItem.gd"

func _ready():
	UpdateUI("Fire rate: ", Global.player_fire_rate_lvl)

func BoughtItem():
	Global.player_fire_rate_lvl += 1
	UpdateUI("Fire rate: ", Global.player_fire_rate_lvl)
	

