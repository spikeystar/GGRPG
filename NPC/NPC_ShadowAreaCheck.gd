extends Area2D

const LOWEST_Z : int = -256;

onready var motion_root = get_parent();

#var floor_layers : Array = []
#var floor_z : float = 0;
#func update_floor():
#	floor_z = LOWEST_Z
#	for f in floor_layers:
#		floor_z = max(floor_z, f.height)
#	motion_root.shadow_z = floor_z
#	print(floor_z)


func _process(delta):
	var floor_z = LOWEST_Z
	for area in get_overlapping_areas():
		if area.has_method("floor_check"):
			floor_z = max(floor_z, area.height)
	motion_root.shadow_z = floor_z
