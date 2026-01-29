extends YSort

var stopped = false
var dead = false
var used = false

export var height : int

export var spawn_z = 0
export var min_speed : float
export var max_speed : float

onready var PlayerDetection = $MotionRoot/PlayerDetection
onready var Ouch = $MotionRoot/Ouch
onready var sprite = $BodyYSort/BodyVisualRoot/Sprite

var freeze = PlayerManager.freeze

onready var motion_root: KinematicBody2D = $MotionRoot
onready var world_collider = $MotionRoot/CollisionShape2D
#onready var anim_tree = $BodyYSort/AnimationTree
onready var anim_player = $AnimationPlayer

onready var body_y_sort = $BodyYSort
onready var body_visual_root = $BodyYSort/BodyVisualRoot
onready var shadow_y_sort = $ShadowYSort
onready var shadow_visual_root = $ShadowYSort/ShadowVisualRoot

onready var body_sprite = $BodyYSort/BodyVisualRoot/Sprite
onready var shadow_sprite = $ShadowYSort/ShadowVisualRoot/ShadowCircle

var motion_root_z

const VEL_EPSILON = 0.1
const VEL_ANIM_MAX = 30

func _ready():
	pass

func _physics_process(delta):
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
	
	$MotionRoot/PlayerDetection.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	$MotionRoot/Ouch.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	

func delete():
	dead = true

func _on_PlayerDetection_body_entered(body):	
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and not dead:
		used = true
		$AnimationPlayer.play("destruct")
		stopped = true
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not used and not dead:
		used = true
		$AnimationPlayer.play("destruct")
		stopped = true

