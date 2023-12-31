tool
extends Camera2D

# Ideally you'd want a more complex camera system
# Some way to set boundairies with area

export var vertical_speed : float = 64
export var player_offset : Vector2
export var minPos : Vector2
export var maxPos : Vector2
export var follow_player = false

var motion_root
var z_offset = 0
var is_in_editor = Engine.is_editor_hint()

func _ready():
	Global.current_camera = self

func _process(delta):
	if not is_in_editor:
		if not motion_root:
			# Getting Gary. Pretty stupid way to do it. But Gary is spawned at runtime...
			motion_root = PlayerManager.player_motion_root
			z_offset = motion_root.pos_z
			
		if motion_root:
			z_offset = min(max(motion_root.shadow_z, motion_root.pos_z), z_offset)
			if z_offset < motion_root.shadow_z:
				z_offset = min(z_offset + vertical_speed * delta, max(motion_root.shadow_z, motion_root.pos_z))
			
			if follow_player:
				global_position.x = clamp(motion_root.global_position.x + player_offset.x, minPos.x, maxPos.x)
				global_position.y = clamp(motion_root.global_position.y - z_offset + player_offset.y, minPos.y, maxPos.y)

