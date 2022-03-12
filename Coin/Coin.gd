extends RigidBody2D

const FRICTION = 100

var velocity


func Spawn(pos, vel):
	position = pos
	velocity = vel.rotated(rand_range(-PI/4, PI/4))
	apply_central_impulse(velocity)
	
