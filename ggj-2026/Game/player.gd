extends Node2D

@export_category("Slap area parameters")
@export var _spawn_after_seconds : float = 0.2
@export var _despawn_after_seconds : float = 0.2
@export var _shape_radius : float = 50.0
@onready var slap_component: Node2D = $"../SlapComponent"

@onready var cursor: Sprite2D = $Cursor
@onready var _is_slapping : bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_released("slap"):
		_create_slap_area()

# called by game manager to freeze input
func is_slapping() -> bool:
	return _is_slapping

func set_is_slapping(val: bool):
	_is_slapping = val

func _create_slap_area():
	if _is_slapping:
		return

	_is_slapping = true
	# create spawn timer
	await get_tree().create_timer(_spawn_after_seconds).timeout
	var pos = self.position
	slap_component.slap_wave(pos)
	# add area to scene
	# TODO: slap_component.play_sound(slap_impact)
	
	
