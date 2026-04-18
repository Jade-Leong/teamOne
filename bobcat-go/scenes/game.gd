extends Node2D

# List your obstacle scenes here
const OBSTACLES = [
	preload("res://scenes/obstacle_trashcan.tscn"),
	preload("res://scenes/obstacle_pigeon.tscn"),
	preload("res://scenes/obstacle_taxi.tscn"),
]

@export var spawn_interval: float = 2.0  # seconds between spawns
@export var spawn_x: float = 1400.0      # where they appear (right side)
@export var spawn_y: float = 480.0       # ground level, adjust to match your floor

var timer: float = 0.0

func _process(delta: float) -> void:
	timer += delta

	# gradually gets harder over time
	spawn_interval = max(0.8, spawn_interval - delta * 0.01)

	if timer >= spawn_interval:
		timer = 0.0
		spawn_obstacle()

func spawn_obstacle():
	var random_index = randi() % OBSTACLES.size()
	var obstacle = OBSTACLES[random_index].instantiate()
	obstacle.position = Vector2(spawn_x, spawn_y)
	add_child(obstacle)
