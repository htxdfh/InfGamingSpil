extends Node2D

export(NodePath) var HealthFull
export(NodePath) var HealthLabel

func UpdateHealthBar(HP, maxHP):
	get_node(HealthLabel).set_text(str(HP))
	get_node(HealthFull).rect_size.x = lerp(4, 29, float(HP) / float(maxHP))
