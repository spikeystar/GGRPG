extends KinematicBody2D

var vel : Vector2
var acceleration = 5000
var friction = 20
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var initial = false
var first = false

var handle_movement = false
var extend_movement = false
var extending = false
var grabbing = false
var able = true
var caught = false
var return_home = false

var MaxRight : Vector2

var done = false
signal game_done

var moving = false
var stopped_position : Vector2
var jammed = false



var BasketPosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	origin.x = int(global_position.x)
	origin.y = int(global_position.y)
	sensor_origin.x = int($Sensor.global_position.x)

func _process(delta):
	var max_left = false
	var max_right = false
	moving = false
	
	if Vector2(int(global_position.x), int(global_position.y)) <= Vector2(int(origin.x), int(origin.y)):
		max_left = true
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(MaxRight.x), int(MaxRight.y)):
		max_right = true
		
	
	if Input.is_action_pressed("ui_right") and handle_movement and not max_right:
		input_dir.x += 1.0
	
	if Input.is_action_pressed("ui_left") and handle_movement and not max_left:
		input_dir.x -= 1.0
		
	if Input.is_action_just_pressed("ui_right") and handle_movement and not max_right:
		moving = true
	
	if Input.is_action_just_pressed("ui_left") and handle_movement and not max_left:
		moving = true
		
	if handle_movement and int($Sensor.global_position.x) <= int(MaxRight.x):
		SE.effect("Jammed")
						
		
	if Input.is_action_just_pressed("ui_right") and handle_movement and max_right:
		SE.effect("Jammed")
	if Input.is_action_just_pressed("ui_left") and handle_movement and jammed:
		SE.effect("Jammed2")
		
	if moving:
		SE.effect("Handle")

	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.x += input_dir.x * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if handle_movement:
			move_and_slide(delta2D)
			
		if return_home:
			var distance = (origin - global_position).normalized()
			var velocity = (distance * speed)
			move_and_slide(velocity)
			
			
func _input(event):
	if Input.is_action_pressed("ui_right") and handle_movement and not first:
		SE.effect("Handle")
		first = true
	
	
	if Input.is_action_just_pressed("ui_select") and handle_movement:
		handle_movement = false
		extend_movement = true
		$Claw_Body.extend_movement = true
		SE.effect("Metal Door")
		$AnimationPlayer.play("open")
		chain_extend()
		yield(get_tree().create_timer(0.05), "timeout")
		extending = true
		
	if Input.is_action_just_pressed("ui_select") and extending and able:
			able = false
			$Claw_Body.extend_movement = false
			extending = false
			$Claw_Body/Claw/Area2D/CollisionShape2D.disabled = false
			grabbing = true
			
	if Input.is_action_just_pressed("ui_select") and grabbing:
			$AnimationPlayer.play("close")
			SE.silence("Extend")
			grabbing = false
			SE.effect("Metal Door")
			yield(get_tree().create_timer(0.05), "timeout")
			$Claw_Body/Claw/Area2D/CollisionShape2D.disabled = true
			
			var BasketX = Vector2(origin.x, origin.y)
			yield(get_tree().create_timer(0.5), "timeout")
			var tween = create_tween()
			tween.tween_property(self, "global_position", BasketX, 2)
			yield(tween, "finished")
			SE.effect("Metal Door")
			$AnimationPlayer.play("open")
			yield(get_tree().create_timer(1), "timeout")
			if not caught:
				SE.effect("Fail")
			yield(get_tree().create_timer(1), "timeout")
			done = true
			emit_signal("game_done")

			
		

func chain_extend():
		yield(get_tree().create_timer(0.1), "timeout")
		SE.effect("Extend")
		$Chains.show()
		$Chains/Chain1.show()
		yield(get_tree().create_timer(0.1), "timeout")
		if extending:
			yield(get_tree().create_timer(0.3), "timeout")
			if extending:
				$Chains/Chain2.show()
		if extending:
			yield(get_tree().create_timer(0.4), "timeout")
			if extending:
				$Chains/Chain3.show()
		if extending:
			yield(get_tree().create_timer(0.41), "timeout")
			if extending:
				$Chains/Chain4.show()
		if extending:
			yield(get_tree().create_timer(0.44), "timeout")
			if extending:
				$Chains/Chain5.show()
		if extending:
			yield(get_tree().create_timer(0.45), "timeout")
			if extending:
				$Chains/Chain6.show()
		if extending:
			yield(get_tree().create_timer(0.4), "timeout")
			if extending:
				$Chains/Chain7.show()
		if extending:
			yield(get_tree().create_timer(0.44), "timeout")
			if extending:
				$Chains/Chain8.show()
		else:
			return
		
		

func _on_Area2D_area_entered(area):
	caught = true
	

func _on_MaxLeft_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	jammed = true
	if first and jammed and handle_movement:
		SE.effect("Jammed2")

func _on_MaxLeft_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	jammed = false
