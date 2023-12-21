extends Node2D

func _ready():
	#$Gary.global_position = Global.player_pos
	print(Global.door_name)
	var direction_x = 0
	var direction_y = 0
	
	if Global.door_name:
		var door_node = find_node(Global.door_name)
		if door_node:
			$Gary.global_position = door_node.global_position
			#$Gary.direction_x = door_node.direction_x
			#$Gary.direction_y = door_node.direction_y
