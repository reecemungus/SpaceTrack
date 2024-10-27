extends CanvasLayer
class_name MainMenu

func _ready() -> void:
	ResourceLoader.load("res://Scenes/Levels/ShipBuildingLevel.tscn")

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ShipBuildingLevel.tscn")
