extends KinematicBody2D

var coin = preload("res://Coin/Coin.tscn")
onready var stats = $Stats
onready var healthBar = $HealthBarSmall

export(int) var minCoins = 1
export(int) var maxCoins = 10

export(Array, AudioStreamSample) var hitSounds
export(Array, AudioStreamSample) var deathSounds

var lastVel = Vector2(0, 0)

func _ready():
	randomize()
	stats.coins = randi()%int(maxCoins*Global.DiffMultiplier()) + int(minCoins*Global.DiffMultiplier())
	stats.connect("no_health", self, "OnDeath")
	healthBar.UpdateHealthBar(stats.health, stats.max_health)

func OnDeath():
	stats.disconnect("no_health", self, "OnDeath")
	queue_free()
	
	deathSounds.shuffle()
	Global.PlaySound(position, deathSounds.front(), -15)
	
	for i in stats.coins:
		var coinInst = coin.instance()
		coinInst.Spawn(position, lastVel)
		get_parent().call_deferred("add_child", coinInst)
		
func _on_HurtBox_area_entered(area):
	lastVel = area.get_owner().velocity
	stats.health -= 1
	healthBar.UpdateHealthBar(stats.health, stats.max_health)
	
	hitSounds.shuffle()
	Global.PlaySound(position, hitSounds.front(), -20)
	
