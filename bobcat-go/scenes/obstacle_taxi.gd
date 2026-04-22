extends StaticBody2D

@onready var background_layer = get_tree().root.find_child("CityBackground", true, false)

func _process(delta: float) -> void:
	var speed: float = 500.0
	if background_layer and background_layer.has_method("get_speed"):
		speed = background_layer.get_speed()
	position.x -= speed * delta
	if position.x < -2000:
		queue_free()
