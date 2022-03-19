extends KinematicBody2D

var coin = preload("res://Coin/Coin.tscn")
onready var stats = $Stats
onready var healthBar = $HealthBarSmall

var lastVel = Vector2(0, 0)

const minCoins = 1
const maxCoins = 10

func _ready():
	randomize()
	stats.coins = randi()%maxCoins + minCoins
	stats.connect("no_health", self, "OnDeath")
	yield(owner, "ready")
	healthBar.UpdateHealthBar(stats.health, stats.max_health)

func OnDeath():
	stats.disconnect("no_health", self, "OnDeath")
	queue_free()
	
	for i in stats.coins:
		var coinInst = coin.instance()
		coinInst.Spawn(position, lastVel)
		get_parent().call_deferred("add_child", coinInst)


func _on_HurtBox_area_entered(area):
	stats.health -= 1
	lastVel = area.get_owner().velocity
	healthBar.UpdateHealthBar(stats.health, stats.max_health)
