extends Area2D

export(float) var damage

func _ready():
	if Global.has_damage_upgrade == true:
		damage = 2
