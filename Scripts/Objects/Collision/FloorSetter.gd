extends Area2D

export var height : float = 0

func _init():
	connect("body_shape_entered", self, "_on_body_shape_entered")
	connect("body_shape_exited", self, "_on_body_shape_exited")

func print_tree(node = null, indent = 0):
	if node == null:
		node = get_tree().root

	var indentation = ""
	for i in range(indent):
		indentation += "  "
	
	print(indentation + node.name)
	
	for child in node.get_children():
		print_tree(child, indent + 1)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is KinematicBody2D and "floor_layers" in body:
		var index = body.floor_layers.find(self)
		
		if index == -1:
			print_debug("added")
			body.floor_layers.append(self)
			body.update_floor()

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body is KinematicBody2D and "floor_layers" in body:
		var index = body.floor_layers.find(self)
		if get_overlapping_bodies().find(body) != -1:
			# This shouldn't happen.
			return

		if index != -1:
			body.floor_layers.remove(index)
			body.update_floor()
			
func floor_check ():
	pass
