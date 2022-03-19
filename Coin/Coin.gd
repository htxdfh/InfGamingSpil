extends RigidBody2D

onready var audio = $AudioStreamPlayer2D

const FRICTION = 100

var velocity

func Spawn(pos, vel):
	position = pos
	velocity = vel.rotated(rand_range(-PI/4, PI/4))
	apply_central_impulse(velocity)
	
func PickUp():	
	Global.sounds_coins.shuffle()
	
	$CollisionShape2D.queue_free()
	$CoinSprite.queue_free()
	audio.stream = Global.sounds_coins.front()
	audio.play()
	yield(audio, "finished")
	queue_free()
	
