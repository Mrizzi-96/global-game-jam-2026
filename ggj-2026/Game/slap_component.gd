extends Node2D
@onready var slap_sound: AudioStreamPlayer = $SlapSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var slap_wave_name = "slap_wave" 
@onready var player: Node2D = $"../Player"
@onready var slap_player: AudioStreamPlayer = $"../SlapPlayer"

@export_category("Slapping area vars")
@export var _spawn_delay : float = 0.1
@export var _despawn_delay : float = 0.2
@export var _shape_radius : float = 50.0

@export_category("Afterimage VFX")
@export var vfx_afterimage_scene: PackedScene

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_slap_animation_finished)

func slap_wave(slap_position : Vector2):
	self.position = slap_position
	
	# starts animation and updates each frame position of sprite
	animated_sprite_2d.visible = true
	animated_sprite_2d.play(slap_wave_name)
	# scale hand up to the scale ref
	set_hand_scale_to(Vector2(0.18, 0.18), 0.15)
	animated_sprite_2d.scale = Vector2(0.04, 0.04)
	slap_player.play()
	
	# spawn afterimage
	spawn_afterimage()
	create_slap_area(slap_position)

func set_hand_scale_to(scale_ref : Vector2, time : float = 0.1):
	var scale_tween = get_tree().create_tween()
	scale_tween.tween_property(self.animated_sprite_2d, "scale",scale_ref, time)

func spawn_afterimage():
	# spawn scene
	var afterimage = vfx_afterimage_scene.instantiate()
	add_child(afterimage)
	
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
	# scale hand up to the scale ref
	set_hand_scale_to(Vector2(0.01, 0.01), 0.15)
	animated_sprite_2d.scale = Vector2(0.18, 0.18)
	#player.set_is_slapping(false)
	
func _on_slap_animation_finished():
	animated_sprite_2d.visible = false
