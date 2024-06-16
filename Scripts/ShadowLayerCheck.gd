extends Area2D

const LOWEST_Z : int = 0
const HIGHEST_Z : int = 512

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
	var ceiling_z = HIGHEST_Z
	for area in get_overlapping_areas():
		var check_floor_z = 0
		var check_ceiling_z = -128
		if "height" in area:
			check_floor_z = area.height
		if "bottom" in area:
			check_ceiling_z = area.bottom
		if check_floor_z <= motion_root.pos_z:
			floor_z = max(floor_z, check_floor_z)
		else:
			ceiling_z = min(ceiling_z, check_ceiling_z)
	motion_root.shadow_z = floor_z

#func _on_area_shape_entered(_area_rid : RID, area : Area2D, area_shape_index : int, _local_shape_index : int):
#
#	if !area:
#		return
#	var shape = area
#
#	if shape.has_method("floor_check"):
#		var index = floor_layers.find(shape)
#
#		if index == -1:
#			floor_layers.append(shape)
#			update_floor()
#
#
#func _on_area_shape_exited(_area_rid : RID, area : Area2D, area_shape_index : int, _local_shape_index : int):
#
#	if !area:
#		return
#	var shape = area
#
#	if shape.has_method("floor_check"):
#		var index = floor_layers.find(shape)
#
#		if index != -1:
#			floor_layers.remove(index)
#			update_floor()
