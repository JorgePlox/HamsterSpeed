extends Control

enum menu_scenes {TITLEANIM, TITLE, LEVEL_SELECTOR}
var state = menu_scenes.TITLEANIM
@onready var main_screen = $MainScreen
@onready var level_selector = $LevelSelector
@onready var course_1_button = $LevelSelector/Button
@onready var course_2_button = $LevelSelector/Button2
@onready var course_3_button = $LevelSelector/Button3
@export var course_1_first_level: PackedScene = null
@export var course_2_first_level: PackedScene = null
@export var course_3_first_level: PackedScene = null

@onready var AnimPlayer = $MainScreen/AnimationPlayer

func _ready():
	main_screen.visible = true
	level_selector.visible = false
	course_1_button.disabled = true
	course_2_button.disabled = true
	course_3_button.disabled = true
	
	AudioPlayer.play_menu_song()

func _input(event):
	match state:
		menu_scenes.TITLEANIM:
				if event.is_pressed() or (!AnimPlayer.current_animation == "Intro"):
					AnimPlayer.play("Main")
					state = menu_scenes.TITLE
				
		menu_scenes.TITLE:
			if event.is_pressed():
				main_screen.visible = false
				level_selector.visible = true
				state = menu_scenes.LEVEL_SELECTOR
				await get_tree().create_timer(0.3).timeout
				course_1_button.disabled = false
				course_2_button.disabled = false
				course_3_button.disabled = false
				course_1_button.grab_focus()
		menu_scenes.LEVEL_SELECTOR:
			pass

func _on_course_1_button_pressed():
	get_tree().change_scene_to_packed(course_1_first_level)


func _on_course_button_2_pressed():
	get_tree().change_scene_to_packed(course_2_first_level)


func _on_course_button_3_pressed():
	pass # Replace with function body.
