extends StaticBody2D

var collision_shapes = []
var motion_root = null

func _ready():
	discover_shapes()

func discover_shapes():
	collision_shapes = []
	for child in get_children():
		if child != null:
			collision_shapes.push_back(child)

func _physics_process(delta):
	if not motion_root:
		# Getting gary. Pretty stupid way to do it. But gary is spawned at runtime...
		motion_root = PlayerManager.player_motion_root
	
	if motion_root:
		var player_z = motion_root.pos_z
		
		for shape in collision_shapes:
			if shape.height <= player_z:
				motion_root.add_collision_exception_with(self)
			else:
				motion_root.remove_collision_exception_with(self)
