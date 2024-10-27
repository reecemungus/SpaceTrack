extends CarBase
class_name CarInst

### INFO ###
## Car 

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var posThisFrame = global_position
	velocity = (posThisFrame - posLastFrame) * delta
	posLastFrame = global_position
	
	if velocity.length() > 0.01:
		RotateToMoveDir()
	
	var overLappingEnemies = %Hurtbox.get_overlapping_bodies()
	
	PlayerInfo.playerHealth -= overLappingEnemies.size() * delta
	
	SignalBus.UpdateHealth.emit()

func RotateToMoveDir() -> void:
	global_rotation = lerp_angle(global_rotation, velocity.angle(), 0.5)
