extends Node2D
class_name ShipParts

var parts : Array
var activePart : ShipPart

func OnReady() -> void:
	ComputeChildren()
	
	activePart = parts[randi_range(0, parts.size() - 1)]

func ComputeChildren() -> void:
	parts.clear()
	parts = get_children().filter(isPart)

func isPart(input) -> bool:
	if input is ShipPart: 
		return true
	
	return false

func SelectNeighbor(inInt : int) -> ShipPart:
	var index : int = parts.find(activePart)
	
	var targetIndex : int = index + inInt
	
	if targetIndex == -1 or targetIndex == parts.size(): return null
	
	if parts[targetIndex] != null:
		return parts[targetIndex]
	
	return null
