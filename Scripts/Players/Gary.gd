extends YSort

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

onready var tween

#const PauseMenu = preload("res://UI/PauseMenu.tscn")
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
#var pause_menu
var in_bubble = false
var jumping = false

onready var motion_root: KinematicBody2D = $MotionRoot
onready var world_collider = $MotionRoot/CollisionShape2D
onready var anim_tree = $BodyYSort/AnimationTree
onready var anim_player = $BodyYSort/AnimationPlayer

onready var body_y_sort = $BodyYSort
onready var body_visual_root = $BodyYSort/BodyVisualRoot
onready var shadow_y_sort = $ShadowYSort
onready var shadow_visual_root = $ShadowYSort/ShadowVisualRoot

onready var body_sprite = $BodyYSort/BodyVisualRoot/Gary
onready var poof_sprite = $BodyYSort/BodyVisualRoot/Poof
onready var bubble_sprite = $BodyYSort/BodyVisualRoot/Bubble
onready var shadow_sprite = $ShadowYSort/ShadowVisualRoot/ShadowCircle


func _physics_process(delta):
	var freeze = PlayerManager.freeze
	var sleep = PlayerManager.sleep
	var ouch = PlayerManager.ouch
	var drown = PlayerManager.drown
	var loading = SceneManager.loading
	var cutscene = PlayerManager.cutscene
	
	$JumpShape.shape_origin = body_visual_root.global_position
	$JumpShape.origin_z = motion_root.pos_z
	
	#$MotionRoot/CollisionShape2D.disabled = false
	#$JumpShape/CollisionShape2D.disabled = false

	var last_dir = motion_root.last_dir
	
	if freeze and not cutscene:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	
	if abs(motion_root.vel.x) < 1 && abs(motion_root.vel.y) < 1 && abs(motion_root.vel.z) == 0 and not motion_root.jumping and not cutscene and not freeze:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	elif abs(motion_root.vel.z) == 0 and not motion_root.jumping and not cutscene and not freeze:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/blend_position", Vector2(last_dir.x, -last_dir.y))
		
		
	if abs(motion_root.vel.x) < 1 && abs(motion_root.vel.y) < 1 && abs(motion_root.vel.z) == 0 and SceneManager.bubble and not cutscene and not freeze:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	elif abs(motion_root.vel.z) == 0 and SceneManager.bubble and not cutscene and not freeze:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/blend_position", Vector2(last_dir.x, -last_dir.y))
		
	#and motion_root.is_on_ground and not abs(motion_root.vel.z) > 0 and not abs(motion_root.vel.z) < 0 and not PlayerManager.bouncy
		

	if Input.is_action_just_pressed("ui_push") and not freeze and not cutscene:
		#jumping = true
		$BodyYSort/BodyVisualRoot/Gary.z_index = 0
		anim_player.stop()
		anim_tree.active = true
		anim_tree.get("parameters/playback").travel("Jump")
		anim_tree.set("parameters/Jump/blend_position", Vector2(last_dir.x, -last_dir.y) * 2)
		
	if motion_root.jumping and not SceneManager.bubble and not freeze:
		$BodyYSort/BodyVisualRoot/Gary.z_index = 0
		anim_player.stop()
		anim_tree.active = true
		anim_tree.get("parameters/playback").travel("Jump")
		anim_tree.set("parameters/Jump/blend_position", Vector2(last_dir.x, -last_dir.y) * 2)
		
	#if abs(motion_root.vel.z) >1:
	if motion_root.vel.z <0 and freeze:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	
	if motion_root.vel.z <0 and not freeze:
		anim_tree.get("parameters/playback").travel("Fall")
		anim_tree.set("parameters/Fall/blend_position", Vector2(last_dir.x, -last_dir.y) * 2)
		

		
	#if motion_root.is_on_ground:
		#jumping = false
		
	if Input.is_action_just_pressed("ui_push") and not freeze and in_bubble:
		pop()
		
		#SE.effect("Bubble Pop")
		#in_bubble = false
		#SceneManager.bubble = false
		#$BubblePlayer.play("pop")
		#motion_root.bubble = false
		#motion_root.popped = true
		
		
	if sleep:
		shadow_sprite.offset.x = -500
		anim_tree.active = false
		anim_player.playback_speed = 0.3
		anim_player.play("sleep")
		
	if ouch:
		anim_tree.active = false
		anim_player.play("ouch")
		#$MotionRoot/CollisionShape2D.disabled = true
		#$JumpShape/CollisionShape2D.disabled = true
		
	#	$MotionRoot/CollisionShape2D.set_deferred("disabled", true)
	#	$JumpShape/CollisionShape2D.set_deferred("disabled", true)
		
	if not ouch and not drown and not sleep and not cutscene:
		anim_player.stop()
		anim_tree.active = true
		#$MotionRoot/CollisionShape2D.set_deferred("disabled", false)
	#	$JumpShape/CollisionShape2D.set_deferred("disabled", false)
		
	if drown:
		anim_tree.active = false
		anim_player.play("drown")
	#	$MotionRoot/CollisionShape2D.disabled = true
	#	$JumpShape/CollisionShape2D.disabled = true
		
		#$MotionRoot/CollisionShape2D.set_deferred("disabled", true)
		#$JumpShape/CollisionShape2D.set_deferred("disabled", true)
		
		
	if not sleep:
		shadow_sprite.offset.x = 0
		
	if loading:
		body_sprite.offset.y = -100000
		shadow_sprite.offset.y = -100000
		
	if not loading:
		body_sprite.offset.y = 0
		shadow_sprite.offset.y = 0
	
	var draw_pos_z = motion_root.pos_z
	var draw_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.floor_z))
	var draw_shadow_z = motion_root.shadow_z
	var draw_shadow_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.shadow_z))
	
	body_sprite.height = motion_root.pos_z
	bubble_sprite.height = motion_root.pos_z
	shadow_sprite.height = motion_root.shadow_z + 1
	
	body_y_sort.global_position = Vector2(motion_root.global_position.x, draw_y_sort)
	body_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	shadow_y_sort.global_position = Vector2(motion_root.global_position.x, draw_shadow_y_sort)
	shadow_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_shadow_z)

