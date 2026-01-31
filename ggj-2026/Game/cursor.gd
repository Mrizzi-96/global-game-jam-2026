extends Node2D

@export_category("Slap area parameters")
@export var _spawn_after_seconds : float = 0.2
@export var _despawn_after_seconds : float = 0.2
@export var _shape_radius : float = 50.0

@onready var cursor: Sprite2D = $Cursor

func _process(delta: float) -> void:
	if Input.is_action_just_released("slap"):
		_create_slap_area()


func _create_slap_area():
	# create collision area in player pos
	var slap_area = Area2D.new()
	var slap_shape = CollisionShape2D.new()
	# Create a CircleShape2D
	var circle_shape = CircleShape2D.new()
	
	# Set the radius of the circle shape
	circle_shape.radius = _shape_radius  # 50 pixels radius
	slap_shape.shape = circle_shape
	# create spawn timer
	get_tree().create_timer(_spawn_after_seconds)
	slap_area.add_child(slap_shape)
	slap_area.global_position = self.position
	$"..".add_child(slap_area)
	# create despawn timer
	get_tree().create_timer(_despawn_after_seconds).timeout.connect(_on_despawn_timer_timeout.bind(slap_area))

func _on_despawn_timer_timeout(slap_area : Area2D):
	slap_area.queue_free()
