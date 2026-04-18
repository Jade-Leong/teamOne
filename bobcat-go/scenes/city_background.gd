extends ParallaxLayer

# Speed in pixels per second
@export var scroll_speed: float = 300.0

func _process(delta: float) -> void:
	# Continuously offset the layer's motion
	self.motion_offset.x -= scroll_speed * delta
