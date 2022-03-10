extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 50
const FRICTION = 500

var coin = preload("res://Coin/Coin.tscn")
onready var stats = $Stats

var velocity = Vector2.ZERO
var path = []
var threshold = 16
var nav = null
var is_navigable = true
var nav_counter = 0
var direction = Vector2.ZERO

var lastVel = Vector2(0, 0)

func _ready():
	stats.connect("no_health", self, "OnDeath")
	yield(owner, "ready")
	nav = owner.nav

func OnDeath():
	stats.disconnect("no_health", self, "OnDeath")
	queue_free()
	
	var coinInst = coin.instance()
	coinInst.Spawn(position, lastVel)
	get_parent().add_child(coinInst)

func _physics_process(delta):
	if path.size() > 0:
		if global_position.distance_to(path[0]) < threshold:
			path.remove(0)
		else:
			direction = global_position.direction_to(path[0])
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	print(velocity)
	
func get_target_path(target_pos):
	var destination = global_position + (target_pos - global_position)
	path = nav.get_simple_path(global_position, destination , false)
	print(destination)
	
	

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	print(stats.health)
	lastVel = area.get_owner().velocity
