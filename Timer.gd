extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible_characters(7)

func _physics_process(delta):
	
	var minutes = floor(timer.time_left / 60)
	var seconds = timer.time_left - minutes * 60
	set_text(str(minutes) + ":" + str(seconds))
