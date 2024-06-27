extends KinematicBody2D

const LOWEST_Z: int = 0;
const HIGHEST_Z : int = 512;

export var spawn_z = 0

export var ACCELERATION = 75
export var CHASE_SPEED = 50
export var WANDER_SPEED = 20
export var FRICTION : float 
export var MIN_IDLE_TIME = 1
export var MAX_IDLE_TIME = 3
export var MIN_WANDER_TIME = 1
export var MAX_WANDER_TIME = 1
export var WANDER_RADIUS = 30
export var MAX_CHASE_DISTANCE = 50
export var MAX_Z_DIFF = 10

#Movement
var floor_z : float = LOWEST_Z
var ceiling_z : float = HIGHEST_Z
var shadow_z : float = 0
var pos_z : float
var teleport_z : float
var last_dir: Vector2;
var floor_layers : Array = []
var is_on_ground = true
var is_falling = true
var is_just_teleported = false
var freeze = PlayerManager.freeze
var collided_last_frame = false
var collided_normal : Vector2;
var timer = 0;
var velocity = Vector2.ZERO
var origin = Vector2()
var state
var ground_enemy
var rng : RandomNumberGenerator
var wander_destination : Vector2
var direction = Vector2.ZERO
var player_in_radius = false
var chase_fatigued = false
var initial_z

enum ENEMY_STATE {
IDLE,
RETURN,
WANDER,
CHASE
}





func _ready():
	origin = self.global_position
	rng = RandomNumberGenerator.new()
	#print(origin)
	floor_z = spawn_z
	pos_z = spawn_z
	initial_z = pos_z
	state = ENEMY_STATE.IDLE
	
func _physics_process(delta):
	var player = PlayerManager.player_motion_root
	
	$BattleTrigger.height = pos_z
	
	#print(ENEMY_STATE.keys()[state])
	#print(player.floor_z - floor_z)
	
	is_on_ground = pos_z <= floor_z + 4
	update_floor()
	check_chase()
	
	
	match state:
		ENEMY_STATE.IDLE:
			if not ground_enemy:
				raise_height(delta)
				pos_z = min(initial_z, pos_z)
			
			if timer == 0:
				state = ENEMY_STATE.WANDER
				timer = rng.randf_range(MIN_WANDER_TIME, MAX_WANDER_TIME)
				random_direction()
			
		ENEMY_STATE.RETURN:
			if not ground_enemy:
				raise_height(delta)
				pos_z = min(initial_z, pos_z)
			
			var return_spot = (origin - self.global_position).normalized()
			velocity = velocity.move_toward(return_spot * WANDER_SPEED, ACCELERATION * delta)
			
			if self.global_position.distance_to(origin) < WANDER_RADIUS:
				chase_fatigued = false
				state = ENEMY_STATE.IDLE
				timer = rng.randf_range(MIN_IDLE_TIME, MAX_IDLE_TIME)
				apply_friction(delta)
				
		ENEMY_STATE.WANDER:
			if not ground_enemy:
				raise_height(delta)
				pos_z = min(initial_z, pos_z)
			
			velocity = velocity.move_toward(direction * WANDER_SPEED, ACCELERATION * delta)
			if timer == 0 || wander_destination.distance_to(global_position) < 10:
				timer = 0
				state = ENEMY_STATE.RETURN
				apply_friction(delta)
				
				
		ENEMY_STATE.CHASE:
			
			var diffToTarget = (player.global_position) - self.global_position;
			var direction = diffToTarget.normalized()
			velocity = velocity.move_toward(direction * CHASE_SPEED, ACCELERATION * delta)
			apply_friction(delta)
			
			if not ground_enemy:
				lower_height(delta)
				pos_z = max(player.floor_z, pos_z)




	if collided_last_frame && collided_normal.length_squared() > 0.01 && collided_normal.dot(velocity) < 0:
		collided_normal.normalized()
		velocity = project_onto_plane(velocity, collided_normal)
	move_and_slide(Vector2(velocity.x * 2, velocity.y))
	apply_friction(delta)
	
	collided_last_frame = false
	collided_normal = Vector2.ZERO
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		collided_normal += (global_position - collision.position).normalized()
		collided_last_frame = true
	collided_normal.y *= 2;
	
	timer = max(0, timer - delta)
	
	##update()


##func _draw():
	##var p = Vector2.ZERO
	##draw_line(p, p + project_onto_plane(velocity, collided_normal)  * 1, Color.red, 2)
	##draw_line(p, p + collided_normal * 30, Color.blue, 2)

func update_floor():
	floor_z = LOWEST_Z
	ceiling_z = HIGHEST_Z
	for f in floor_layers:
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)

func random_direction():
	wander_destination = Vector2(rng.randi_range(-WANDER_RADIUS, WANDER_RADIUS), 
								rng.randi_range(-WANDER_RADIUS, WANDER_RADIUS))
	wander_destination = origin + wander_destination.clamped(WANDER_RADIUS)
	direction = (wander_destination - global_position).normalized()

func _on_PlayerDetection_start_chase():
	player_in_radius = true

func _on_PlayerDetection_stop_chase():
	player_in_radius = false
	
func reflect(vector: Vector2, normal: Vector2) -> Vector2:
	normal = normal.normalized()
	return vector - 2 * vector.dot(normal) * normal

func project_onto_plane(vector: Vector2, normal: Vector2) -> Vector2:
	normal = normal.normalized()
	return vector - normal * vector.dot(normal)

func apply_friction(delta):
	velocity *= exp(delta * -FRICTION)
	
func lower_height(delta):
	pos_z *= exp(delta * -1.5)
	
func raise_height(delta):
	pos_z *= exp(delta * 1.5)
	
func check_chase():
	var player = PlayerManager.player_motion_root
	var playerTooHigh
	var diffToTarget = player.global_position - self.global_position;
	var diffToOrigin = self.global_position - origin
	
	if PlayerManager.jumping:
		pass
	else:
		playerTooHigh = (player.floor_z - floor_z) > MAX_Z_DIFF
		
	var playerTooFar = diffToTarget.length() > MAX_CHASE_DISTANCE
	var originTooFar = diffToOrigin.length() > (WANDER_RADIUS + MAX_CHASE_DISTANCE / 2)
	var should_start_chase = (player_in_radius && !chase_fatigued) && !freeze && !playerTooHigh && !originTooFar
	var should_end_chase = playerTooFar || freeze || playerTooHigh || originTooFar
	
	if state == ENEMY_STATE.CHASE && should_end_chase:
		if originTooFar:
			chase_fatigued = true
		
		timer = 0
		state = ENEMY_STATE.RETURN
	elif state != ENEMY_STATE.CHASE && should_start_chase:
		timer = 0
		state = ENEMY_STATE.CHASE

func _on_Timer_timeout():
	pass
