extends Node2D

onready var Gary = PlayerManager.player_instance


func _input(event):
	if Input.is_action_pressed("ui_accept"):
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.animation("hold_seed")
