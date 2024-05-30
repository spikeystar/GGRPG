extends Node2D

onready var Field = []

func _ready():
	Field = get_children()
