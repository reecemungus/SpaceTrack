extends ShipBase
class_name PlayerShip

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	ConstrainCars()
