extends Node2D

export var scene_enemy : PackedScene

func _ready():
	var enemy = scene_enemy.instance()
	add_child(enemy)
	
	
