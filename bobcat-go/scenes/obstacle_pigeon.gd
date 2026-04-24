extends StaticBody2D

var base_y: float = 0.0
var bob_speed: float = 3.0
var bob_height: float = 20.0
var time: float = 0.0

func _ready() -> void:
	base_y = position.y
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	time += delta
	position.y = base_y + sin(time * bob_speed) * bob_height
	
	var background_layer = get_tree().root.find_child("CityBackground", true, false)
	var speed: float = 500.0
	if background_layer and background_layer.has_method("get_speed"):
		speed = background_layer.get_speed()
	position.x -= speed * delta
	if position.x < -1000:
		queue_free()
