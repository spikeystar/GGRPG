extends Node2D


var Positions = []

export var speed : int

func _ready():
	Positions = $Positions.get_children()
	
	for child in $Platforms.get_children():
		child.Positions = Positions.duplicate()
		child.speed = speed
		
