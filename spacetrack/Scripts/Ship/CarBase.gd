extends Node2D
class_name CarBase

### INFO ###
## Class containing base code used by all ShipCars (Insts)

var shipID : ShipCar
var health : float = 100

@onready var posLastFrame : Vector2 = global_position
var velocity : Vector2 

func ConstrainDistance(anchorLocation, radius) -> void:
	global_position = ((global_position - anchorLocation).normalized() * radius) + anchorLocation
