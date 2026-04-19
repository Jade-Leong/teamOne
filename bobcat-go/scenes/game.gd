extends Node2D

const OBSTACLES = [
	preload("res://scenes/obstacle_trashcan.tscn"),
	preload("res://scenes/obstacle_pigeon.tscn"),
]

@export var spawn_x: float = 1400.0
var spawn_positions = [235.0, -70]  # trashcan, pigeon

var timer: float = 1.9
var spawn_interval: float = 2.0

func _process(delta: float) -> void:
	timer += delta
	spawn_interval = max(0.4, spawn_interval - delta * 0.02)
	if timer >= spawn_interval:
		timer = 0.0
		spawn_obstacle()

func spawn_obstacle():
	var random_index = randi() % OBSTACLES.size()
	var obstacle = OBSTACLES[random_index].instantiate()
	obstacle.position = Vector2(spawn_x, spawn_positions[random_index])
	add_child(obstacle)
