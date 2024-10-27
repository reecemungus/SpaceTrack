extends Node2D

var blipScene = preload("res://Scenes/GalaxyMap/BlipInst.tscn")

@export var blipAmount : int = 3
@export var minDistance : float = 500.0

@export var lowerLeft : Vector2 = Vector2(-850, 450)
@export var upperRight : Vector2 = Vector2(850, -450)

@export var blips : Array[Node2D] 

func _ready() -> void:
	for i in range(0, blipAmount):
		var newBlip : Node2D = blipScene.instantiate()
		
		var randX : float = randf_range(lowerLeft.x, upperRight.x)
		var randY : float = randf_range(lowerLeft.y, upperRight.y)
		
		newBlip.global_position = Vector2(randX, randY)
		
		var posValid : bool = true
		
		for exBlip in blips:
			if newBlip.global_position.distance_to(exBlip.global_position) < minDistance:
				posValid = false
		
		if !posValid: 
			newBlip.queue_free()
			continue
		
		blips.insert(blips.size(), newBlip)
		newBlip.closestBlips = FindXClosest(newBlip, 3)
		
		DrawLinesToClosest(newBlip)
		
		add_child(newBlip)
	
	var thisScene = PackedScene.new()
	thisScene.pack(get_node(".."))
	
	ResourceSaver.save(thisScene, "res://Assets/SavedAssets/GalaxyMapSaved.tscn")

func FindXClosest(inblip : Node2D, X : int) -> Array:
	var closestBlips : Array = []
	
	for blip in blips:
		if blip != inblip:
			var distance = inblip.global_position.distance_to(blip.global_position)
			if distance < 10000: 
				closestBlips.append([blip, distance])
	
	closestBlips.sort_custom(SortByClosest)
	
	return closestBlips.slice(0, 4)

func SortByClosest(a, b) -> bool:
	return a[1] > b[1]

func DrawLinesToClosest(blip : Node2D) -> void:
	for i in range(0, blip.closestBlips.size()):
		var newLine : Line2D = Line2D.new()
		
		newLine.default_color = Color.WHITE
		newLine.width = 2.5
		
		newLine.add_point(blip.global_position)
		newLine.add_point(blip.closestBlips[i][0].global_position)
		
		add_child(newLine)
		
		newLine.visible = false
		
		blip.lines.insert(0, newLine)
		blip.closestBlips[i][0].lines.insert(0, newLine)
