extends Node2D
class_name ShipBuilder

@export var ship : ShipResource
@export var swapSound : AudioStream

@export var carTypes : Array[ShipCar]

@onready var shipParts : ShipParts = get_node("./ShipParts")
@onready var selector : Node2D = get_node("./Selector")

var shipPartInst = preload("res://Scenes/ShipBuilder/ShipPartInst.tscn")

var selectedPart : ShipPart = null

func _ready() -> void:
	var newSegment : ShipCar
	ship.ship.insert(ship.ship.size(), carTypes[randi_range(0, carTypes.size() - 1)])
	
	InstantiateShip()
	
	shipParts.OnReady()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("TurnRight"):
		if shipParts.SelectNeighbor(-1) : shipParts.activePart = shipParts.SelectNeighbor(-1)
		return
	if event.is_action_pressed("TurnLeft"):
		if shipParts.SelectNeighbor(1) : shipParts.activePart = shipParts.SelectNeighbor(1)
		return
	if event.is_action_pressed("Select"):
		if selectedPart: 
			SwapParts()
			selectedPart = null
			
			AudioManager.playSound(swapSound)
			
			return
		
		if !selectedPart: 
			selectedPart = shipParts.activePart
			return

func _physics_process(delta: float) -> void:
	if shipParts.activePart:
		selector.global_position = shipParts.activePart.global_position

func InstantiateShip() -> void:
	for car in shipParts.parts:
		car.free()
	
	shipParts.parts.clear()
	
	var location : Vector2 = global_position
	
	for car in ship.ship:
		var temp : ShipPart = shipPartInst.instantiate()
		temp.texture = car.carSprite
		temp.part = car
		
		temp.global_position = location
		
		shipParts.add_child(temp)
		
		location.x -= 75
	
	shipParts.OnReady()

func SwapParts() -> void:
	var carA = ship.ship.find(selectedPart.part)
	var carB = ship.ship.find(shipParts.activePart.part)
	
	print(carA)
	print(carB)
	
	var temp = ship.ship[carA]
	
	ship.ship[carA] = ship.ship[carB]
	ship.ship[carB] = temp
	
	for part in ship.ship:
		part.index = ship.ship.find(part)
	
	ResourceSaver.save(ship, ship.resource_path)
	
	InstantiateShip()
	shipParts.ComputeChildren()
