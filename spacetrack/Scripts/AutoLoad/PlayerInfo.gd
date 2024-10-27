extends Node

### INFO ###
### Class containing player information

## GalaxyMap

var GalaxyMap : PackedScene

## PlayerShip

var roundTime : int = 20
var spawnInterval : float = 0.75

var roundTimeMult : float = 1.25
var spawnIntervalMult : float = 0.75

var playerShip : ShipResource = preload("res://Assets/Ships/PlayerShip.tres")

var playerKills : int = 0
var playerSpeed : float = 0

var maxHealth : float = 250

var playerHealth : float = 250 :
	
	set(value):
		playerHealth = value
		
		if playerHealth <= 0:
			SignalBus.KillPlayer.emit()
			get_tree().change_scene_to_file("res://Scenes/Levels/GameOver.tscn")
		
		if playerHealth >= maxHealth:
			playerHealth = maxHealth

func _ready() -> void:
	playerShip.ship = playerShip.ship.slice(0, 1)
	
	SignalBus.IncRound.connect(IncRound)

func IncRound() -> void:
	roundTime = roundTime * roundTimeMult
	spawnInterval = spawnInterval * spawnIntervalMult
