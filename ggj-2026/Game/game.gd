extends Node2D

@onready var player: Node2D = $Player

func _ready() -> void:
	# hide standard cursor
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	player.position = get_global_mouse_position()
