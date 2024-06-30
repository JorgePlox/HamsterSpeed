extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level = false

@onready var player = $Player
@onready var start = $Start
@onready var exit = $Exit
@onready var hud = $UILayer/HUD

@export var level_time = 5
var timer_node = null
@onready var time_left = 0
var pause_timer: bool = true

var score_menu = "res://Scenes/Menus/game_over_menu.tscn"

func _ready():
	ScoreSystem.current_scene = get_tree().current_scene.scene_file_path
	AudioPlayer.play_ingame_song()
	
	player.body_shape_exited.connect(_on_player_body_exited)
	player.player_ready.connect(_on_player_ready)
	reset_player()
	
	exit.body_entered.connect(_on_exit_body_entered)
	create_level_timer()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func reset_player():
	pause_timer = true
	player.linear_velocity = Vector2.ZERO
	player.global_position = start.get_spawn_position()
	time_left = level_time
	hud.update_timer(time_left)
	hud.update_score(ScoreSystem.PLAYERSCORE)
	hud.update_lives(ScoreSystem.CURRENT_LIVES)
	player.player_revive()

func _on_player_ready():
	pause_timer = false

func _on_player_body_exited(_body, bodyExited, _var1, _var2):
	if bodyExited == $TileMap:
		if !pause_timer:
			player.player_fall()
			pause_timer = true
			await get_tree().create_timer(1).timeout
			player_death()
			reset_player()

func _on_exit_body_entered(body):
	if body is Player:
		if (is_final_level || next_level != null):
			pause_timer = true
			exit.animate()
			player.player_level_finished();
			player.active = false
			## Score System START
			ScoreSystem.score_finish_level(time_left)
			hud.update_score(ScoreSystem.PLAYERSCORE)
			## Score System END
			await get_tree().create_timer(1.5).timeout
			if !is_final_level:
				get_tree().change_scene_to_packed(next_level)
			else:
				get_tree().change_scene_to_file(score_menu)

func create_level_timer():
	time_left = level_time
	hud.update_timer(time_left)
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 0.1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()

func _on_level_timer_timeout():
	if !pause_timer:
		time_left -= 0.1
		if time_left < 0:
			timeout()
			time_left = 0
		hud.update_timer(time_left)
		hud.update_score(ScoreSystem.PLAYERSCORE)

func timeout():
	player.player_timeout()
	pause_timer = true
	await get_tree().create_timer(0.2).timeout
	player_death()
	reset_player()

func player_death():
	ScoreSystem.lost_live()
	if ScoreSystem.CURRENT_LIVES < 0:
		get_tree().change_scene_to_file(score_menu)

