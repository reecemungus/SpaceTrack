extends Node2D
class_name SpaceLevel

@export var enemies : Array[PackedScene]

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	%SpawnPath.global_position = PlayerInfo.playerShip.cockPit.global_position

func SpawnEnemy() -> void:
	var newEnemy = enemies[randi_range(0, enemies.size() - 1)].instantiate()
	
	%SpawnPathFollower.progress_ratio = randf()
	newEnemy.global_position = %SpawnPathFollower.global_position
	
	add_child(newEnemy)

func _on_spawn_timer_timeout() -> void:
	SpawnEnemy()

func _on_level_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ShipBuildingLevel.tscn")
