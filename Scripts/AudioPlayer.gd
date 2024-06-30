extends Node

var fall = preload("res://Assets/Sound/Fall.wav")
var time_over = preload("res://Assets/Sound/TimeOver.wav")
var coin = preload("res://Assets/Sound/Coin.wav")
var finish = preload("res://Assets/Sound/Finish.wav")

@onready var musicPlayer = $MusicPlayer
var main_menu = preload("res://Assets/Sound/OST/jamster cute tonto piano chip tune.mp3")
var ingame_theme = preload("res://Assets/Sound/OST/orejas 2.mp3")
var game_over = preload("res://Assets/Sound/OST/primavera intermedio chiptune.mp3")

func play_sfx(sfx_name: String):
	
	var stream = null
	if sfx_name == "fall":
		stream = fall
	elif sfx_name == "time_over":
		stream = time_over
	elif sfx_name == "coin":
		stream = coin
	elif sfx_name == "finish":
		stream = finish
	else:
		print("Invalid SFX Name")
		return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()

func play_menu_song():
	musicPlayer.stream = main_menu
	musicPlayer.play()

func play_ingame_song():
	if musicPlayer.stream != ingame_theme:
		musicPlayer.stream = ingame_theme
		musicPlayer.play()

func play_game_over_song():
	musicPlayer.stream = game_over
	musicPlayer.play()
