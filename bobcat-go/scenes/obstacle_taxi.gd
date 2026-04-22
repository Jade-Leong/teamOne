extends StaticBody2D

# Higher priority: Use the global world speed
var speed: float = 500.0 

func _process(delta: float) -> void:
	# Look for the background layer every frame or cache it in _ready
	var background_layer = get_tree().root.find_child("CityBackground", true, false)
	
	if background_layer and background_layer.has_method("get_speed"):
		speed = background_layer.get_speed()
	
	# Move left to simulate the player moving right
	position.x -= speed * delta
	
	# Cleanup when off-screen
	if position.x < -500: # Increased buffer to ensure it's fully off-screen
		queue_free()
