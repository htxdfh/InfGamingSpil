extends Node

var timer_duration = 180

var player_max_health = 3

var player_health = 3

var player_coins = 0

var level_count = 0

func DiffMultiplier():
	return pow(1.1, level_count)

var sounds_coins = []
var sounds_hit_enemy = []

func _ready():
	sounds_coins.append(preload("res://Coin/Audio/pickup1.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup2.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup3.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup4.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup5.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup6.wav"))
	sounds_coins.append(preload("res://Coin/Audio/pickup7.wav"))
	
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_02.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_03.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_04.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_05.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_06.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_07.wav"))
	sounds_hit_enemy.append(preload("res://Enemy/Audio/HitSound/bullet_impact_body_thump_08.wav"))
	
