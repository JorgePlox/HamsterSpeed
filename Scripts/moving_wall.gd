extends RigidBody2D
class_name  MovingWall
@export var movement_distance: int = 50
@export var movement_speed: int = 20
@export var horizontal: bool = false
var pos_velocity = Vector2(0,0)
var neg_velocity = Vector2(0,0)
var max_position = Vector2(0,0)
var min_position = Vector2(0,0)
var apply_velocity = Vector2(0,0)

func _ready():
	if horizontal:
		pos_velocity = Vector2(movement_speed, 0)
		neg_velocity =  Vector2(-movement_speed, 0)
		max_position = Vector2(movement_distance, 0)
		min_position = Vector2(-movement_distance, 0)
	else:
		pos_velocity = Vector2(0, movement_speed)
		neg_velocity = Vector2(0, -movement_speed)
		max_position = Vector2(0, movement_distance)
		min_position = Vector2(0, -movement_distance)
	apply_velocity = pos_velocity

func _physics_process(_delta):
	move_wall()
	self.position = Vector2(int(round(self.position.x)), int(round(self.position.y)))
	

func move_wall():
	if position > max_position:
		position = max_position
		apply_velocity = neg_velocity
	elif position < min_position:
		position = min_position
		apply_velocity = pos_velocity
	
	self.linear_velocity = apply_velocity


