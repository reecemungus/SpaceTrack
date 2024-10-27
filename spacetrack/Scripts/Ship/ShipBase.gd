extends Node2D
class_name ShipBase

### INFO ### 
## Class to define a Ship, a collection of cars

@export var shipResource : ShipResource = preload("res://Assets/Ships/PlayerShip.tres")

var isInstanced : bool = false

func _init() -> void:
	var cockPit = shipResource.cockPitScene.instantiate()
	cockPit.global_position = Vector2.ZERO
	
	shipResource.cockPit = cockPit
	
	add_child(cockPit)
	
	for car in shipResource.ship:
		car.index = shipResource.ship.find(car)
	
	InstantiateShip()

func InstantiateShip() -> void:
	var globalPos : Vector2 = shipResource.cockPit.global_position
	
	for i in range(0, shipResource.ship.size()):
		var tempShip : CarInst = shipResource.ship[i].instanceScene.instantiate()
		shipResource.shipInsts.insert(i, tempShip)
		
		globalPos.x -= shipResource.ship[i].radius
		tempShip.global_position = globalPos
		
		tempShip.name = str(randf())
		tempShip.shipID = shipResource.ship[i]
		
		tempShip.get_node("./CarSprite").texture = shipResource.ship[i].carSprite
		
		if shipResource.ship[i].attachmentScene:
			var newAtt = shipResource.ship[i].attachmentScene.instantiate()
			
			tempShip.add_child(newAtt)
		
		add_child(tempShip)
		print(tempShip)
	
	isInstanced = true

func ConstrainCars() -> void:
	if !isInstanced : return
	
	if shipResource.ship.size() == 0: return
	
	shipResource.shipInsts[0].ConstrainDistance(shipResource.cockPit.global_position, shipResource.ship[0].radius)
	
	for i in range(1, shipResource.ship.size()):
		shipResource.shipInsts[i].ConstrainDistance(shipResource.shipInsts[i - 1].global_position, shipResource.ship[i].radius)
