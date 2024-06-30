extends Control

@export var main_menu_scene: PackedScene = null
@export var continue_scene: PackedScene = null

@onready var continue_button = $ContinueSelector/ContinueButton
@onready var exit_button = $ContinueSelector/ExitButton
@onready var retry_button = $ContinueSelector/RetryButton

@onready var score_number_1 = $ContinueSelector/Score/NumberSprite
@onready var score_number_2 = $ContinueSelector/Score/NumberSprite2
@onready var score_number_3 = $ContinueSelector/Score/NumberSprite3
@onready var score_number_4 = $ContinueSelector/Score/NumberSprite4
@onready var score_number_5 = $ContinueSelector/Score/NumberSprite5

@onready var high_score_number_1 = $ContinueSelector/HighScore/NumberSprite
@onready var high_score_number_2 = $ContinueSelector/HighScore/NumberSprite2
@onready var high_score_number_3 = $ContinueSelector/HighScore/NumberSprite3
@onready var high_score_number_4 = $ContinueSelector/HighScore/NumberSprite4
@onready var high_score_number_5 = $ContinueSelector/HighScore/NumberSprite5


func _ready():
	update_score(ScoreSystem.PLAYERSCORE)
	ScoreSystem.save_high_Score(ScoreSystem.PLAYERSCORE)
	update_high_score(ScoreSystem.HIGHSCORE)
	if ScoreSystem.CURRENT_LIVES < 0:
		AudioPlayer.play_game_over_song()
		exit_button.visible = true
		retry_button.visible = true
		continue_button.visible = false
		retry_button.grab_focus()
	else:
		exit_button.visible = false
		retry_button.visible = false
		continue_button.visible = true
		continue_button.grab_focus()
	ScoreSystem.reset_lives()

func _on_exit_button_pressed():
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_continue_button_pressed():
	get_tree().change_scene_to_packed(main_menu_scene)

func update_score(number: int):
	var n = str(number)
	var len_n = len(n)
	if len_n == 1:
		n = "0000" + n
	elif len_n == 2:
		n = "000" + n
	elif len_n == 3:
		n = "00" + n
	elif len_n == 4:
		n = "0" + n
	elif len_n >= 6:
		n = "99999"
	score_number_1.change_num(int(n[0]))
	score_number_2.change_num(int(n[1]))
	score_number_3.change_num(int(n[2]))
	score_number_4.change_num(int(n[3]))
	score_number_5.change_num(int(n[4]))

func update_high_score(number: int):
	var n = str(number)
	var len_n = len(n)
	if len_n == 1:
		n = "0000" + n
	elif len_n == 2:
		n = "000" + n
	elif len_n == 3:
		n = "00" + n
	elif len_n == 4:
		n = "0" + n
	elif len_n >= 5:
		n = "99999"
	high_score_number_1.change_num(int(n[0]))
	high_score_number_2.change_num(int(n[1]))
	high_score_number_3.change_num(int(n[2]))
	high_score_number_4.change_num(int(n[3]))
	high_score_number_5.change_num(int(n[4]))


func _on_retry_button_pressed():
	if ScoreSystem.current_scene == null:
		get_tree().change_scene_to_packed(main_menu_scene)
	else:
		get_tree().change_scene_to_file(ScoreSystem.current_scene)

