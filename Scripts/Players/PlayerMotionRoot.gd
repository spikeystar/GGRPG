extends KinematicBody2D

const HIGHEST_Z: int = 0;
const LOWEST_Z: int = 0;

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

#Movement
var floor_z : float = LOWEST_Z;
var shadow_z : float = 0;
var pos_z : float;
var vel : Vector3;
var last_dir: Vector2;
var floor_layers : Array = []
var is_on_ground = true

func _ready():
	floor_z = spawn_z
	pos_z = spawn_z

func teleport2D(tp_pos : Vector2, height : int = 0):
	self.global_position = tp_pos
	move_and_slide(Vector2(0,0))
	pos_z = height

func update_floor():
	floor_z = LOWEST_Z
	for f in floor_layers:
		floor_z = max(floor_z, f.height)

func _physics_process(delta):
	is_on_ground = pos_z <= floor_z
	
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
		
		
	if Input.is_action_pressed("ui_push") and is_on_ground:
		is_on_ground = false
		vel.z = jump_velocity
	
	vel.x += input_dir.x * player_acceleration * delta
	vel.y += input_dir.y * player_acceleration * delta
	vel.x *= clamp(1 - (delta * player_friction), 0, 1);
	vel.y *= clamp(1 - (delta * player_friction), 0, 1);
	
	if vel.length_squared() > 5:
		last_dir = Vector2(vel.x, vel.y).normalized()
	
	if not is_on_ground:
		vel.z -= gravity * delta
	else:
		vel.z = 0
	
	pos_z += vel.z * delta
	pos_z = max(floor_z, pos_z)
	
	var delta2D = Vector2(vel.x, -vel.y * 0.5)
	move_and_slide(delta2D)
