extends "res://ShopItem.gd"

func _ready():
	UpdateUI("Speed: ", Global.player_speed_lvl)

func BoughtItem():
	Global.player_speed_lvl += 1
	UpdateUI("Speed: ", Global.player_speed_lvl)
	

