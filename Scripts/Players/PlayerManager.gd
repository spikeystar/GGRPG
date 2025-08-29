extends Node

const player_scene = preload("res://Players/Gary/Gary.tscn")

var player_instance = null
var player_motion_root = null
var player_jump_shape = null
var player_shadow = null
var global_position_when_removed = Vector2()
var is_navmesh_ready = false
var freeze = false
var sleep = false
var ongoing = false
var jumping = false
var ouch = false
var drown = false
var bouncy = false
var jump_disabled = false
var cutscene = false
var pause_delay = false

func _ready():
	spawn_player()
	
func hide_player():
	player_instance.modulate.a = 0
		
func show_player():
	player_instance.modulate.a = 1

func spawn_player():
	if weakref(player_instance).get_ref():
		player_instance.queue_free()
	
	if not SceneManager.loading:
		player_instance = player_scene.instance()
		player_motion_root = player_instance.find_node("MotionRoot")
		player_jump_shape = player_instance.find_node("JumpShape")
		player_shadow = player_instance.find_node("ShadowYSort")
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
	
func hide_shadow():
	player_shadow.hide()

func bubble():
	print("bubble")
	player_instance.bubble()
	
func pop():
	yield(get_tree().create_timer(0.6), "timeout")
	if SceneManager.bubble:
		player_instance.pop()
		SceneManager.bubble = false
		
func bubble_reset():
	if SceneManager.bubble:
		player_instance.bubble_reset()
		SceneManager.bubble = false
		
