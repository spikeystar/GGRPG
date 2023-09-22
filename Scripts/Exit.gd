extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene

export(int) var direction_x
export(int) var direction_y

func _ready():
	pass
	
func _input(event):
	if get_overlapping_bodies().size() > 0:
		enter()
			
func enter():
	var _ERR = get_tree().change_scene(target_scene)
	
	Global.door_name = name
	
	#$Player.global.position = Global.player_pos
