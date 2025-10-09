extends Area2D

# This is the height at which the floor is represented
export var height : float = 0 setget _set_height

export var floating = false
export var flowing = false

var vel : Vector3;

# This is the z-position below the floor where the player can start walking underneath it
export var bottom : float = -128 setget _set_bottom

func _init():
	connect("body_shape_entered", self, "_on_body_shape_entered")
	connect("body_shape_exited", self, "_on_body_shape_exited")

func _set_height(new_height):
	height = new_height
	for shape in get_children():
		if shape and "height" in shape:
			shape.height = height

func _set_bottom(new_bottom):
	bottom = new_bottom
	for shape in get_children():
		if shape and "bottom" in shape:
			shape.bottom = bottom

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
