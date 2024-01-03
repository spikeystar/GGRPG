extends StaticBody2D

export var height = 0 setget _set_height

var collision_shapes = []
var motion_root = null

func _ready():
	discover_shapes()

func _set_height(new_height):
	height = new_height
	for shape in collision_shapes:
		if shape and "height" in shape:
			shape.height = height

func discover_shapes():
	collision_shapes = []
	for child in get_children():
		if child != null:
			collision_shapes.push_back(child)

func _physics_process(delta):
	
	# TODO: Detect player / NPCs by using an Area2D, instead of only colliding for player
	
	if not motion_root:
		# Getting gary. Pretty stupid way to do it. But gary is spawned at runtime...
		motion_root = PlayerManager.player_motion_root
	
	if motion_root:
		for shape in collision_shapes:
			if not weakref(shape).get_ref():
				discover_shapes()
				break
			call_deferred("_manage_collision_exceptions_between", shape, motion_root)
			

func _manage_collision_exceptions_between(shape, motion_root):
	if shape.height <= motion_root.pos_z:
		motion_root.add_collision_exception_with(self)
	else:
		motion_root.remove_collision_exception_with(self)
