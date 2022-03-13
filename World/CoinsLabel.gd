extends Label

export(NodePath) onready var player

func _ready():
	set_text(str(Global.player_coins))
	get_node(player).stats.connect("coins_changed", self, "UpdateValue")
	
func UpdateValue(value):
	print("Updated coins!")
	set_text(str(value))
