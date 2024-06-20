extends KinematicBody2D

const LOWEST_Z: int = 0;

export var spawn_z = 0
export var player_acceleration = 12
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

#Movement
var floor_z : float = LOWEST_Z
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

enum {IDLE,
WANDER,
CHASE
}

export var ACCELERATION = 150
export var MAX_SPEED = 50
export var FRICTION = 100

var velocity = Vector2.ZERO
var state 

var ready = true

func _ready():
	floor_z = spawn_z
	pos_z = spawn_z
	state = CHASE
	
func _physics_process(delta):
	is_on_ground = pos_z <= floor_z + 4
	
	match state:
		IDLE:
			FRICTION = 1000
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		WANDER:
			#sprite.speed_scale = 0.75
			if ready and not freeze:
				randomize()
				var wander_range = Vector2(rand_range(-100, 100), rand_range(-100, 100))
				var direction = (wander_range - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				ready = false
				yield(get_tree().create_timer(0.5), "timeout")
				ready = true
		#	seek_player()
		CHASE:
			#sprite.speed_scale = 0.95
			var player = PlayerManager.player_instance
			if player != null and not freeze:
				var direction = (player.position - position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = WANDER
		#	seek_player()
			
	velocity = move_and_slide(velocity)

func update_floor():
	floor_z = LOWEST_Z
	for f in floor_layers:
		floor_z = max(floor_z, f.height)

#func seek_player():
	#if PlayerDetection.player_check():
		#state = CHASE

func _on_PlayerDetection_body_entered(body):
	state = CHASE
	print("chasing")

func _on_PlayerDetection_body_exited(body):
	state = WANDER
	print("wandering")
