extends CanvasLayer
@onready var mask: Node2D = $"../Mask"
@onready var score_label: Label = %ScoreLabel
@onready var timer_label: Label = %TimerLabel
@onready var score : int = 0
@onready var count_down_timer: Timer = $CountDownTimer
var game_over_scene = "uid://6w5rg4wqlh7s"

func _ready() -> void:
	mask.mask_hit.connect(_on_mask_hit)
	update_score_label(score)
	count_down_timer.start()

func _process(delta: float) -> void:
	update_timer_label_text()
	
func _on_count_down_timer_timeout():
	get_tree().call_deferred("change_scene_to_file", game_over_scene)
	
func time_to_string() -> String:
	var sec = fmod(count_down_timer.time_left, 60)
	var format_string = "%02d"
	var result = format_string % [sec]
	return result
	
func update_timer_label_text():
	timer_label.text = time_to_string()

func update_score_label(score):
	var format_string = "%02d"
	var result = format_string % [score]
	score_label.text = result

func _on_mask_hit():
	score += 1
	update_score_label(score)
	Global.set_total_score(score)
