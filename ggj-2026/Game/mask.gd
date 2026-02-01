extends Node2D

@export_category("Movement")
@export var MAX_X : int = 1840
@export var MAX_Y: int = 930 
@export var MIN_X: int = 80 
@export var MIN_Y: int = 150 
@export var speed_x : float = 0.0
@export var speed_y : float = 0.0

@export_category("VFX effects")
@export var vfx_maskoff : PackedScene

@onready var direction_timer: Timer = $DirectionTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var vfx_impact: Node2D = $vfx_impact

signal mask_hit()
@onready var mask_hitbox: Area2D = $MaskHitbox

# all mask types go here
var mask_sprites : Array[String] = ["uid://cm7daqtixblby", "uid://d2v4ddyjbtc1m", "uid://duk3l5j3wbuak", "uid://cdbefamk3mep7"]

var direction_x: float = 1.0  # 1 for right, -1 for left
var direction_y: float = 1.0  # 1 for down, -1 for up
var _current_max_x : int
var _current_min_x : int
var _current_max_y : int
var _current_min_y : int


func _ready() -> void:
	direction_timer.timeout.connect(_on_direction_timer_timeout)
	_current_max_x = MAX_X
	_current_max_y = MAX_Y
	_current_min_x = MIN_X
	_current_min_y = MIN_Y

func _process(delta: float) -> void:
	# Move horizontally
	global_position.x += _current_max_x * direction_x * delta
	
	# Horizontal boundary check
	if global_position.x >= _current_max_x:
		direction_x = -1  # Reverse horizontal direction
	elif global_position.x <= _current_min_x:
		direction_x = 1  # Reset to moving right
	
	# Move vertically
	global_position.y += speed_y * direction_y * delta
	
	# Vertical boundary check
	if global_position.y >= _current_max_y:
		direction_y = -1  # Reverse vertical direction
	elif global_position.y <= _current_min_y:
		direction_y = 1  # Reset to moving down 

func _on_mask_hitbox_area_entered(area: Area2D) -> void:
	_impact_feedback(area.position)
	mask_off(sprite_2d.texture)
	mask_hit.emit()
	# delay timer
	await get_tree().create_timer(0.1).timeout
	sprite_2d.material.set_shader_parameter("lerp_percent", 0)
	
	sprite_2d.texture = load(mask_sprites[randi_range(0, len(mask_sprites) -1)])

func _impact_feedback(impact_position: Vector2) -> void:
	# flash texture white
	sprite_2d.material.set_shader_parameter("lerp_percent", 1.0)
	# add impact particles
	vfx_impact.emit_impact_particles(impact_position)
	pass
	
func _on_direction_timer_timeout():
	# get random number between max and min (add 100 to min to avoid small numbers
	_current_max_x = randi_range(MIN_X, MAX_X)
	_current_min_x = randi_range(MIN_X, _current_max_x)
	_current_max_y = randi_range(MIN_Y, MAX_Y)
	_current_min_y = randi_range(MIN_Y, _current_max_y)
	speed_x = randi_range(100, 1000)
	speed_y = randi_range(100, 1000)

func mask_off(texture : Texture2D):
	var scene = vfx_maskoff.instantiate()
	add_child(scene)
	scene.spawn_particle(texture)
