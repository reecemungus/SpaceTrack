extends Node

### INFO ###
## Class to handle all signals 

signal KillPlayer

## UI Stuff

signal UpdateKills
signal UpdateSpeed

signal UpdateHealth

signal IncRound

## Controls

signal OnSelectPressed

signal OnSpeedUpPressed
signal OnSpeedDownPressed

signal OnTurnLeftPressed
signal OnTurnRightPressed

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Select"):
		OnSelectPressed.emit()
	
	if event.is_action_pressed("SpeedUp"):
		PlayerInfo.playerAccelerating = true
		
		OnSpeedUpPressed.emit()
	
	if event.is_action_released("SpeedUp"):
		PlayerInfo.playerAccelerating = false
	
	if event.is_action_pressed("SpeedDown"):
		PlayerInfo.playerDecelerating = true
		
		OnSpeedDownPressed.emit()
	
	if event.is_action_released("SpeedDown"):
		PlayerInfo.playerDecelerating = false
	
	if event.is_action_pressed("TurnLeft"):
		PlayerInfo.playerTurningLeft = true
		
		OnTurnLeftPressed.emit()
	
	if event.is_action_released("TurnLeft"):
		PlayerInfo.playerTurningLeft = false
	
	if event.is_action_pressed("TurnRight"):
		PlayerInfo.playerTurningRight = true
		
		OnTurnRightPressed.emit()
	
	if event.is_action_released("TurnRight"):
		PlayerInfo.playerTurningRight = false
