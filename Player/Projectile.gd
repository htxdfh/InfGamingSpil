extends KinematicBody2D

var velocity


func shoot(pos, dir):
	position = pos
	rotation = dir.angle()
	velocity = dir
	
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		print("Hit something" + collision.collider.name)
		if collision.collider.has_method("OnHit"):
			collision.collider.OnHit()
		
		queue_free()