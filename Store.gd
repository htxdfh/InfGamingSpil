extends Node2D

onready var timer = $InGameInterface/TimerText/Timer


func _on_Button_pressed():
	Global.player_health = 3
	Global.timer_duration = 180
	Global.level_count = 0
	timer.start(Global.timer_duration)
	get_tree().change_scene("res://Level_1.tscn")
