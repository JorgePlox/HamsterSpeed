extends Sprite2D

func change_num(num: int):
	if num < 0:
		num = 0
	frame = num
