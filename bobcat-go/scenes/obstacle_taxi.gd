extends StaticBody2D

@export var scroll_speed: float = 200.0

func _process(delta: float) -> void:
	position.x -= scroll_speed * delta
	print("taxi x: ", position.x)
	if position.x < -2000:
		queue_free()
