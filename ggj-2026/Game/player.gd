extends Node2D

@export_category("Slap area parameters")
@export var _spawn_after_seconds : float = 0.2
@export var _despawn_after_seconds : float = 0.2
@export var _shape_radius : float = 50.0


@onready var cursor: Sprite2D = $Cursor
@onready var _is_slapping : bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_released("slap"):
		_create_slap_area()

# called by game manager to freeze input
func is_slapping() -> bool:
	return _is_slapping

func _create_slap_area():
	if _is_slapping:
		return
	# create collision area in player pos
	var slap_area = Area2D.new()
	var slap_shape = CollisionShape2D.new()
	# Create a CircleShape2D
	var circle_shape = CircleShape2D.new()
	
	# Set the radius of the circle shape
	circle_shape.radius = _shape_radius  # 50 pixels radius
	slap_shape.shape = circle_shape
	_is_slapping = true
	# create spawn timer
	await get_tree().create_timer(_spawn_after_seconds).timeout
	slap_area.add_child(slap_shape)
	slap_area.global_position = self.position
	$"..".add_child(slap_area)
	# create despawn timer
	get_tree().create_timer(_despawn_after_seconds).timeout.connect(_on_despawn_timer_timeout.bind(slap_area))

func _on_despawn_timer_timeout(slap_area : Area2D):
	slap_area.queue_free()
	_is_slapping = false
