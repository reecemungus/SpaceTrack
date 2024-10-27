extends CharacterBody2D
class_name EnemyBase

var target : CarInst

@export var moveSpeed : float = 2500.0
@export var health : float = 50

@export var deathSound : AudioStream
@export var deathParticle : PackedScene

func _ready() -> void:
	var insts : Array = get_tree().get_nodes_in_group("G_CarInsts")
	
	target = insts[randi_range(0, insts.size() - 1)]

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(target.global_position)
	velocity = (direction * moveSpeed) * delta
	
	global_rotation = lerp_angle(global_rotation, velocity.angle(), 0.01)
	
	move_and_slide()

func OnDamage(damage : float) -> void:
	health -= damage
	
	if health <= 0:
		PlayerInfo.playerKills += 1
		SignalBus.UpdateKills.emit()
		
		AudioManager.playSound(deathSound)
		ParticleManager.SpawnParticle(global_position, deathParticle)
		
		queue_free()
