extends KinematicBody2D
const LOWEST_Y : int = -256;

export var spawn_y = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10


onready var world_collider = $CollisionShape2D
onready var anim_tree = $VisualRoot/AnimationTree

onready var visual_tr = $VisualRoot
onready var shadow_tr = $ShadowCircle

#Movement
var floor_y : float = LOWEST_Y;
var shadow_y : float = 0;
var pos_y : float;
var vel : Vector3;
var last_dir: Vector2;
var floor_layers : Array = []

func _ready():
	floor_y = spawn_y
	pos_y = spawn_y

func teleport2D(tp_pos : Vector2, height : int = 0):
	self.global_position = tp_pos
	move_and_slide(Vector2(0,0))
	pos_y = height

func update_floor():
	floor_y = LOWEST_Y
	for f in floor_layers:
		floor_y = max(floor_y, f.height)

func _physics_process(delta):
	var isOnGround = pos_y <= floor_y
	
	# Input direction
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1.0
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1.0
	if Input.is_action_pressed("ui_down"):
		input_dir.y -= 1.0
	if Input.is_action_pressed("ui_up"):
		input_dir.y += 1.0
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
	if Input.is_action_pressed("ui_push") and isOnGround:
		isOnGround = false
		vel.y = jump_velocity
	
	vel.x += input_dir.x * player_acceleration * delta
	vel.z += input_dir.y * player_acceleration * delta
	vel.x *= clamp(1 - (delta * player_friction), 0, 1);
	vel.z *= clamp(1 - (delta * player_friction), 0, 1);
	
	
	if vel.length_squared() > 5:
		last_dir = Vector2(vel.x, vel.z).normalized()
	
	if not isOnGround:
		vel.y -= gravity * delta
	else:
		vel.y = 0
	
	pos_y += vel.y * delta
	pos_y = max(floor_y, pos_y)
	
	var delta2D = Vector2(vel.x, -vel.z * 0.5)
	move_and_slide(delta2D)

	if abs(vel.x) < 1 && abs(vel.z) < 1:
		anim_tree.get("parameters/playback").travel("Idle")
		anim_tree.set("parameters/Idle/blend_position", Vector2(last_dir.x, -last_dir.y))
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/Walk/blend_position", Vector2(last_dir.x, -last_dir.y))

	if !isOnGround:
		anim_tree.get("parameters/playback").travel("Jump")
		anim_tree.set("parameters/Jump/blend_position", Vector2(last_dir.x, -last_dir.y))
#
	visual_tr.position = Vector2(0, -pos_y)
	shadow_tr.position = Vector2(0, -shadow_y)
