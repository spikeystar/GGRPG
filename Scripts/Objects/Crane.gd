extends KinematicBody2D

var vel : Vector2
var acceleration = 5000
var friction = 20
var input_dir = Vector2.ZERO
var origin : Vector2
var speed = 1000

var handle_movement = true
var extend_movement = false
var extending = false
var grabbing = false
var able = true
var caught = false
var return_home = false

var BasketPosition : Vector2

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
			
		if return_home:
			var distance = (origin - global_position).normalized()
			var velocity = (distance * speed)
			move_and_slide(velocity)
			
			
			
			
		
			
func _input(event):
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
			
			if grabbing:
				$AnimationPlayer.play("close")
				grabbing = false
				yield(get_tree().create_timer(0.05), "timeout")
				$Claw_Body/Claw/Area2D/CollisionShape2D.disabled = true
		

func chain_extend():
		yield(get_tree().create_timer(0.2), "timeout")
		$Chains.show()
		$Chains/Chain1.show()
		yield(get_tree().create_timer(0.2), "timeout")
		if extending:
			yield(get_tree().create_timer(0.3), "timeout")
			$Chains/Chain2.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain3.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain4.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain5.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain6.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain7.show()
		if extending:
			yield(get_tree().create_timer(0.5), "timeout")
			$Chains/Chain8.show()
		else:
			return
		

func _on_Area2D_area_entered(area):
	SE.effect("Basic")
	var BasketX = Vector2(BasketPosition.x, origin.y)
	caught = true
	yield(get_tree().create_timer(0.5), "timeout")
	var tween = create_tween()
	tween.tween_property(self, "global_position", BasketX, 2)
	yield(tween, "finished")
	SE.effect("Metal Door")
	$AnimationPlayer.play("open")
	
