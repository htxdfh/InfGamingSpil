extends KinematicBody2D



onready var stats = $Stats

func _ready():
	stats.connect("no_health", self, "queue_free")


func _on_HurtBox_area_entered(area):
	stats.health -= 1
	print(stats.health)
