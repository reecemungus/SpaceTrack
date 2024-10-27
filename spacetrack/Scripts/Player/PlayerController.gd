extends CharacterBody2D
class_name PlayerController

### INFO ###
## Class managing player input

@export var cockPit : CockpitCar

var movement : float
var isAccelerating : bool

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	isAccelerating = false
	
	if Input.is_action_pressed("SpeedUp"):
		movement += cockPit.acceleration * delta
		isAccelerating = true
	#if Input.is_action_pressed("SpeedDown"):
		#movement += cockPit.brakeSpeed * delta
	if Input.is_action_pressed("TurnRight"):
		if velocity.length() > 0.1:
			global_rotation += cockPit.turnSpeed * delta
	if Input.is_action_pressed("TurnLeft"):
		if velocity.length() > 0.1:
			global_rotation -= cockPit.turnSpeed * delta
	
	if !isAccelerating:
		movement = move_toward(movement, 0, (cockPit.brakeSpeed * -1) * delta) 
	
	velocity = Vector2.RIGHT.rotated(global_rotation) * movement
	move_and_slide()
	
	PlayerInfo.playerSpeed = velocity.length()
