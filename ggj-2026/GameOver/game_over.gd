extends Control
@onready var total_score_label: Label = %TotalScoreLabel
var main_menu : String = "uid://ca301koyojh5p"
var game : String = "uid://io3piuiaqwig"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	total_score_label.text = str(Global.get_total_score())

func _on_retry_button_up() -> void:
	get_tree().change_scene_to_file(game)


func _on_main_menu_button_up() -> void:
	get_tree().change_scene_to_file(main_menu)
