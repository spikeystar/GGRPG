extends Node2D

onready var label = $Label

func _process(delta):
	if SceneManager.victory:
		hide()
