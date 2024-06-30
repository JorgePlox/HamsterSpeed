extends Area2D

@export var points = 50


func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		ScoreSystem.add_score(points)
		$CollisionShape2D.queue_free()
		AudioPlayer.play_sfx("coin")
		await get_tree().create_timer(0.2).timeout
		queue_free()
