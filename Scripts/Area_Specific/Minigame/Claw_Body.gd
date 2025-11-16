extends KinematicBody2D


var extend_movement = false

var vel : Vector2
var acceleration = 5000
var friction = 20
var input_dir = Vector2.ZERO
var MaxBottom : Vector2

var bottom_reached = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_select") and extend_movement:
		input_dir.y -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
	vel.y += input_dir.y * acceleration * delta
	vel.y *= clamp(1 - (delta * friction), 0, 1);
		
	var delta2D = Vector2(vel.x, -vel.y * 0.5)
	
	if not int(global_position.y) >= int((MaxBottom.y)) and extend_movement:
		move_and_slide(delta2D)
		
	if int(global_position.y) >= int((MaxBottom.y)) and extend_movement:
		bottom_reached = true
		
	if bottom_reached:
		SE.effect("Jammed")
		bottom_reached = false
		extend_movement = false