func bubble():
	SE.effect("Bubble Enter")
	in_bubble = true
	motion_root.bubble = true
	$JumpShape.bubble = true
	$JumpShape.reset_shape()
	$BubblePlayer.play("enter")
	yield(get_tree().create_timer(0.4), "timeout")
	$BubblePlayer.play("idle")

func pop():
	SE.effect("Bubble Pop")
	in_bubble = false
	SceneManager.bubble = false
	$BubblePlayer.play("pop")
	motion_root.bubble = false
	motion_root.popped = true
	$JumpShape.bubble = false
	$JumpShape.popped = true
	$JumpShape.reset_shape()
	bubble_check()
	
func bubble_reset():
	in_bubble = false
	SceneManager.bubble = false
	$BubblePlayer.play("RESET")
	$JumpShape.reset_shape()
	
func bubble_check():
	yield(get_tree().create_timer(0.2), "timeout")
	if not SceneManager.bubble:
		bubble_reset()
		
func anim_reset():
	#anim_player.play("RESET")
	anim_tree.active = true
	motion_root.last_dir = Vector2(0, 0)
	anim_tree.get("parameters/playback").travel("Idle")
	
func set_right():
	#motion_root.last_dir = Vector2(1, 1)
	anim_player.play("shadow_reset")
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", Vector2(1, -1))
	
	
func set_right_f():
	#motion_root.last_dir = Vector2(1, 1)
	anim_player.play("shadow_reset")
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", Vector2(-1, -1))
	motion_root.last_dir = Vector2(-1, -1)
	
func set_left():
	#motion_root.last_dir = Vector2(1, 1)
	anim_player.play("shadow_reset")
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", Vector2(1, 1))
	motion_root.last_dir = Vector2(1, -1)
	
func set_left_f():
	#motion_root.last_dir = Vector2(1, 1)
	anim_player.play("shadow_reset")
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", Vector2(-1, 1))
	motion_root.last_dir = Vector2(-1, 1)
	
func walk():
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Walk")
	anim_tree.set("parameters/Walk/blend_position", Vector2(motion_root.last_dir.x, -motion_root.last_dir.y))
		
func walk_right():
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Walk")
	anim_tree.set("parameters/Walk/blend_position", Vector2(1, -1))
	motion_root.last_dir = Vector2(1, 1)
	
func walk_right_f():
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Walk")
	anim_tree.set("parameters/Walk/blend_position", Vector2(-1, -1))
	motion_root.last_dir = Vector2(-1, -1)
	
func walk_left():
	anim_tree.active = true
	anim_tree.get("parameters/playback").travel("Walk")
	anim_tree.set("parameters/Walk/blend_position", Vector2(1, 1))
	motion_root.last_dir = Vector2(1, -1)
	
func animation(var name: String):
	anim_tree.active = false
	anim_player.play(name)
	
func battle_ready():
	anim_tree.active = false
	anim_player.play("battle_ready")
	
func smile():
	anim_tree.active = false
	anim_player.play("smile")
	
func shock_back_jump():
	anim_tree.active = false
	anim_player.play("shock_back_jump")
	
func back_hop():
	anim_tree.active = false
	anim_player.play("back_hop")
	
func back_hop_f():
	anim_tree.active = false
	anim_player.play("back_hop_f")

func shadow_update():
	shadow_sprite._generate_meshes()
