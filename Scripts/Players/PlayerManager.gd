extends Node

const player_scene = preload("res://Players/Gary/Gary.tscn")

var player_instance = null
var player_motion_root = null
var global_position_when_removed = Vector2()
var is_navmesh_ready = false
var freeze = false
var sleep = false

func _ready():
	spawn_player()

func spawn_player():
	if weakref(player_instance).get_ref():
		player_instance.queue_free()
	
	player_instance = player_scene.instance()
	player_motion_root = player_instance.find_node("MotionRoot")
	add_player_to_scene()

func remove_player_from_scene():
	is_navmesh_ready = false
	if weakref(player_instance).get_ref():
		global_position_when_removed = player_motion_root.global_position
		player_instance.get_parent().remove_child(player_instance)
		
		# Collision object RIDs can be reused when switching scenes,
		# need to clean up these exceptions or you get weird bugs where player doesn't collide with random shapes
		player_instance.motion_root.floor_layers = []
		for collision_exception in player_instance.motion_root.get_collision_exceptions():
			player_instance.motion_root.remove_collision_exception_with(collision_exception)
		
		add_child(player_instance)

func add_player_to_scene():
	var level_y_sort = get_tree().get_root().get_node_or_null("WorldRoot/YSort")
	if player_instance.get_parent():
		player_instance.get_parent().remove_child(player_instance)
	if level_y_sort:
		level_y_sort.add_child(player_instance)
	else:
		add_child(player_instance)
	
func notify_navmesh_ready():
	is_navmesh_ready = true
