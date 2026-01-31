extends Node2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var cpu_particles_2d_2: CPUParticles2D = $CPUParticles2D2

func emit_impact_particles(impact_position: Vector2) -> void:
	self.global_position = impact_position
	cpu_particles_2d.emitting = true
	cpu_particles_2d_2.emitting = true
	
