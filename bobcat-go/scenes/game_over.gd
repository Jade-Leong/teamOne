extends Control

func _ready() -> void:
	$FinalTime.text = "Your time: " + GlobalData.final_time

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
