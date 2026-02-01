extends Node2D
@onready var slap_sound: AudioStreamPlayer = $SlapSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slap_wave_name = "slap_wave" 
@onready var player: Node2D = $"../Player"

@export_category("Slapping area vars")
@export var _spawn_delay : float = 0.1
@export var _despawn_delay : float = 0.2
@export var _shape_radius : float = 50.0


func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_slap_animation_finished)

func slap_wave(slap_position : Vector2):
	self.position = slap_position
	
	# starts animation and updates each frame position of sprite
	animated_sprite_2d.visible = true
	animated_sprite_2d.play(slap_wave_name)
	create_slap_area(slap_position)

func create_slap_area(pos : Vector2) -> void:
		# create collision area in player pos
	var slap_area = Area2D.new()
	var slap_shape = CollisionShape2D.new()
	slap_area.collision_layer = 1
	slap_area.collision_mask = 2
	# Create a CircleShape2D
	var circle_shape = CircleShape2D.new()
	# Set the radius of the circle shape
	circle_shape.radius = _shape_radius  # 50 pixels radius
	slap_shape.shape = circle_shape
	# add slap shape to area
	slap_area.add_child(slap_shape)
	# add timer to delay slap spawn
	await get_tree().create_timer(_spawn_delay).timeout
	slap_area.position = self.position
	# INSTANTIATE
	$"..".add_child(slap_area)
	# create despawn timer
	get_tree().create_timer(_despawn_delay).timeout.connect(_on_despawn_timer_timeout.bind(slap_area))
	
func _on_despawn_timer_timeout(slap_area : Area2D):
	slap_area.queue_free()
	player.set_is_slapping(false)
	
func _on_slap_animation_finished():
	animated_sprite_2d.visible = false
