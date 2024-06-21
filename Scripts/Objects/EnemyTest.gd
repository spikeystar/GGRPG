extends YSort

export var spawn_z = 0
export var player_acceleration = 10
export var player_friction = 2
export var max_player_speed = 2
export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10
export var ground_enemy : bool

onready var PlayerDetection = $MotionRoot/PlayerDetection
onready var Trigger = $MotionRoot/BattleTrigger
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

var motion_root_z

export var dead = false

func _ready():
	$MotionRoot/BattleTrigger.ground_enemy = ground_enemy
	$MotionRoot.ground_enemy = ground_enemy
	anim_player.play("walk_front")
	motion_root_z = motion_root.pos_z
	yield(get_tree().create_timer(0.01), "timeout")
	SceneManager.SceneEnemies.append(self)
	print($MotionRoot/BattleTrigger.height)

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
	
	$MotionRoot/PlayerDetection.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	$MotionRoot/BattleTrigger.global_position = motion_root.global_position + Vector2(0.0, -draw_pos_z)
	
	
	if Global.battle_ended:
		Music.unpause()
		SceneManager.SceneEnemies = []
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(battle_arena)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		dead = true
		Global.battle_ended = false
		
		if $MotionRoot/BattleTrigger.detected:
			self.queue_free()
		else:
			SceneManager.SceneEnemies.append(self)
	
	#if motion_root.velocity.x > 0:
		#sprite.flip_h = true
	#else:
		#sprite.flip_h = false
		
	sprite.flip_h = motion_root.velocity.x > 0
	
	if motion_root.velocity.y < 0:
		anim_player.play("walk_back")
	if motion_root.velocity.y > 0:
		anim_player.play("walk_front")
	#if motion_root.velocity.y == 0:
		#anim_player.play("walk_front")
	
func _on_BattleTrigger_triggered():
	Music.pause()
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(battle_arena)
