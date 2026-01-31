extends CanvasLayer
@onready var mask: Node2D = $"../Mask"
@onready var score_label: Label = %ScoreLabel
@onready var timer_label: Label = %TimerLabel
@onready var score : int = 0
@onready var stopwatch: Stopwatch = $Stopwatch

func _ready() -> void:
	mask.mask_hit.connect(_on_mask_hit)
	score_label.text = str(score)

func _process(delta: float) -> void:
	update_timer_label_text()

func update_timer_label_text():
	timer_label.text = stopwatch.time_to_string()
	
func _on_mask_hit():
	score += 1
	score_label.text = str(score)
