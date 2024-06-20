extends KinematicBody2D

const LOWEST_Z: int = 0;
const HIGHEST_Z : int = 512;

export var spawn_z = 0
export var player_acceleration = 12
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

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
var freeze = PlayerManager.freeze

var rng = RandomNumberGenerator.new()
var wander_range = Vector2(rng.randi_range(-100, 100), rng.randi_range(-100, 100))
var direction = (wander_range - self.position).normalized()

enum {IDLE,
WANDER,
CHASE
}

export var ACCELERATION = 150
export var MAX_SPEED = 30
export var FRICTION = 100

var velocity = Vector2.ZERO
var state 

var ready = true

func _ready():
	floor_z = spawn_z
	pos_z = spawn_z
	state = WANDER
	
	yield(get_tree().create_timer(0.1), "timeout")
	
func _physics_process(delta):
	is_on_ground = pos_z <= floor_z + 4
	
	update_floor()
	
	match state:
		IDLE:
			MAX_SPEED = 35
			FRICTION = 1000
			velocity = 0
			#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		WANDER:
			#sprite.speed_scale = 0.75
			MAX_SPEED = 35
			if ready and not freeze:
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				#yield(get_tree().create_timer(4), "timeout")
				#ready = false
			#yield(get_tree().create_timer(6), "timeout")
			#ready = true
		CHASE:
			#sprite.speed_scale = 0.95
			MAX_SPEED = 50
			var player = PlayerManager.player_motion_root
			if not freeze:
				var direction = (player.global_position - self.global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = WANDER
		#	seek_player()
			
	velocity = move_and_slide(velocity)

func update_floor():
	floor_z = LOWEST_Z
	ceiling_z = HIGHEST_Z
	for f in floor_layers:
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)

#func seek_player():
	#if PlayerDetection.player_check():
		#state = CHASE
				

func _on_PlayerDetection_body_exited(body):
	state = WANDER
	print("wandering")
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	wander_range = Vector2(rng.randi_range(-100, 100), rng.randi_range(-100, 100))
	direction = (wander_range - self.position).normalized()

func _on_Timer_timeout():
	if state == WANDER:
		state = IDLE
	if state == IDLE:
		state = WANDER
		randomize()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		wander_range = Vector2(rng.randi_range(-100, 100), rng.randi_range(-100, 100))
		direction = (wander_range - self.position).normalized()


func _on_PlayerDetection_start_chase():
	state = CHASE
	print("chasing")
