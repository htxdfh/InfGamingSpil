extends Button

onready var Button_label = $Label

export(NodePath) onready var player

export(float) var price = 1

func _ready():
	if Global.has_damage_upgrade == true:
		Button_label.set_text("Bought!")

func _pressed():
	if get_node(player).stats.coins >= price:
		get_node(player).stats.coins -= price
		Global.has_damage_upgrade = true
		Button_label.set_text("Bought!")

