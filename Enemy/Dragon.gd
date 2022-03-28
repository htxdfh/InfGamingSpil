extends "res://Enemy/WalkingMob.gd"

var arrow = preload("res://Enemy/FireBall.tscn")

export(Array, AudioStreamSample) var attackSounds

onready var raycast2d = $RayCast2D
var canMove

var lastShotTime = 0

func GetNav():
	nav = owner.navAir

func Move(delta):
	if canMove:
		.Move(delta)

func Shoot(playerPos):
	# Betingelse der checker om der er gået 1 sekund fra sidste skud
	if OS.get_unix_time() - lastShotTime > 1:
		lastShotTime = OS.get_unix_time()
		var p = arrow.instance()
		p.show_behind_parent = false
		p.shoot(position + Vector2(0,6), global_position.direction_to(playerPos) * 100)
		get_parent().add_child(p)
		
		attackSounds.shuffle()
		Global.PlaySound(position, attackSounds.front(), -15, 0.3)

func get_target_path(target_pos):
	#Hvis tæt på spilleren så stå stille og skyd
	if global_position.distance_to(target_pos) > 80:
		canMove = true
	else:
		canMove = false
		Shoot(target_pos)
		
	.get_target_path(target_pos)
	
