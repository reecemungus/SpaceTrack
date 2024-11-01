extends CanvasLayer

func _on_select_pressed() -> void:
	SignalBus.OnSelectPressed.emit()

func _on_left_cycle_pressed() -> void:
	SignalBus.OnTurnLeftPressed.emit()

func _on_right_cycle_pressed() -> void:
	SignalBus.OnTurnRightPressed.emit()
