extends Node2D

@export var UIClickSound : AudioStream

func _ready() -> void:
	ResourceLoader.load("res://Scenes/Levels/SpaceLevel.tscn")

func _on_finish_building_pressed() -> void:
	AudioManager.playSound(UIClickSound)
	
	get_tree().change_scene_to_file("res://Scenes/Levels/SpaceLevel.tscn")
