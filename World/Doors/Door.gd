extends StaticBody2D

onready var sprite = $Sprite
onready var area = $ChannelBox

func _ready():
	visible = false
	area.monitorable = false
	area.monitoring = false

func open_door():
	visible = true
	area.monitorable = true
	area.monitoring = true


func _on_ChannelBox_area_entered(area):
	# get_tree().change_scene("res://Level_" + str(int(rand_range(1,3))) + ".tscn")
	get_tree().change_scene("res://Level_" + str(int(rand_range(1,5))) + ".tscn")

