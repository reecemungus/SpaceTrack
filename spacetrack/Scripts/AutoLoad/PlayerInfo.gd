extends Node

### INFO ###
### Class containing player information

## GalaxyMap

var GalaxyMap : PackedScene

## PlayerShip

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
