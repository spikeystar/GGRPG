extends KinematicBody2D


var vel : Vector2
var acceleration = 9000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var initial = false

var MaxLeft : Vector2
var MaxRight  : Vector2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	var max_right = false
	var max_left = false
	
	if int(global_position.x) >= int(MaxRight.x):
		max_right = true
		
	if int(global_position.x) <= int(MaxLeft.x):
		max_left = true
	
	if Input.is_action_pressed("ui_right") and initial and not max_right and not SceneManager.win:
		input_dir.x += 1.0
	
	if Input.is_action_pressed("ui_left") and initial and not max_left and not SceneManager.win:
		input_dir.x -= 1.0
		
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.x += input_dir.x * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if initial and not SceneManager.win:
			move_and_slide(delta2D)
