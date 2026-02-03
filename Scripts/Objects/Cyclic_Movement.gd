extends Node2D


export var speed : float
export var movement_type : int

var Positions = []


func _ready():		
	for x in $Positions.get_children():
		Positions.append(x.global_position)
	
	for child in $Platforms.get_children():
		child.Positions = Positions.duplicate()
		child.speed = speed
		child.movement_type = movement_type
