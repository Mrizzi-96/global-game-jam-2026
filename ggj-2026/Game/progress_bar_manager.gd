extends TextureProgressBar
@export var count_down_timer: Timer

func _ready() -> void:
	max_value = count_down_timer.wait_time
	value = max_value

func _process(delta: float) -> void:
	# update progress values
	value = count_down_timer.time_left
