extends Node

func SpawnParticle(globalLocation : Vector2, scene : PackedScene) -> void:
	var newParticle : CPUParticles2D = scene.instantiate()
	
	add_child(newParticle)
	
	newParticle.global_position = globalLocation
	newParticle.emitting = true
	
	newParticle.finished.connect(newParticle.queue_free)
