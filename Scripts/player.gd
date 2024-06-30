extends RigidBody2D
class_name Player

const _MINSPEED = 2
const _MAXSPEED = 10
var movement_force = 40.0
var last_position = Vector2(0,0)
@onready var anim_player = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D

var active: bool = false
signal player_ready

func _physics_process(_delta):
	last_position = self.position
	player_movement()
	self.position = Vector2(int(round(self.position.x)), int(round(self.position.y)))
	if active:
		player_animations()


func player_movement():
	if active:
		if Input.is_action_pressed("move_right"):
			apply_force(Vector2(movement_force,0))
			sprite.flip_h = true
		if Input.is_action_pressed("move_left"):
			apply_force(Vector2(-movement_force,0))
			sprite.flip_h = false
		if Input.is_action_pressed("move_up"):
			apply_force(Vector2(0, -movement_force))
		if Input.is_action_pressed("move_down"):
			apply_force(Vector2(0, movement_force))

func player_animations():
	if self.linear_velocity.length() >= _MINSPEED:
		anim_player.play("player_moving")
		if self.linear_velocity.length() <= _MAXSPEED:
			anim_player.speed_scale = self.linear_velocity.length() / _MAXSPEED
			
	if self.linear_velocity.length() < _MINSPEED:
		anim_player.play("player_idle")

func player_revive():
	z_index = 1
	anim_player.play("player_start")
	await anim_player.animation_finished
	active = true
	player_ready.emit()

func player_fall():
	AudioPlayer.play_sfx("fall")
	anim_player.play("player_fall")
	active = false
	await get_tree().create_timer(0.2).timeout
	z_index = -91

func player_timeout():
	AudioPlayer.play_sfx("time_over")
	active = false

func player_level_finished():
	linear_velocity *= 0.8
	await get_tree().create_timer(0.1).timeout
	anim_player.play("player_finish_level")
	linear_velocity *= 0

