extends KinematicBody2D


var coin = preload("res://Coin/Coin.tscn")
onready var stats = $Stats

var lastVel = Vector2(0, 0)

func _ready():
	stats.connect("no_health", self, "OnDeath")

func OnDeath():
	queue_free()
	
	var coinInst = coin.instance()
	coinInst.Spawn(position, lastVel)
	get_parent().add_child(coinInst)
	
	
	

func _on_HurtBox_area_entered(area):
	stats.health -= 1
	print(stats.health)
	lastVel = area.get_owner().velocity
