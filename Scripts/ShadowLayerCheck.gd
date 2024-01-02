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
