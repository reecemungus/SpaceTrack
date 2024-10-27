extends Node

### INFO
## Global class handling the creation and destruction of audio assets at runtime

func playSoundAtLocation(globalLocation : Vector2, sound : AudioStream, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSound.stream = sound
	
	add_child(newSound)
	newSound.global_position = globalLocation
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	newSound.attenuation = 75.0
	
	newSound.playing = true
	newSound.finished.connect(newSound.queue_free)

func playSound(sound : AudioStream, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer = AudioStreamPlayer.new()
	newSound.stream = sound
	
	add_child(newSound)
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	
	newSound.playing = true
	newSound.finished.connect(newSound.queue_free)
