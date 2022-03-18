extends KinematicBody2D

const ACCELERATION = 1000
const MAX_SPEED = 40
const FRICTION = 500

var coin = preload("res://Coin/Coin.tscn")
onready var stats = $Stats
onready var healthBar = $HealthBarSmall

var velocity = Vector2.ZERO
var path = []
var threshold = 16
var nav = null
var is_navigable = true
var nav_counter = 0
var direction = Vector2.ZERO

var lastVel = Vector2(0, 0)

const minCoins = 1
const maxCoins = 10

func _ready():
	randomize()
	stats.coins = randi()%maxCoins + minCoins
	stats.connect("no_health", self, "OnDeath")
	yield(owner, "ready")
	nav = owner.nav
	healthBar.UpdateHealthBar(stats.health, stats.max_health)

func OnDeath():
	stats.disconnect("no_health", self, "OnDeath")
	queue_free()
	
	for i in stats.coins:
		var coinInst = coin.instance()
		coinInst.Spawn(position, lastVel)
		get_parent().call_deferred("add_child", coinInst)

func _physics_process(delta):
	if path.size() > 0:
		if global_position.distance_to(path[0]) < threshold:
			path.remove(0)
		else:
			direction = global_position.direction_to(path[0])
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)

	
func get_target_path(target_pos):
	var destination = global_position + (target_pos - global_position)
	path = nav.get_simple_path(global_position, destination , false)

	
	

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	lastVel = area.get_owner().velocity
	healthBar.UpdateHealthBar(stats.health, stats.max_health)
