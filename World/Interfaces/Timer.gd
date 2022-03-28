extends Timer

func _ready():
	wait_time = Global.timer_duration


func _on_Timer_timeout():
	get_tree().get_current_scene().player.stats.health = 0
