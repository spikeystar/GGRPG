extends KinematicBody2D
const ACCELERATION: int = 960
const MAX_SPEED: int = 195

export var gravity = 9.8
export var max_vertical_speed = 20
export var jump_velocity = 10

onready var world_collider = $CollisionShape2D

#Movement
export(int) var speed = 100.0
var velocity_z = 0
var pos_z = 0
func _physics_process(delta):
	var velocity = Vector2.ZERO
	var terrain_height = 0
	var direction_x = 0
	var direction_y = 0
	var isOnGround = pos_z <= terrain_height;
	if Input.is_action_pressed("ui_right") or direction_x == 1:
		velocity.x += 1.0
	if Input.is_action_pressed("ui_left") or direction_x == 2:
		velocity.x -= 1.0
	if Input.is_action_pressed("ui_down") or direction_y == 1:
		velocity.y += 1.0
	if Input.is_action_pressed("ui_up") or direction_y == 2:
		velocity.y -= 1.0
	if isOnGround and Input.is_action_just_pressed("ui_select"):
		velocity_z = jump_velocity
		isOnGround = false
	if isOnGround:
		velocity_z = 0
		pos_z = terrain_height
	else:
		velocity_z -= gravity * delta
		if velocity_z < -max_vertical_speed:
			velocity_z = max_vertical_speed
			pos_z += velocity_z * delta
		velocity = velocity.normalized()
		
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide(velocity * speed) 
		
	if Input.is_action_pressed("ui_push"):
		$AnimationTree.get("parameters/playback").travel("Jump")
		$AnimationTree.set("parameters/Jump/blend_position", velocity)
		
#func Spawn_Check():
	#var velocity = Vector2.ZERO
	#var x_input = velocity.x
	#if x_input < 0:
		#Global_Direction.direction_x = -1
		#print(Global_Direction.direction_x)
	#if x_input > 0:
		#Global_Direction.direction_x = 1
		#print(Global_Direction.direction_x)
	#else:
		#$AnimationTree.get("parameters/playback").travel("Idle")
	
#Global Direction

