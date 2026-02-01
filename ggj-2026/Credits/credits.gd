extends Control

var main_menu_scene = "uid://ca301koyojh5p"


func _on_main_menu_button_up() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
