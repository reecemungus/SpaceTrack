extends Node

@export var healingAmount : float = 15.0

func _on_timer_timeout() -> void:
	PlayerInfo.playerHealth += healingAmount
