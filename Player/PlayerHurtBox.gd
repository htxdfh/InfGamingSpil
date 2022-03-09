extends Area2D

var invincible = false setget set_invisible

onready var timer = $InvincibilityTimer

signal invincibility_started
signal invincibility_ended

func set_invisible(value):
	invincible = value
	if invincible == true:
		print("hello")
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_PlayerHurtBox_invincibility_ended():
	monitoring = true


func _on_PlayerHurtBox_invincibility_started():
	set_deferred("monitoring", false)


func _on_InvincibilityTimer_timeout():
	self.invincible = false
