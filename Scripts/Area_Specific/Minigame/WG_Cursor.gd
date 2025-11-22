extends KinematicBody2D

var vel : Vector2
var acceleration = 8000
var friction = 12
var input_dir = Vector2.ZERO

var initial = false
var able = false

var max_right = false
var max_left = false
var max_up = false
var max_down = false

var stored : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if not able:
		input_dir.x = 0
		input_dir.y = 0
		
	
	if Input.is_action_pressed("ui_right") and initial and not max_right and SceneManager.event_start:
		input_dir.x += 1.0
		acceleration = 8000
		friction = 12
	if Input.is_action_pressed("ui_left") and initial and not max_left and SceneManager.event_start:
		input_dir.x -= 1.0
		acceleration = 8000
		friction = 12
	if Input.is_action_pressed("ui_down") and initial and not max_down and SceneManager.event_start:
		input_dir.y -= 1.0
		acceleration = 9000
		friction = 12
	if Input.is_action_pressed("ui_up") and initial and not max_up and SceneManager.event_start:
		input_dir.y += 1.0
		acceleration = 9000
		friction = 12
	if Input.is_action_pressed("ui_select") and initial and not able and SceneManager.event_start:
		return
	
	if Input.is_action_just_pressed("ui_right") and initial and not max_right and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_left") and initial and not max_left and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_down") and initial and not max_down and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_up") and initial and not max_up and SceneManager.event_start:
		friction = 50
		
	if Input.is_action_just_pressed("ui_right") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_left") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_right") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start:
		friction = 50
	if Input.is_action_just_pressed("ui_left") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start:
		friction = 50
		
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_left or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_right or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_up or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_down:
		friction = 50
	if Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_left or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_right or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_up or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_up") and initial and SceneManager.event_start and max_down:
		friction = 50
	if Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_left or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_right or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_up or Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_down:
		friction = 50
	if Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_left or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_right or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_up or Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_down") and initial and SceneManager.event_start and max_down:
		friction = 50	
		
		
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
	
		vel.x += input_dir.x * acceleration * delta
		vel.y += input_dir.y * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		vel.y *= clamp(1 - (delta * friction), 0, 1);
	
	
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if SceneManager.event_start and not SceneManager.win and not SceneManager.minigame_done and able:
			move_and_slide(delta2D)

func _input(event):
	if Input.is_action_just_pressed("ui_select") and SceneManager.event_start and able:
		able = false
		SE.effect("Water_Gun")
		$AnimationPlayer.play("spray")
		var timer = Timer.new()
		timer.one_shot = true
		add_child(timer)
		timer.start(0.7)
		timer.connect("timeout", self, "_on_timer_timeout")
		
func _on_timer_timeout():
	able = true

func _on_MaxTop_body_entered(body):
	max_up = true

func _on_MaxBottom_body_entered(body):
	max_down = true

func _on_MaxRight_body_entered(body):
	max_right = true

func _on_MaxLeft_body_entered(body):
	max_left = true

func _on_MaxTop_body_exited(body):
	max_up = false

func _on_MaxBottom_body_exited(body):
	max_down = false

func _on_MaxRight_body_exited(body):
	max_right = false

func _on_MaxLeft_body_exited(body):
	max_left = false

