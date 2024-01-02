extends Node2D

export var door_name : String;
export var direction : Vector2;
export var height : int;

var motion_root;

func _ready():
	if PlayerManager.player_motion_root:
		_position_player()
	else:
		call_deferred("_position_player")

func _position_player():
	if Global.door_name == door_name:
		var motion_root = PlayerManager.player_motion_root
		if motion_root:
			motion_root.teleport_2d(global_position, height)
			Global.door_name = ""

