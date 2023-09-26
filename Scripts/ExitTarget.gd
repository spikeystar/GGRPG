extends Node

export var door_name : String;
export var direction : Vector2;
export var height : int;

var motion_root;

func _ready():
	pass

func _physics_process(delta):
	if Global.door_name == door_name:
		if not motion_root:
			# Getting gary. Pretty stupid way to do it. But gary is spawned at runtime...
			motion_root = get_node_or_null("/root/PlayerManager/Gary/MotionRoot")
			
		if motion_root:
			motion_root.teleport2D(self.global_position, height)
			#motion_root.global_position = self.global_position
			#motion_root.vel = Vector3(direction.x, 0, direction.y).normalized()
			Global.door_name = ""
