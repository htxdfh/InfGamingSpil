extends StaticBody2D

onready var sprite = $Sprite
onready var area = $ChannelBox

var level = Global.level_count setget set_level_count

signal level_count_changed(value)

func _ready():
	visible = false
	area.monitorable = false
	area.monitoring = false

func open_door():
	visible = true
	area.monitorable = true
	area.monitoring = true


func _on_ChannelBox_area_entered(_area):
	# get_tree().change_scene("res://Level_" + str(int(rand_range(1,3))) + ".tscn")
	Global.level_count += 1
	get_tree().change_scene("res://Level_" + str(int(rand_range(1,11))) + ".tscn")


func set_level_count(value):
	level = value
	Global.level_count = value
	emit_signal("level_count_changed", Global.level_count)
