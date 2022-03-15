extends KinematicBody2D

const lifetime = 1
var velocity


func shoot(pos, dir):
	position = pos
	rotation = dir.angle()
	velocity = dir
	
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	scale = Vector2(scale.x - delta/lifetime, scale.y - delta/lifetime)
	if collision || scale.x <= 0.5:
		queue_free()


func _on_HitBox_area_entered(_area):
	queue_free()
