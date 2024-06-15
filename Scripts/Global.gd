tool
extends Node

const depth_buffer_script = preload("res://Scripts/Rendering/DepthBuffer.gd")

var current_camera : Camera2D setget _set_current_camera
var depth_buffer : Node2D
var door_name : String
var battle_ended = false
var Collected : Array = []

func _init():
	depth_buffer = Node2D.new()
	depth_buffer.name = "DepthBuffer"
	depth_buffer.set_script(depth_buffer_script)

func _ready():
	if not Engine.is_editor_hint():
		add_child(depth_buffer)

func _set_current_camera(new_current_camera):
	current_camera = new_current_camera
	depth_buffer.notify_camera_changed()

func calculate_y_sort(position: Vector3):
	# Calculate euclidian distance, use as sort order.
	var transform = Transform2D.rotated(-PI / 4)
	var rotated_position = transform.xform(Vector2(position.x, position.y))
	position = Vector3(
		rotated_position.x,
		rotated_position.y,
		position.z
	)
	var y_sort = (
		position.x * (position.x + 1000) +
		position.y * (position.y + 1000) +
		position.z * (position.z + 1000)
	)
	return y_sort

func print_tree(node = null, indent = 0):
	if node == null:
		node = get_tree().root

	var indentation = ""
	for i in range(indent):
		indentation += "  "
	
	print(indentation + node.name)
	
	for child in node.get_children():
		print_tree(child, indent + 1)
