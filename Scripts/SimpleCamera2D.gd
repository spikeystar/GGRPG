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
var z_offset = 0;
			
func _process(delta):
	if not motion_root:
		# Getting Gary. Pretty stupid way to do it. But Gary is spawned at runtime...
		motion_root = PlayerManager.player_motion_root
		z_offset = motion_root.pos_z
		
	if motion_root:
		z_offset = min(max(motion_root.shadow_z, motion_root.pos_z), z_offset)
		if z_offset < motion_root.shadow_z:
			z_offset = min(z_offset + vertical_speed * delta, max(motion_root.shadow_z, motion_root.pos_z))
		
		#self.global_position.x = clamp(motion_root.global_position.x + offset.x, minPos.x, maxPos.x)
		#self.global_position.y = clamp(motion_root.global_position.y - y_offset + offset.y, minPos.y, maxPos.y)

