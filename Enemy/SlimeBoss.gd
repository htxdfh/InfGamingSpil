extends "res://Enemy/Mob.gd"

onready var sprite = $SlimeSprite
onready var timer = $JumpTimer

func _ready():
	sprite.modulate.a = 200

func _physics_process(delta):
	pass


func _on_SlimeBallTimer_timeout():
	pass # Replace with function body.


func _on_JumpTimer_timeout():
	pass # Replace with function body.
