extends Control

func _on_turn_left_button_down() -> void:
	PlayerInfo.playerTurningLeft = true

func _on_turn_left_button_up() -> void:
	PlayerInfo.playerTurningLeft = false

func _on_turn_right_button_down() -> void:
	PlayerInfo.playerTurningRight = true

func _on_turn_right_button_up() -> void:
	PlayerInfo.playerTurningRight = false

func _on_speed_up_pressed() -> void:
	if PlayerInfo.playerAccelerating == true:
		PlayerInfo.playerAccelerating = false
		return
	
	if PlayerInfo.playerAccelerating == false:
		PlayerInfo.playerAccelerating = true
		return
