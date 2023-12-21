extends Node

onready var player_instance = load("res://Players/Gary/Gary.tscn").instance()

func _ready():
	add_child(player_instance)
