extends TextureProgressBar
@export var count_down_timer: Timer

var speed = 67 # SIX SEVEN

func _ready() -> void:
	max_value = count_down_timer.wait_time
	value = max_value

func _process(delta: float) -> void:
	# update progress values
	#value = count_down_timer.time_left
	position += Vector2.LEFT * speed * delta
