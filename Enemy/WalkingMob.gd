extends "res://Enemy/Mob.gd" 

export(float) var ACCELERATION = 1000
export(float) var MAX_SPEED = 40
export(float) var FRICTION = 500

var velocity = Vector2.ZERO
var path = []
var threshold = 16
var nav = null
var is_navigable = true
var nav_counter = 0
var direction = Vector2.ZERO

func _ready():
	yield(owner, "ready")
	GetNav()

func GetNav():
	nav = owner.nav

func _physics_process(delta):
	Move(delta)

func Move(delta):
	if path.size() > 1:
		if global_position.distance_to(path[0]) < threshold:
			path.remove(0)
		else:
			direction = global_position.direction_to(path[0])
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)

func get_target_path(target_pos):
	var destination = global_position + (target_pos - global_position)
	path = nav.get_simple_path(global_position, destination , false)
