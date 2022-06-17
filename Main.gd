extends Node2D

onready var resetbox = $ResetButtons

func _on_PlayerSideA_loss() -> void:
	resetbox.show()
	get_tree().paused = true
	$PlayerSideB.notifpanel.show()
	$PlayerSideB.winlabel.show()

func _on_PlayerSideB_loss() -> void:
	resetbox.show()
	get_tree().paused = true
	$PlayerSideA.notifpanel.show()
	$PlayerSideA.winlabel.show()

func _on_ResetButton_pressed() -> void:
	if get_tree().reload_current_scene() == OK:
		get_tree().paused = false
