extends KinematicBody2D

var velocity


func shoot(pos, dir):
	position = pos
	rotation = dir.angle()
	velocity = dir
	
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()


func _on_HitBox_area_entered(area):
	queue_free()
