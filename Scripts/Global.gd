tool
extends Node

var door_name : String;

func calculate_y_sort(position: Vector3):
	# Calculate euclidian distance, use as sort order.
	var transform = Transform2D.rotated(-45.0).scaled(Vector2(1.0, 0.5))
	var rotated_position = transform.xform(Vector2(position.x, position.y))
	position = Vector3(
		rotated_position.x,
		rotated_position.y,
		position.z * 0.6
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
