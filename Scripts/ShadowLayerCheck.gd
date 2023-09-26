extends Area2D
const LOWEST_Y : int = -256;

onready var motionRoot = get_parent();

#var floor_layers : Array = []
#var floor_y : float = 0;
#func update_floor():
#	floor_y = LOWEST_Y
#	for f in floor_layers:
#		floor_y = max(floor_y, f.height)
#	motionRoot.shadow_y = floor_y
#	print(floor_y)


func _process(delta):
	var floor_y = LOWEST_Y
	for area in get_overlapping_areas():
		if area.has_method("floor_check"):
			floor_y = max(floor_y, area.height)
	motionRoot.shadow_y = floor_y

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
