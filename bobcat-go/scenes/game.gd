extends Node2D

var elapsed_time: float = 0.0
var game_running: bool = true

@onready var score_label = $CanvasLayer/ScoreLabel

const OBSTACLES = [
	preload("res://scenes/obstacle_trashcan.tscn"),
	preload("res://scenes/obstacle_pigeon.tscn"),
	preload("res://scenes/obstacle_taxi.tscn"),
]
const RUN_STARTED_MESSAGE := "window.parent.postMessage({ type: 'bobcat-go:run-started' }, '*');"

@export var spawn_x: float = 1400.0
var spawn_positions = [235.0, -70, 235]  # trashcan, pigeon, taxi

var timer: float = 1.9
var spawn_interval: float = 2.0

func _ready() -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval(RUN_STARTED_MESSAGE)

func _process(delta: float) -> void:
	if game_running:
		elapsed_time += delta
		score_label.text = "Time: " + format_time(elapsed_time)
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
	
	
func format_time(time: float) -> String:
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var milliseconds = int((time - int(time)) * 100)

	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]

func end_run():
	if not game_running:
		return

	game_running = false

	var duration_ms = int(elapsed_time * 1000)
	var final_time = format_time(elapsed_time)

	print("Run ended:", final_time)

	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.parent.postMessage({ type: 'bobcat-go:game-over', durationMs: %d }, '*');" % duration_ms)
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
