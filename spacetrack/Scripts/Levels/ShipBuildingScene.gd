extends Node2D

func _ready() -> void:
	ResourceLoader.load("res://Scenes/Levels/SpaceLevel.tscn")

func _on_finish_building_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/SpaceLevel.tscn")
