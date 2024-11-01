extends Node

### INFO
## Global class handling the creation and destruction of audio assets at runtime

var soundCounts : Dictionary = {}
const maxSounds = 5

func playSound(sound : AudioStream, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer = AudioStreamPlayer.new()
	
	if sound in soundCounts:
		if soundCounts[sound] >= maxSounds:
			return
	
	newSound.stream = sound
	
	add_child(newSound)
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	
	newSound.playing = true
	
	newSound.finished.connect(RemoveSound.bind(sound))
	newSound.finished.connect(newSound.queue_free)
	
	if sound in soundCounts:
		soundCounts[sound] += 1
	else:
		soundCounts[sound] = 1

func RemoveSound(sound : AudioStream) -> void:
	if sound in soundCounts:
		soundCounts[sound] -= 1
