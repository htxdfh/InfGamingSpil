extends Node

var timer_duration = 180

var player_max_health = 3

var player_health = 3

var player_coins = 0

var level_count = 0

var audioObjectScene = preload("res://AudioObject.tscn")

var volumeMul = 1

var player_damage_lvl = 0

var player_speed_lvl = 0

var player_fire_rate_lvl = 0

func DiffMultiplier():
	return pow(1.1, level_count)

var sounds_coins = []

#Funktioner til beregning af shop opgradering
func GetFireRate():
	return lerp(0, 0.1, pow(0.9, player_fire_rate_lvl))
	
func GetMaxSpeed():
	return (1 - pow(0.9,player_speed_lvl))*200 + 180

func GetDamage():
	return pow(1.2, player_damage_lvl)

#Spiller en lyd
func PlaySound(pos, audiostream, volume, pitch = 1):
	var aosInst = audioObjectScene.instance()
	aosInst.position = pos
	aosInst.volume_db = volume * volumeMul
	aosInst.pitch_scale = pitch
	get_parent().add_child(aosInst)
	aosInst.PlaySound(audiostream)

#indlæser lydfiler til mønter
func _ready():
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (1).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (2).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (3).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (4).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (5).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (6).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (7).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (8).wav"))
	
	
