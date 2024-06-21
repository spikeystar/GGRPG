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
var ground_enemy

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
var wander_range = Vector2(rng.randi_range(-20, 20), rng.randi_range(-20, 20))
var direction = (wander_range - self.position).normalized()

enum {IDLE,
RETURN,
WANDER,
CHASE
}

export var ACCELERATION = 75
export var MAX_SPEED = 30
export var FRICTION = 100

var velocity = Vector2.ZERO
var origin = Vector2()
var state 

var ready = false

func _ready():
	origin = self.global_position
	print(origin)
	floor_z = spawn_z
	pos_z = spawn_z
	state = IDLE
	
func _physics_process(delta):
	#print(state)
	is_on_ground = pos_z <= floor_z + 4
	update_floor()
	
	if state == WANDER and ready:
		ready = false
		random_direction()
		
	if is_on_wall():
		direction -= Vector2(1, 1)
	
	match state:
		IDLE:
			#print("idle")
			velocity = Vector2.ZERO
			yield(get_tree().create_timer(2), "timeout")
			state = WANDER
		RETURN:
			#print(self.global_position)
			var return_spot = (origin - self.global_position).normalized()
			velocity = velocity.move_toward(return_spot * MAX_SPEED, ACCELERATION * delta)
			if self.global_position.round() == origin:
				velocity = Vector2.ZERO
				state = IDLE
				ready = true
				#print("tadaa")
			#if range(origin, (origin + Vector2(5,5))).has(self.global_position):
				#print("hello")
				#state = IDLE
		WANDER:
			#print("wander")
			MAX_SPEED = 35
			velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			if not ground_enemy:
				pos_z = pos_z * delta
			yield(get_tree().create_timer(4), "timeout")
			state = RETURN
		CHASE:
			MAX_SPEED = 50
			var player = PlayerManager.player_motion_root
			if not freeze:
				var direction = (player.global_position - self.global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = RETURN


	velocity = move_and_slide(velocity)

func update_floor():
	floor_z = LOWEST_Z
	ceiling_z = HIGHEST_Z
	for f in floor_layers:
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)

	return
	
	#if state == WANDER:
	#	state = IDLE
	#if state == IDLE:
		#state = WANDER

func random_direction():
	#print("random!")
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	wander_range = Vector2(rng.randi_range(-20, 20), rng.randi_range(-20, 20))
	direction = (wander_range - self.position).normalized()

func _on_PlayerDetection_start_chase():
	state = CHASE
	print("chasing")

func _on_PlayerDetection_stop_chase():
	#ACCELERATION = 50
	yield(get_tree().create_timer(2), "timeout")
	state = RETURN
	print("return")

func _on_Timer_timeout():
	pass
	#random_direction()
