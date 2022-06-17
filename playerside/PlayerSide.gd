tool

extends Node2D

export(int) var health: int = 5
export(int) var dodges: int = 3
export(Color) var handcolor

# By exporting these I can animate them
export(bool) var attacking = false
export(bool) var dodging = false

onready var healthbar = $Health/ProgressBar
onready var hitplayer = $HitSoundPlayer
onready var handsprite = $Hand/Sprite

onready var notifpanel = $PanelContainer
onready var winlabel = $PanelContainer/WinLabel
onready var losslabel = $PanelContainer/LossLabel

onready var animtree = $Hand/AnimationPlayer/AnimationTree
onready var smachine = animtree["parameters/StateMachine/playback"]

signal loss

func _ready() -> void:
	healthbar.set_value(health)
	handsprite.set_modulate(handcolor)


func _on_Hurtbox_area_entered(_area: Area2D) -> void:
	if not (attacking or dodging):
		health -= 1
		healthbar.set_value(health)
		
		if health <= 0:
			emit_signal("loss")
			notifpanel.show()
			losslabel.show()
	else:
		hitplayer.play()


func _on_Buttons_hit_left() -> void:
	smachine.travel("AttackLeft")
	animtree["parameters/OneShot/active"] = true



func _on_Buttons_hit_right() -> void:
	smachine.travel("AttackRight")
	animtree["parameters/OneShot/active"] = true


func _on_Buttons_hit_center() -> void:
	smachine.travel("AttackCenter")
	animtree["parameters/OneShot/active"] = true


func _on_Buttons_dodge_left() -> void:
	smachine.travel("DodgeLeft")
	animtree["parameters/OneShot/active"] = true
	animtree["parameters/Seek/seek_position"] = 1.6


func _on_Buttons_dodge_right() -> void:
	smachine.travel("DodgeRight")
	animtree["parameters/OneShot/active"] = true
	animtree["parameters/Seek/seek_position"] = 4.6

func _on_Buttons_dodge_center() -> void:
	smachine.travel("DodgeCenter")
	animtree["parameters/OneShot/active"] = true
	animtree["parameters/Seek/seek_position"] = 3 * (randi() % 2)
