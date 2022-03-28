extends "res://Enemy/WalkingMob.gd"

var arrow = preload("res://Enemy/Arrow.tscn")

onready var raycast2d = $RayCast2D
var canMove

var lastShotTime = 0

func Move(delta):
	if canMove:
		.Move(delta)

func Shoot(playerPos):
	if OS.get_unix_time() - lastShotTime > 1:
		lastShotTime = OS.get_unix_time()
		var p = arrow.instance()
		p.show_behind_parent = false
		p.shoot(position + Vector2(0,6), global_position.direction_to(playerPos) * 100)
		get_parent().add_child(p)

func get_target_path(target_pos):
	#Får en lige linje mellem fjenden og spilleren
	var space_state = get_world_2d().direct_space_state
	var col = space_state.intersect_ray(global_position, target_pos, [self])
	#Hvis der noget mellem spilleren og fjenden så bevæg sig som normal
	if col:
		canMove = true
	else: #ellers stå stille og skyd
		canMove = false
		Shoot(target_pos)
		
	.get_target_path(target_pos)
	
