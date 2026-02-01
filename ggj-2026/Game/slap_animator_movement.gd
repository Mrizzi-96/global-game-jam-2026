extends AnimatedSprite2D
@export var SPEED : float = 1000

@onready var slap_offset = Vector2(100,0)

func _process(delta: float) -> void:
	if visible:
		self.position += Vector2.LEFT * delta * SPEED
	else:
		self.position = Vector2.ZERO + slap_offset
