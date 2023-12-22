extends YSort
const LOWEST_Z : int = -256;

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

onready var motion_root: KinematicBody2D = $MotionRoot
onready var world_collider = $MotionRoot/CollisionShape2D
onready var anim_tree = $BodyYSort/AnimationTree

onready var body_y_sort = $BodyYSort
onready var body_visual_root = $BodyYSort/BodyVisualRoot
onready var shadow_y_sort = $ShadowYSort
onready var shadow_visual_root = $ShadowYSort/ShadowVisualRoot

func _physics_process(delta):

	var last_dir = motion_root.last_dir
	if abs(motion_root.vel.x) < 1 && abs(motion_root.vel.y) < 1:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/blend_position", Vector2(last_dir.x, -last_dir.y))

	if !motion_root.is_on_ground:
		anim_tree.get("parameters/playback").travel("Jump")
		anim_tree.set("parameters/Jump/blend_position", Vector2(last_dir.x, -last_dir.y))
	
	var draw_pos_z = motion_root.pos_z
	var y_offset_pos_z = motion_root.floor_z
	var draw_shadow_z = motion_root.shadow_z
	
	body_y_sort.global_position = motion_root.global_position + Vector2(0.0, y_offset_pos_z)
	body_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	shadow_y_sort.global_position = motion_root.global_position + Vector2(0.0, draw_shadow_z)
	shadow_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_shadow_z)
