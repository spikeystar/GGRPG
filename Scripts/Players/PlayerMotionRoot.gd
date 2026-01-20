extends KinematicBody2D

const LOWEST_Z : int = 0;
const HIGHEST_Z : int = 1512;

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

var ascending = false

var flowing = false
var magic = false
var velocity : Vector2

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
		if "floating" in f and not PlayerManager.drown and not PlayerManager.ouch:
			if PlayerManager.drown or PlayerManager.ouch:
				return
			if f.floating and int(f.height) == int(pos_z):
				ascending = true
				PlayerManager.floating = true
			if not f.floating and int(f.height) == int(pos_z):
				ascending = false
				PlayerManager.floating = false
				
		if "flowing" in f and not PlayerManager.drown and not PlayerManager.ouch:
			if PlayerManager.drown or PlayerManager.ouch:
				return
			if f.flowing and int(f.height) == int(pos_z):
				flowing = true
				velocity = f.velocity
			if not f.flowing and int(f.height) == int(pos_z):
				flowing = false
				
		if "magic" in f and not PlayerManager.drown and not PlayerManager.ouch:
			if PlayerManager.drown or PlayerManager.ouch:
				return
			if f.magic and int(f.height) == int(pos_z):
				magic = true
			if not f.magic and int(f.height) == int(pos_z):
				magic = false
				
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)
			
	if PlayerManager.drown or PlayerManager.ouch:
		velocity = Vector2(0,0)


func _physics_process(delta):
	var freeze = PlayerManager.freeze
	var sleep = PlayerManager.sleep
	var ongoing = PlayerManager.ongoing
	var bouncy = PlayerManager.bouncy
	var cutscene = PlayerManager.cutscene
	var loading = SceneManager.loading
	PlayerManager.jumping = jumping
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

	is_on_ground = int(pos_z) <= int(floor_z + 2)
	
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
	
	if Input.is_action_just_pressed("ui_push") and is_on_ground and not freeze and not jump_disabled and not cutscene and not loading:
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
		
	if not bouncy and not ascending:
		#gravity = 940
		#jump_velocity = 300
		
		gravity = 935
		jump_velocity = 310
		
	if ascending:
		jump_velocity = 420
		
	if ascending and flowing:
		jump_velocity = 460
		
	if magic:
		jump_velocity = 420
		
	if Input.is_action_just_pressed("ui_push") and sleep and not ongoing and not loading:
		PlayerManager.freeze = false
		
	
	vel.x += input_dir.x * player_acceleration * delta
	vel.y += input_dir.y * player_acceleration * delta
	vel.x *= clamp(1 - (delta * player_friction), 0, 1);
	vel.y *= clamp(1 - (delta * player_friction), 0, 1);
	
	if vel.length_squared() > 5:
		last_dir = Vector2(vel.x, vel.y).normalized()
		
	
	if not is_on_ground and not bubble:
		vel.z -= gravity * delta
		jumping = true
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
		
		jumping = false
		
	
	pos_z += vel.z * delta
	
	var current_max_z = ceiling_z - player_height - 1
	pos_z = min(current_max_z, pos_z)
	pos_z = max(floor_z, pos_z)
	
	
	if pos_z == current_max_z and vel.z > 0:
		vel.z = 0
		
	var delta2D = Vector2(vel.x, -vel.y * 0.5)
	
	if flowing:
		move_and_slide(delta2D + velocity)
	else:
		move_and_slide(delta2D)
	
	if vel.x > 0 or vel.y > 0 or vel.z > 0 or vel.x < 0 or vel.y < 0 or vel.z < 0:
		PlayerManager.standing = false
		
	if int(vel.x) == 0 and int(vel.y) == 0 and int(vel.z) == 0:
		PlayerManager.standing = true
		
	PlayerManager.height = pos_z
	PlayerManager.current_position = global_position
	#if is_on_ground:
		#yield(get_tree().create_timer(0.3), "timeout")
		#jumping = false
