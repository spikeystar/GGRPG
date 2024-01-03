extends Area2D

export var height : float = 0 setget _set_height

func _init():
	connect("body_shape_entered", self, "_on_body_shape_entered")
	connect("body_shape_exited", self, "_on_body_shape_exited")

func _set_height(new_height):
	height = new_height
	for shape in get_children():
		if shape and "height" in shape:
			shape.height = height

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is KinematicBody2D and "floor_layers" in body:
		var index = body.floor_layers.find(self)
		
		if index == -1:
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
