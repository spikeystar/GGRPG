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

func _ready():
	floor_z = spawn_z
	pos_z = spawn_z
	
func _physics_process(delta):
	is_on_ground = pos_z <= floor_z + 4

func update_floor():
	floor_z = LOWEST_Z
	for f in floor_layers:
		floor_z = max(floor_z, f.height)
