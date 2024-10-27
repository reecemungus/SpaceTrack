extends Area2D
class_name BulletBase

var travelledDistance : float = 0.0

@export var bulletSpeed : float = 1000.0
@export var bulletRange : float = 1200.0

@export var bulletDamage : float = 10.0

@export var bulletSpread : float = 0.0

@export var penetrateEnemies : bool = false

func _ready() -> void:
	rotation += randf_range(-bulletSpread, bulletSpread)

func _physics_process(delta: float) -> void:
	var direction : Vector2 = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletSpeed * delta
	
	travelledDistance += bulletSpeed * delta
	
	if travelledDistance > bulletRange:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("OnDamage"):
		body.OnDamage(bulletDamage)
	
	if !penetrateEnemies:
		queue_free()
