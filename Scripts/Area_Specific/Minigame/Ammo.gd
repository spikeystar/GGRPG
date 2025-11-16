extends KinematicBody2D

var vel : Vector2
var acceleration = 9000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000


func _ready():
	$AnimationPlayer.play("ammo_a")
	
	if SceneManager.ammo_b:
		$AnimationPlayer.play("ammo_b")
	if SceneManager.ammo_c:
		$AnimationPlayer.play("ammo_c")


func _process(delta):
	input_dir.y += 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.y += input_dir.y * acceleration * delta
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		move_and_slide(delta2D)

func _on_Area2D_body_entered(body):
	self.queue_free()
