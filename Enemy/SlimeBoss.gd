extends "res://Enemy/Mob.gd"

onready var sprite = $SlimeSprite
onready var jump_timer = $JumpTimer
onready var slime_ball_timer = $SlimeBallTimer
onready var fall_timer = $FallTimer
onready var slime_stats = $Stats
onready var danger_zone = $DangerZone
onready var hit_box = $HitBox

var slime = preload("res://Enemy/SlimeBall.tscn")

const JUMP_SPEED = 100

var jump_target = Vector2(90, -300)


enum {
	HAPPY
	MAD
}

var state = HAPPY

var can_jump = false
var can_fall = false

var zone_hold_still_position = null

func _ready():
	slime_ball_timer.start()

func _physics_process(delta):
	match state:
		HAPPY:
			if slime_stats.health < (slime_stats.max_health * 0.5):
				jump_timer.start(1)
				state = MAD
		MAD:
			jump(delta)
			fall(delta)
			print(can_jump)

func shoot():
	if get_parent().get_node("Player") != null:
		var anger_level: float = float(slime_stats.max_health) / float(slime_stats.health)
		if anger_level > 1.5:
			anger_level = 1.5
		var slimeball_speed = 150 * anger_level
		var p = slime.instance()
		p.show_behind_parent = false
		var direction = global_position.direction_to(get_parent().get_node("Player").position)
		p.shoot(position + Vector2(0,6), direction * slimeball_speed)
		get_parent().add_child(p)

func jump(delta):
	if can_jump == true:
		global_position = global_position.move_toward(jump_target, 3)
		if global_position.distance_to(jump_target) < 10:
			print("no way")
			dangerzone()
			can_jump = false

func fall(delta):
	if can_fall == true:
		global_position = global_position.move_toward(danger_zone.global_position, 4)
		danger_zone.global_position = zone_hold_still_position
		if global_position.distance_to(danger_zone.global_position) < 2:
			print("yes way")
			hit_box.monitoring = true
			hit_box.monitorable = true
			danger_zone.visible = false
			can_fall = false
			jump_timer.start(5)
			slime_ball_timer.start()

func dangerzone():
	if get_parent().get_node("Player") != null:
		danger_zone.global_position = get_parent().get_node("Player").position
		if danger_zone.global_position.x < 68:
			danger_zone.global_position.x = 68
		if danger_zone.global_position.x > 108:
			danger_zone.global_position.x = 108
		if danger_zone.global_position.y < 80:
			danger_zone.global_position.y = 80
		if danger_zone.global_position.y > 224:
			danger_zone.global_position.y = 224
			
		zone_hold_still_position = danger_zone.global_position
		danger_zone.visible = true
		fall_timer.start()

func start_jump():
	slime_ball_timer.stop()
	hit_box.monitoring = false
	hit_box.monitorable = false
	can_jump = true
	jump_timer.stop()
	
	
func _on_SlimeBallTimer_timeout():
	shoot()


func _on_JumpTimer_timeout():
	start_jump()


func _on_FallTimer_timeout():
	can_fall = true
	fall_timer.stop()
