extends Area2D
class_name GunBase

@export var bulletScene : PackedScene = preload("res://Scenes/Cars/Attachments/TurretBullet.tscn")
@export var fireSound : AudioStream 

var targetRotation : float = 0

var enemiesInRange : Array

func _physics_process(delta: float) -> void:
	enemiesInRange.clear()
	enemiesInRange = get_overlapping_bodies()
	
	if enemiesInRange.size() > 0:
		var targetEnemy = enemiesInRange.front()
		targetRotation = (targetEnemy.global_position - global_position).angle()
	
	global_rotation = lerp_angle(global_rotation, targetRotation, 0.05)

func Shoot() -> void:
	if enemiesInRange.size() <= 0: return
	
	var newBullet = bulletScene.instantiate()
	
	newBullet.global_rotation = %ShootingPoint.global_rotation
	
	get_node("/root").add_child(newBullet)
	
	newBullet.global_position = %ShootingPoint.global_position
	
	%AnimationPlayer.play("FireAnim")
	
	AudioManager.playSound(fireSound)

func _on_timer_timeout() -> void:
	Shoot()
