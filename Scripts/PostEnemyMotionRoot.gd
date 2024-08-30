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




func _ready():
	origin = self.global_position
	rng = RandomNumberGenerator.new()
	rng.randomize()
	floor_z = spawn_z
	pos_z = spawn_z
	initial_z = pos_z
	
func _physics_process(delta):
	var player = PlayerManager.player_motion_root
	freeze = PlayerManager.freeze
	
	$BattleTrigger.height = pos_z
	
	#print(ENEMY_STATE.keys()[state])
	#print(player.floor_z - floor_z)
	
	is_on_ground = pos_z <= floor_z + 4
	update_floor()

func update_floor():
	floor_z = LOWEST_Z
	ceiling_z = HIGHEST_Z
	for f in floor_layers:
		if f.bottom <= pos_z:
			floor_z = max(floor_z, f.height)
		else:
			ceiling_z = min(ceiling_z, f.bottom)

