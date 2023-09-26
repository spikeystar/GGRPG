extends Node

# Ideally you'd want a more complex camera system
# Some way to set boundairies with area

export var vertical_speed : float = 64;
export var offset : Vector2;
export var minPos : Vector2;
export var maxPos : Vector2;


func print_tree(node = null, indent = 0):
	if node == null:
		node = get_tree().root

	var indentation = ""
	for i in range(indent):
		indentation += "  "
	
	print(indentation + node.name)
	
	for child in node.get_children():
		print_tree(child, indent + 1)

var motion_root
var y_offset = 0;
			
func _process(delta):
	if not motion_root:
		# Getting gary. Pretty stupid way to do it. But gary is spawned at runtime...
		motion_root = get_node_or_null("/root/PlayerManager/Gary/MotionRoot")
		y_offset = motion_root.pos_y
		
	if motion_root:
		y_offset = min(max(motion_root.shadow_y, motion_root.pos_y), y_offset)
		if y_offset < motion_root.shadow_y:
			y_offset = min(y_offset + vertical_speed * delta, max(motion_root.shadow_y, motion_root.pos_y))
		
		self.global_position.x = clamp(motion_root.global_position.x + offset.x, minPos.x, maxPos.x)
		self.global_position.y = clamp(motion_root.global_position.y - y_offset + offset.y, minPos.y, maxPos.y)

