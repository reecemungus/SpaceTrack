extends Resource
class_name ShipResource

### INFO ###
## Resource containing ship data

@export var ship : Array[ShipCar]

var cockPitScene : PackedScene = preload("res://Scenes/PlayerCockpit.tscn")
var cockPit : CharacterBody2D

var shipInsts : Array[CarInst]
