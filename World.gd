extends Node2D

onready var player = $YSort/Player
onready var nav = $Navigation2D
onready var game_over_screen = $GameOver
onready var timer = $TimerText/Timer


func _on_NavTimer_timeout():
	if is_instance_valid(player) == true:
		get_tree().call_group("Enemy", "get_target_path", player.global_position)
	else:
		timer.paused = true
		game_over_screen.visible = true

func _physics_process(delta):
	var enemy_count = int(len(get_tree().get_nodes_in_group("Enemy")))
	if enemy_count == 0:
		get_tree().call_group("Door", "open_door", null)

func _on_Button_pressed():
	Global.player_health = 3
	Global.timer_duration = 180
	Global.level_count = 0
	timer.start(Global.timer_duration)
	get_tree().change_scene("res://Level_1.tscn")
