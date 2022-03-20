extends Button

func _pressed():
	Global.player_health = 3
	Global.timer_duration = 180
	Global.level_count = 0
	get_tree().change_scene("res://Store.tscn")
