extends KinematicBody2D

# 
const ACCELERATION = 1200
const FRICTION = 1200
const PROJECTILE_SPEED = 200
var MAXSPEED = 180
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

var fire_rate = 0.1

var invincible = false

func _ready():
	# Kører metoden queue_free() når spilleren rammer 0 liv
	stats.connect("no_health", self, "queue_free")
	
	flash.play("FlashEnd")
	healthBar.UpdateHealthBar(stats.health, stats.max_health)
	MAXSPEED = Global.GetMaxSpeed()
	fire_rate = Global.GetFireRate()
	

func _physics_process(delta):
	MovePlayer(delta)
	Shoot()
	AttractCoins(delta)


func AttractCoins(delta):
	for coin in get_tree().get_nodes_in_group("Coin"):
		var dirVec = (position - coin.position).normalized()
		var dist = position.distance_to(coin.position)
		coin.apply_central_impulse(dirVec * 20000/dist * delta )
	

func Shoot():
	var shoot_vector = Vector2.ZERO
	shoot_vector.x = Input.get_action_strength("shoot_right") - Input.get_action_strength("shoot_left")
	shoot_vector.y = Input.get_action_strength("shoot_down") - Input.get_action_strength("shoot_up")
	
	shoot_vector = shoot_vector.normalized() * PROJECTILE_SPEED
	
	if shoot_vector != Vector2.ZERO && shoot_ready:
		#Vent indtil der kan skydes igen
		shoot_ready = false
		shoot_timer.start(fire_rate) 
		
		var p = projectile.instance()
		
		# skyder opad, så gem projektilet bag spilleren
		if shoot_vector.y <= 0:
			p.show_behind_parent = true
		else:
			p.show_behind_parent = false

		
		p.shoot(position + Vector2(0,6), shoot_vector )
		get_parent().add_child(p)
		

func MovePlayer(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)

#Bliver kaldt når en fjender rammer spilleren
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

#Bliver kaldt når en mønt rammer spilleren
func _on_PlayerPickupBox_body_entered(body):
	stats.coins += 1
	body.queue_free()
	Global.sounds_coins.shuffle()
	Global.PlaySound(body.position, Global.sounds_coins.front(), -20)


func _on_Projectile_cooldown_timeout():
	shoot_ready = true

func _on_InvincibilityTimer_timeout():
	invincible = false
	Invincibility_ended()
