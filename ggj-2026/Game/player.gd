extends Node2D

@onready var slap_component: Node2D = $"../SlapComponent"
@onready var slap_cooldown: Timer = $SlapCooldown
@onready var slap_player: AudioStreamPlayer = $"../SlapPlayer"

@onready var cursor: Sprite2D = $Cursor
@onready var _is_slapping : bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_released("slap") and !is_slapping():
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
	var pos = self.position
	slap_component.slap_wave(pos)
	# add area to scene

func _on_slap_cooldown_timeout() -> void:
	_is_slapping = false
