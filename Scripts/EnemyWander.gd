extends KinematicBody2D

onready var PlayerDetection = $PlayerDetection
onready var Trigger = $BattleTrigger
onready var sprite = $AnimatedSprite

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
export(String, FILE, "*.tscn,*.scn") var target_scene

const LOWEST_Z: int = 0;

export var spawn_z = 0
export var gravity = 9.8

var floor_z : float = LOWEST_Z
var shadow_z : float = 0
var pos_z : float
var vel : Vector3;
var last_dir: Vector2;
var floor_layers : Array = []
var is_on_ground = true
var is_falling = true
var freeze = PlayerManager.freeze

enum {IDLE,
WANDER,
CHASE
}

export var ACCELERATION = 150
export var MAX_SPEED = 50
export var FRICTION = 100

var velocity = Vector2.ZERO
var state = WANDER

var ready = true

func _ready():
	state = WANDER
	floor_z = spawn_z
	pos_z = spawn_z

func update_floor():
	floor_z = LOWEST_Z
	for f in floor_layers:
		floor_z = max(floor_z, f.height)

func _physics_process(delta):
	update_floor()
	
	match state:
		IDLE:
			FRICTION = 1000
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		WANDER:
			sprite.speed_scale = 0.75
			if ready and not freeze:
				randomize()
				var wander_range = Vector2(rand_range(-100, 100), rand_range(-100, 100))
				var direction = (wander_range - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				ready = false
				yield(get_tree().create_timer(0.5), "timeout")
				ready = true
			seek_player()
		CHASE:
			sprite.speed_scale = 0.95
			var player = PlayerDetection.player
			if player != null and not freeze:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = WANDER
			seek_player()
	sprite.flip_h = velocity.x > 0
	if 	velocity.y < 0:
		sprite.animation = "walk_back"
	if 	velocity.y > 0:
		sprite.animation = "walk_front"
	velocity = move_and_slide(velocity)
	
		
			
func seek_player():
	if PlayerDetection.player_check():
		state = CHASE
	
func _on_BattleTrigger_triggered():
	var player = PlayerManager.player_motion_root
	SceneManager.position = player.position
	SceneManager.height = player.pos_z
	SceneManager.previous_scene = get_tree().current_scene.filename
	sprite.playing = false
	state = IDLE
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	get_tree().change_scene(target_scene)
	transition.queue_free()
