extends Label

export(NodePath) onready var player

func _ready():
	set_text(str(Global.player_coins) + " Coins")
	get_node(player).stats.connect("coins_changed", self, "UpdateValue")
	
func UpdateValue(value):
	set_text(str(value) + " Coins")
