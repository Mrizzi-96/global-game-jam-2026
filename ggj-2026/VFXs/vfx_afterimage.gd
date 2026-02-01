extends CPUParticles2D

func _init() -> void:
	self.emitting = true

func _process(delta: float) -> void:
	position += delta * Vector2.LEFT * 1000
