extends Node2D

var Positions = []

func _ready():
	Positions = $Positions.get_children()
	
	for child in $Platform.get_children():
		child.Positions = Positions.duplicate()
