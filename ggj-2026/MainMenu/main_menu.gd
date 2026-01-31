extends Control

var game_scene = "uid://io3piuiaqwig"

func _on_play_button_up() -> void:
	get_tree().change_scene_to_file(game_scene)


func _on_quit_button_up() -> void:
	get_tree().quit()
