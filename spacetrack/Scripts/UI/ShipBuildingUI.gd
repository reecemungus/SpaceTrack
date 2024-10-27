extends CanvasLayer
class_name ShipBuildingUI

@onready var arrow : TextureRect = %Arrow

func _physics_process(delta: float) -> void:
	arrow.position = %ShipContainer.selectedElement.position
