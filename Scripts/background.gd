extends ParallaxBackground

@onready var sprite = $ParallaxLayer/Sprite2D

@export var bg_texture: CompressedTexture2D = preload("res://Assets/Sprites/BG.png")
@export var scroll_time = 0.5

var timer_node = null

func _ready():
	sprite.texture = bg_texture
	create_bg_timer()


func move_background():
	sprite.region_rect.position += Vector2(1, 1)
	if sprite.region_rect.position >= Vector2(16,16):
		sprite.region_rect.position = Vector2.ZERO

func create_bg_timer():
	timer_node = Timer.new()
	timer_node.name = "BG Timer"
	timer_node.wait_time = scroll_time
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()

func _on_level_timer_timeout():
	move_background()
