extends KinematicBody2D


var vel : Vector2
var acceleration = 7000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var alien_a = false
var alien_b = false
var alien_c = false

var dead = false


func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var alien_pick = rng.randi_range(1, 3)
	
	if alien_pick == 1:
		$AnimationPlayer.play("alien_a")
	if alien_pick == 2:
		$AnimationPlayer.play("alien_b")
	if alien_pick == 3:
		$AnimationPlayer.play("alien_c")


func _process(delta):
	if SceneManager.score >= 200:
		acceleration = 8000
	if SceneManager.score >= 400:
		acceleration = 9000
	
	input_dir.y -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.y += input_dir.y * acceleration * delta
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if not SceneManager.win and not dead:
			move_and_slide(delta2D)


func _on_Area2D_body_entered(body):
	SE.effect("Basic")
	dead = true
	$AnimationPlayer.play("death")
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D2.disabled = true
	yield(get_tree().create_timer(0.5), "timeout")
	self.queue_free()
