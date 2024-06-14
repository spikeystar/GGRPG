extends KinematicBody2D

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

onready var PlayerDetection = $PlayerDetection
onready var Trigger = $BattleTrigger
onready var sprite = $BodyYSort/BodyVisualRoot/Enemy

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
export var target_scene : PackedScene

var freeze = PlayerManager.freeze
onready var battle_arena = target_scene.instance()

onready var motion_root: KinematicBody2D = $MotionRoot
onready var world_collider = $MotionRoot/CollisionShape2D
onready var anim_tree = $BodyYSort/AnimationTree
onready var anim_player = $BodyYSort/AnimationPlayer

onready var body_y_sort = $BodyYSort
onready var body_visual_root = $BodyYSort/BodyVisualRoot
onready var shadow_y_sort = $ShadowYSort
onready var shadow_visual_root = $ShadowYSort/ShadowVisualRoot

onready var body_sprite = $BodyYSort/BodyVisualRoot/Enemy
onready var shadow_sprite = $ShadowYSort/ShadowVisualRoot/ShadowCircle

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

func _physics_process(delta):

	var draw_pos_z = motion_root.pos_z
	var draw_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.floor_z))
	var draw_shadow_z = motion_root.shadow_z
	var draw_shadow_y_sort = Global.calculate_y_sort(Vector3(motion_root.global_position.x, motion_root.global_position.y, motion_root.shadow_z))
	
	body_sprite.height = motion_root.pos_z
	shadow_sprite.height = motion_root.shadow_z + 1
	
	body_y_sort.global_position = Vector2(motion_root.global_position.x, draw_y_sort)
	body_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	shadow_y_sort.global_position = Vector2(motion_root.global_position.x, draw_shadow_y_sort)
	shadow_visual_root.global_position = motion_root.global_position + Vector2(0.0, -draw_shadow_z)
	
	if Global.battle_ended:
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(battle_arena)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		self.queue_free()
	
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
			seek_player()
		CHASE:
			#sprite.speed_scale = 0.95
			var player = PlayerDetection.player
			if player != null and not freeze:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = WANDER
			seek_player()
	sprite.flip_h = velocity.x > 0
	if 	velocity.y < 0:
		anim_player.play("walk_back")
	if 	velocity.y > 0:
		anim_player.play("walk_front")
	velocity = move_and_slide(velocity)
	
func seek_player():
	if PlayerDetection.player_check():
		state = CHASE
	
func _on_BattleTrigger_triggered():
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(battle_arena)
