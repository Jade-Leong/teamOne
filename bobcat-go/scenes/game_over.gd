extends Control

func _ready() -> void:
	if GlobalData != null and GlobalData.final_time != null:
		$FinalTime.text = "Your time: " + GlobalData.final_time
	else:
		$FinalTime.text = ""
		
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
