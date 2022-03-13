extends Node

var max_health = Global.player_max_health setget set_max_health

var health = Global.player_health setget set_health

var coins = 0 setget set_coins

signal no_health
signal health_changed(value)
signal max_health_changed(value)

signal coins_changed(value)

func set_max_health(value):
	max_health = value
	Global.player_max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed")

func set_health(value):
	health = value
	Global.player_health = value
	print(Global.player_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_coins(value):
	coins = value
	Global.player_coins = value
	emit_signal("coins_changed", Global.player_coins)
	print("Set Coins called")

func _ready():
	max_health = Global.player_max_health
	health = Global.player_health
	coins = Global.player_coins
