extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible_characters(7)
	timer.wait_time = Global.timer_duration

func _physics_process(_delta):
	var minutes = floor(timer.time_left / 60)
	var seconds = timer.time_left - minutes * 60
	set_text(str(minutes) + ":" + str(seconds))
	Global.timer_duration = timer.time_left
	if minutes == 0 and seconds == 0:
		visible = false
	else:
		visible = true
