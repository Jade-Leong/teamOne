extends StaticBody2D

@export var scroll_speed: float = 400.0  # match your background speed

func _process(delta: float) -> void:
	position.x -= scroll_speed * delta
	# delete when off the left side of screen
	if position.x < -500:
		queue_free()
