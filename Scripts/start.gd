extends Node2D

@onready var start_position = $SpawnPosition

func get_spawn_position():
	return start_position.global_position
