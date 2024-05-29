# When the player enters a doorway to another scene,
# this defines the position the player will spawn at in the new scene

extends Node2D

export var door_name : String
export var direction : Vector2
export var height : int

var is_current_spawn = false

func _ready():
	if PlayerManager.player_motion_root:
		_position_player()
	else:
		call_deferred("_position_player")
	yield(get_tree().create_timer(0.5), "timeout")
	PlayerManager.freeze = false

func _position_player():
	if Global.door_name == door_name:
		var motion_root = PlayerManager.player_motion_root
		if motion_root:
			motion_root.teleport_2d(global_position + Vector2(0.0, height), height)
			motion_root.set_facing_direction(direction)
			is_current_spawn = true
			Global.door_name = ""
			var timer = Timer.new()
			timer.one_shot = true
			add_child(timer)
			timer.connect("timeout", self, "_position_player_deferred")
			timer.start(0.05)
	if Global.door_name == "Default":
		direction = SceneManager.direction
		height = SceneManager.height
		global_position = SceneManager.position
		var motion_root = PlayerManager.player_motion_root
		if motion_root:
			motion_root.teleport_2d(global_position + Vector2(0.0, height), height)
			motion_root.set_facing_direction(direction)
			is_current_spawn = true

func _position_player_deferred():
	var motion_root = PlayerManager.player_motion_root
	if is_current_spawn and motion_root:
		motion_root.teleport_2d(global_position + Vector2(0.0, height), height)
		motion_root.set_facing_direction(direction)
