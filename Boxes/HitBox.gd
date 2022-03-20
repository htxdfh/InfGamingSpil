extends Area2D

export(float) var damage

func _ready():
	damage = Global.GetDamage()
