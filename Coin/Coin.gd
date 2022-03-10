extends RigidBody2D

const FRICTION = 100

var velocity


func Spawn(pos, vel):
	position = pos
	velocity = vel
	apply_central_impulse(velocity)
