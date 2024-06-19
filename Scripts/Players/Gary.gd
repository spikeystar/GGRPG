extends YSort

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

const PauseMenu = preload("res://UI/PauseMenu.tscn")
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
var pause_menu

onready var motion_root: KinematicBody2D = $MotionRoot
onready var world_collider = $MotionRoot/CollisionShape2D
onready var anim_tree = $BodyYSort/AnimationTree
onready var anim_player = $BodyYSort/AnimationPlayer

onready var body_y_sort = $BodyYSort
onready var body_visual_root = $BodyYSort/BodyVisualRoot
onready var shadow_y_sort = $ShadowYSort
onready var shadow_visual_root = $ShadowYSort/ShadowVisualRoot

onready var body_sprite = $BodyYSort/BodyVisualRoot/Gary
onready var shadow_sprite = $ShadowYSort/ShadowVisualRoot/ShadowCircle

func _physics_process(delta):
	var freeze = PlayerManager.freeze
	var sleep = PlayerManager.sleep

	var last_dir = motion_root.last_dir
	if abs(motion_root.vel.x) < 1 && abs(motion_root.vel.y) < 1:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/blend_position", Vector2(last_dir.x, -last_dir.y))
		
	if abs(motion_root.vel.z) >1:
		anim_tree.get("parameters/playback").travel("Fall")
		anim_tree.set("parameters/Fall/blend_position", Vector2(last_dir.x, -last_dir.y) * 2)
	
	if Input.is_action_pressed("ui_push") and not freeze:
		shadow_sprite.show()
		$BodyYSort/BodyVisualRoot/Gary.z_index = 0
		anim_player.stop()
		anim_tree.active = true
		anim_tree.get("parameters/playback").travel("Jump")
		anim_tree.set("parameters/Jump/blend_position", Vector2(last_dir.x, -last_dir.y) * 2)
		
	if sleep:
		shadow_sprite.hide()
		anim_tree.active = false
		anim_player.playback_speed = 0.3
		anim_player.play("sleep")
		
	
	var draw_pos_z = motion_root.pos_z
	var draw_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.floor_z))
	var draw_shadow_z = motion_root.shadow_z
	var draw_shadow_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.shadow_z))
	
	body_sprite.height = motion_root.pos_z
	shadow_sprite.height = motion_root.shadow_z + 1
	
	body_y_sort.global_position = Vector2(motion_root.global_position.x, draw_y_sort)
	body_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	shadow_y_sort.global_position = Vector2(motion_root.global_position.x, draw_shadow_y_sort)
	shadow_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_shadow_z)

func _process(delta):
	pass
	#if PlayerManager.sleep:
		#shadow_sprite.hide()
		#anim_tree.active = false
		#anim_player.playback_speed = 0.3
		#anim_player.play("sleep")
