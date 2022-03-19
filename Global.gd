extends Node

var timer_duration = 180

var player_max_health = 3

var player_health = 3

var player_coins = 0

var level_count = 0

var audioObjectScene = preload("res://AudioObject.tscn")

var volumeMul = 1

func DiffMultiplier():
	return pow(1.1, level_count)

var sounds_coins = []

func PlaySound(pos, audiostream, volume, pitch = 1):
	var aosInst = audioObjectScene.instance()
	aosInst.position = pos
	aosInst.volume_db = volume * volumeMul
	aosInst.pitch_scale = pitch
	get_parent().add_child(aosInst)
	aosInst.PlaySound(audiostream)

func _ready():
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (1).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (2).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (3).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (4).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (5).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (6).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (7).wav"))
	sounds_coins.append(preload("res://Coin/Audio/coin_pickup (8).wav"))
	
	
