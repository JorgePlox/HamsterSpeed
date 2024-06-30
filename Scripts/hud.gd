extends Control

@onready var number_1 = $TimerV1/NumberSprite
@onready var number_2 = $TimerV1/NumberSprite2
@onready var number_3 = $TimerV1/NumberSprite4

@onready var score_number_1 = $Score/NumberSprite
@onready var score_number_2 = $Score/NumberSprite2
@onready var score_number_3 = $Score/NumberSprite3
@onready var score_number_4 = $Score/NumberSprite4
@onready var score_number_5 = $Score/NumberSprite5

@onready var lives_number_1 = $Lives/NumberSprite

func update_timer(number: float):
	var n = str(number).pad_decimals(1)
	if len(n) == 3:
		n = "0" + n
	number_1.change_num(int(n[0]))
	number_2.change_num(int(n[1]))
	number_3.change_num(int(n[3]))

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

func update_lives(number: int):
	lives_number_1.change_num(number)
