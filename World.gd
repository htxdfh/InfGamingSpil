extends Node2D

onready var player = $YSort/Player
onready var nav = $Navigation2D

func _on_NavTimer_timeout():
	get_tree().call_group("Enemy", "get_target_path", player.global_position)

func _physics_process(delta):
	var enemy_count = int(len(get_tree().get_nodes_in_group("Enemy")))
	if enemy_count == 0:
		get_tree().call_group("Door", "open_door", null)

