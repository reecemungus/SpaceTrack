extends Sprite2D

var closestBlips : Array
var lines : Array[Line2D]

func _ready() -> void:
	pass

func _on_mouse_area_mouse_entered() -> void:
	for line in lines:
		line.visible = true

func _on_mouse_area_mouse_exited() -> void:
	for line in lines:
		line.visible = false
