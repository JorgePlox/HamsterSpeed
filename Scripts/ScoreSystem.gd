extends Node

var current_scene = null

var HIGHSCORE = 0

var PLAYERSCORE: int = 0;
var CURRENT_LIVES: int = 2;

var lives: int = 2

func score_finish_level(time_left):
	var time_to_score = int(time_left * 10)
	PLAYERSCORE += time_to_score

func add_score(score):
	PLAYERSCORE += score

func reset_lives():
	PLAYERSCORE = 0
	CURRENT_LIVES = lives

func lost_live():
	CURRENT_LIVES -= 1

func add_live():
	CURRENT_LIVES += 1


#Save Data
const path = "res://savegame.save"

func save_high_Score(score:int):
	if score > HIGHSCORE:
		HIGHSCORE = score
		save(score)

func save(score:int):
	var content = score
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(str(content))
	file = null

func load_game():
	var file = FileAccess.open(path,FileAccess.READ)
	var content = file.get_as_text()
	HIGHSCORE = int(content)
	print(HIGHSCORE)
	return content

func _ready():
	load_game()
