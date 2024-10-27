extends Node2D
class_name SpaceLevel

@export var enemies : Array[PackedScene]

func _init() -> void:
	SignalBus.IncRound.emit()

func _ready() -> void:
	var newLevelTimer := Timer.new()
	
	add_child(newLevelTimer)
	newLevelTimer.timeout.connect(LevelTimeout)
	newLevelTimer.timeout.connect(newLevelTimer.queue_free)
	
	newLevelTimer.start(PlayerInfo.roundTime)
	
	%SpawnTimer.wait_time = PlayerInfo.spawnInterval

func _physics_process(delta: float) -> void:
	%SpawnPath.global_position = PlayerInfo.playerShip.cockPit.global_position

func SpawnEnemy() -> void:
	var newEnemy = enemies[randi_range(0, enemies.size() - 1)].instantiate()
	
	%SpawnPathFollower.progress_ratio = randf()
	newEnemy.global_position = %SpawnPathFollower.global_position
	
	add_child(newEnemy)

func _on_spawn_timer_timeout() -> void:
	SpawnEnemy()

func LevelTimeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/ShipBuildingLevel.tscn")
