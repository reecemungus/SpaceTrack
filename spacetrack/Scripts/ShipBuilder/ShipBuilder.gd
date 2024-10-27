extends Node2D
class_name ShipBuilder

@export var ship : ShipResource

@export var swapSound : AudioStream
@export var selectSound : AudioStream

@export var carTypes : Array[ShipCar]

@onready var shipParts : ShipParts = get_node("./ShipParts")
@onready var selector : Node2D = get_node("./Selector")

@onready var arrow : Node2D = get_node("./Arrow")
var arrowTargetLocation : Vector2 = Vector2.ZERO
var arrowTargetColor : Color = Color.WHITE

var shipPartInst = preload("res://Scenes/ShipBuilder/ShipPartInst.tscn")

var selectedPart : ShipPart = null

func _ready() -> void:
	var newSegment : ShipCar = ShipCar.new()
	var copySeg = carTypes[randi_range(0, carTypes.size() - 1)]
	
	newSegment = copySeg.duplicate()
	
	ship.ship.insert(ship.ship.size(), newSegment)
	
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
			arrowTargetColor = Color.SKY_BLUE
			selectedPart = shipParts.activePart
			
			AudioManager.playSound(selectSound)
			
			return

func _physics_process(delta: float) -> void:
	arrow.global_position = lerp(arrow.global_position, arrowTargetLocation, 0.1)
	arrow.modulate = lerp(arrow.modulate, arrowTargetColor, 0.1)
	
	if shipParts.activePart:
		selector.global_position = shipParts.activePart.global_position
		
		arrowTargetLocation = shipParts.activePart.global_position

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
	
	var temp = ship.ship[carA]
	
	ship.ship[carA] = ship.ship[carB]
	ship.ship[carB] = temp
	
	for part in ship.ship:
		part.index = ship.ship.find(part)
	
	ResourceSaver.save(ship, ship.resource_path)
	
	InstantiateShip()
	shipParts.ComputeChildren()
	
	arrowTargetColor = Color.WHITE
