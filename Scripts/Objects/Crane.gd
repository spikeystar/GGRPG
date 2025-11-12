extends KinematicBody2D

var vel : Vector2
var acceleration = 5000
var friction = 20
var input_dir = Vector2.ZERO
var origin : Vector2

var handle_movement = true
var extend_movement = false

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = global_position

func _process(delta):
	var max_left = false
	if Vector2(int(global_position.x), int(global_position.y)) == Vector2(int(origin.x), int(origin.y)):
		max_left = true
	
	if Input.is_action_pressed("ui_right") and handle_movement:
		input_dir.x += 1.0
	if Input.is_action_pressed("ui_left") and handle_movement and not max_left:
		input_dir.x -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.x += input_dir.x * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if handle_movement:
			move_and_slide(delta2D)
			
		if extend_movement:
			var claw_vel = Vector2(0,0)
			claw_vel.y -= 1
			var claw2D = claw_vel.y * delta * friction
			$Claw_Body.move_and_slide(claw2D)
		
			
func _input(event):
	if Input.is_action_just_pressed("ui_select") and handle_movement:
		handle_movement = false
		extend_movement = true
		$AnimationPlayer.play("open")
		chain_extend()
		

func chain_extend():
		yield(get_tree().create_timer(0.2), "timeout")
		$Chains.show()
		$Chains/Chain1.show()
		yield(get_tree().create_timer(0.4), "timeout")
		$Chains/Chain2.show()
		
