extends Node2D

func spawn_particle(texture: Texture2D):
	$CPUParticles2D.texture = texture
	$CPUParticles2D.emitting = true


func _on_cpu_particles_2d_finished() -> void:
	self.queue_free()
