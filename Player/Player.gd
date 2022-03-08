extends KinematicBody2D

# 
const ACCELERATION = 800
const MAX_SPEED = 180
const FRICTION = 1200
const PROJECTILE_SPEED = 200
#
var velocity = Vector2.ZERO
var projectile = preload("res://Player/Projectile.tscn")


func _physics_process(delta):
	MovePlayer(delta)
	Shoot()

func Shoot():
	var shoot_vector = Vector2.ZERO
	shoot_vector.x = Input.get_action_strength("shoot_right") - Input.get_action_strength("shoot_left")
	shoot_vector.y = Input.get_action_strength("shoot_down") - Input.get_action_strength("shoot_up")
	
	shoot_vector = shoot_vector.normalized() * PROJECTILE_SPEED
	
	if shoot_vector != Vector2.ZERO:
		var p = projectile.instance()
		p.shoot(position, shoot_vector + velocity)
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
