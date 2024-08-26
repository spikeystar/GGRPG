extends KinematicBody2D

const LOWEST_Z : int = 0;
const HIGHEST_Z : int = 512;

export var spawn_z = 0
export var player_acceleration = 12
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10
export var player_height = 64

var is_player_motion_root = true

#Movement
var floor_z : float = LOWEST_Z
var ceiling_z : float = HIGHEST_Z
var shadow_z : float = 0
var pos_z : float
var teleport_z : float
var vel : Vector3;
var last_dir: Vector2;
var floor_layers : Array = []
var is_on_ground = true
var is_falling = true
var is_just_teleported = false
var jumping = false
var jump_disabled = false
var bubble = false
var popped = false

func _ready():
	floor_z = spawn_z
	pos_z = spawn_z

func teleport_2d(tp_pos : Vector2, height : int = 0):
	self.global_position = tp_pos
	vel = Vector3.ZERO
	pos_z = height
	floor_z = height
	shadow_z = height
	teleport_z = height
	is_just_teleported = true

func set_facing_direction(direction : Vector2):
	last_dir = direction.normalized()
	

func update_floor():
	floor_z = LOWEST_Z
	ceiling_z = HIGHEST_Z
	for f in floor_layers:
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)

func _physics_process(delta):
	var freeze = PlayerManager.freeze
	var sleep = PlayerManager.sleep
	var ongoing = PlayerManager.ongoing
	var bouncy = PlayerManager.bouncy
	# Floor height could change at any time with movable platforms
	update_floor()
	
	if is_just_teleported:
		is_just_teleported = false
		var prev_global_position = global_position
		move_and_slide(Vector2(0,0))
		global_position = prev_global_position
		vel.z = 0.0
		pos_z = teleport_z
		floor_z = teleport_z
		shadow_z = teleport_z

	is_on_ground = pos_z <= floor_z + 2
	
	# Input direction
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("ui_right") and not freeze and not sleep:
		input_dir.x += 1.0
	if Input.is_action_pressed("ui_left") and not freeze and not sleep:
		input_dir.x -= 1.0
	if Input.is_action_pressed("ui_down") and not freeze and not sleep:
		input_dir.y -= 1.0
	if Input.is_action_pressed("ui_up") and not freeze and not sleep:
		input_dir.y += 1.0
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
	
	if Input.is_action_just_pressed("ui_push") and is_on_ground and not freeze and not jump_disabled:
		is_on_ground = false
		PlayerManager.sleep = false
		jumping = true
		vel.z = jump_velocity
		#jump_disabled = true
		
		if not bouncy:
			SE.effect("Jump")
		
	if bouncy:
		is_on_ground = false
		jumping = true
		gravity = 890
		jump_velocity = 220
		vel.z = jump_velocity
		
	if not bouncy:
		gravity = 940
		jump_velocity = 300
		
	if Input.is_action_just_pressed("ui_push") and sleep and not ongoing:
		PlayerManager.freeze = false
		
	
	vel.x += input_dir.x * player_acceleration * delta
	vel.y += input_dir.y * player_acceleration * delta
	vel.x *= clamp(1 - (delta * player_friction), 0, 1);
	vel.y *= clamp(1 - (delta * player_friction), 0, 1);
	
	if vel.length_squared() > 5:
		last_dir = Vector2(vel.x, vel.y).normalized()
		
	
	if not is_on_ground and not bubble:
		vel.z -= gravity * delta
		#$CollisionShape2D.global_position += Vector2(0, -(vel.z * delta * 1.2))
	elif bubble:
		vel.z = 0
		#pos_z = floor_z
	elif popped:
		is_on_ground = false
		vel.z -= gravity * delta
		popped = false
	else:
		vel.z = 0
		pos_z = floor_z
		#jumping = false
	
	pos_z += vel.z * delta
	
	var current_max_z = ceiling_z - player_height - 1
	pos_z = min(current_max_z, pos_z)
	pos_z = max(floor_z, pos_z)
	
	if pos_z == current_max_z and vel.z > 0:
		vel.z = 0
	
	var delta2D = Vector2(vel.x, -vel.y * 0.5)
	move_and_slide(delta2D)
		
	#if is_on_ground:
		#yield(get_tree().create_timer(0.3), "timeout")
		#jumping = false
