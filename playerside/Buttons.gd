extends Control

signal hit_left
signal hit_right
signal hit_center

signal dodge_left
signal dodge_right
signal dodge_center

export(float) var DODGE_DELAY = 0.7
export(float) var ATTACK_DELAY = 1.0

var dodge_timer = 0.0
var attack_timer = 0.0

var currently_pressed = {
	"hl": false,
	"hr": false,
	"dl": false,
	"dr": false,
}

func _process(delta: float) -> void:
	if dodge_timer > 0.0:
		dodge_timer -= delta
	
	if attack_timer > 0.0:
		attack_timer -= delta


func _on_DodgeLeftButton_pressed() -> void:
	currently_pressed.dl = true


func _on_HitLeftButton_pressed() -> void:
	currently_pressed.hl = true


func _on_HitRightButton_pressed() -> void:
	currently_pressed.hr = true


func _on_DodgeRightButton_pressed() -> void:
	currently_pressed.dr = true


func _on_Hit_released() -> void:
	if attack_timer > 0:
		return
	
	if currently_pressed.hl and currently_pressed.hr:
		emit_signal("hit_center")
	elif currently_pressed.hl:
		emit_signal("hit_left")
	elif currently_pressed.hr:
		emit_signal("hit_right")

	reset_currently_pressed()
	attack_timer = ATTACK_DELAY

func _on_Dodge_released() -> void:
	if dodge_timer > 0:
		return
	
	if currently_pressed.dl and currently_pressed.dr:
		emit_signal("dodge_center")
	elif currently_pressed.dl:
		emit_signal("dodge_left")
	elif currently_pressed.dr:
		emit_signal("dodge_right")

	reset_currently_pressed()
	dodge_timer = DODGE_DELAY


func reset_currently_pressed() -> void:
	currently_pressed = {
		"hl": false,
		"hr": false,
		"dl": false,
		"dr": false,
	}
