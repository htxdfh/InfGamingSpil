extends KinematicBody2D

# 
const ACCELERATION = 1200
const MAX_SPEED = 180
const FRICTION = 1200
const PROJECTILE_SPEED = 200
#
var velocity = Vector2.ZERO
var projectile = preload("res://Player/Projectile.tscn")
var shoot_ready = true

onready var stats = $PlayerStats
onready var hurtbox = $PlayerHurtBox
onready var flash = $AnimationPlayer
onready var shoot_timer = $ProjectileCooldown
onready var timer = $PlayerHurtBox/InvincibilityTimer
onready var healthBar = $HealthBarSmall

var invincible = false

func _ready():
	stats.connect("no_health", self, "queue_free")
	flash.play("FlashEnd")
	healthBar.UpdateHealthBar(stats.health, stats.max_health)

func _physics_process(delta):
	MovePlayer(delta)
	Shoot()
	AttractCoins(delta)
	
func AttractCoins(delta):
	for coin in get_tree().get_nodes_in_group("Coin"):
		var dirVec = (position - coin.position)
		var dist = position.distance_to(coin.position)
		coin.apply_central_impulse(dirVec.normalized() * 20000/dist * delta )
	

func Shoot():
	var shoot_vector = Vector2.ZERO
	shoot_vector.x = Input.get_action_strength("shoot_right") - Input.get_action_strength("shoot_left")
	shoot_vector.y = Input.get_action_strength("shoot_down") - Input.get_action_strength("shoot_up")
	
	shoot_vector = shoot_vector.normalized() * PROJECTILE_SPEED
	
	if shoot_vector != Vector2.ZERO and shoot_ready == true:
		shoot_ready = false
		shoot_timer.start()
		if shoot_vector.y <= 0:
			var p = projectile.instance()
			p.show_behind_parent = true
			p.shoot(position + Vector2(0,6), shoot_vector )
			get_parent().add_child(p)
		else:
			var p = projectile.instance()
			p.show_behind_parent = false
			p.shoot(position + Vector2(0,6), shoot_vector )
			get_parent().add_child(p)
		

func MovePlayer(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)

func _on_PlayerHurtBox_area_entered(_area):
	if !invincible:
		invincible = true
		timer.start(1)
		Invincibility_started()
		stats.health -= 1
		Global.player_health = stats.health
		healthBar.UpdateHealthBar(stats.health, stats.max_health)

func Invincibility_ended():
	flash.play("FlashEnd")
	hurtbox.set_deferred("monitoring", true)

func Invincibility_started():
	flash.play("FlashStart")
	hurtbox.set_deferred("monitoring", false)

func _on_PlayerPickupBox_body_entered(body):
	stats.coins += 1
	body.queue_free()
	Global.sounds_coins.shuffle()
	Global.PlaySound(body.position, Global.sounds_coins.front(), -20)


func _on_Projectile_cooldown_timeout():
	shoot_ready = true
	print("hello")



func _on_InvincibilityTimer_timeout():
	invincible = false
	Invincibility_ended()
