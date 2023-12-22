extends Node

const player_scene = preload("res://Players/Gary/Gary.tscn")

var player_instance = null
var player_motion_root = null

func _ready():
	spawn_player()

func spawn_player():
	if weakref(player_instance).get_ref():
		player_instance.queue_free()
	
	player_instance = player_scene.instance()
	player_motion_root = player_instance.find_node("MotionRoot")
	add_player_to_scene()

func remove_player_from_scene():
	if weakref(player_instance).get_ref():
		player_instance.get_parent().remove_child(player_instance)
		add_child(player_instance)

func add_player_to_scene():
	var level_y_sort = get_tree().get_root().get_node_or_null("WorldRoot/YSort")
	if level_y_sort:
		level_y_sort.add_child(player_instance)
	else:
		add_child(player_instance)
