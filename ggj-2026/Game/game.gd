extends Node2D

@onready var player: Node2D = $Player
@export_category("Player speed")
@export var FOLLOW_SPEED : float = 10.0
@export var DELAY_SPEED : float = 2.0
func _ready() -> void:
	# hide standard cursor
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	if not player.is_slapping():
		player.position = player.position.lerp(get_global_mouse_position(), delta * FOLLOW_SPEED)
	else:
		player.position = player.position.lerp(get_global_mouse_position(), delta * DELAY_SPEED)
		


func _on_mask_hitbox_area_entered(area: Area2D) -> void:
	# TODO: instantiate new mask & play animation
	pass # Replace with function body.
