extends Node2D

@onready var player: Node2D = $Player
@export_category("Player speed")
@export var FOLLOW_SPEED : float = 10.0
@export var DELAY_SPEED : float = 2.0
@onready var mask: Node2D = $Mask


func _ready() -> void:
	# hide standard cursor
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	if not player.is_slapping():
		player.position = player.position.lerp(get_global_mouse_position(), delta * FOLLOW_SPEED)
	else:
		player.position = player.position.lerp(get_global_mouse_position(), delta * DELAY_SPEED)
