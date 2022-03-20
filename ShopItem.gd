extends Button

export(NodePath) var Button_label
export(NodePath) var Price_label

export(NodePath) onready var player

export(float) var price = 1

func UpdateUI(labeltext, level):
	get_node(Button_label).set_text(labeltext + str(level))
	price = int(price * pow(1.05, level))
	get_node(Price_label).set_text(str(price))

func _pressed():
	if get_node(player).stats.coins >= price:
		get_node(player).stats.coins -= price
		BoughtItem()

func BoughtItem():
	pass
