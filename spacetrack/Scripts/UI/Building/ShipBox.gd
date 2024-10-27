extends HBoxContainer

var selectedElement : TextureRect

var childTexRects : Array[TextureRect]

func _ready() -> void:
	childTexRects = GetTexChildren(get_children())
	
	selectedElement = childTexRects[randi_range(0, childTexRects.size() - 1)]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("TurnRight"):
		if GetNeighboringElement(1) != null: selectedElement = GetNeighboringElement(1)
	if event.is_action_pressed("TurnLeft"):
		if GetNeighboringElement(-1) != null: selectedElement = GetNeighboringElement(-1)

#func _physics_process(delta: float) -> void:
	#print(selectedElement)

func GetTexChildren(input) -> Array[TextureRect]:
	var sortedArray : Array[TextureRect]
	
	for i in range(0, input.size()):
		print(i)
		
		if input[i] is TextureRect:
			sortedArray.insert(i, input[i])
	
	return sortedArray

func GetNeighboringElement(inInt : int) -> TextureRect:
	var index : int = childTexRects.find(selectedElement)
	
	var targetIndex : int = index + inInt
	
	if targetIndex == -1 or targetIndex == childTexRects.size(): return null
	
	if childTexRects[targetIndex] != null:
		return childTexRects[targetIndex]
	
	return null
