extends KinematicBody2D


var vel : Vector2
var acceleration = 5000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var alien_a = false
var alien_b = false
var alien_c = false

var alien_pick

var path_alien = false
var dead = false


func _ready():	
	if alien_pick == 1:
		alien_a = true
		$AnimationPlayer.play("alien_a")
	if alien_pick == 2:
		alien_b = true
		$AnimationPlayer.play("alien_b")
	if alien_pick == 3:
		alien_c = true
		$AnimationPlayer.play("alien_c")


func _process(delta):
	if SceneManager.score >= 200:
		acceleration = 5500
	if SceneManager.score >= 400:
		acceleration = 6000
	if SceneManager.score >= 800:
		acceleration = 6500
	if SceneManager.score >= 900:
		acceleration = 7000
	
	input_dir.y -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.y += input_dir.y * acceleration * delta
		vel.y *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if not SceneManager.win and not dead and not path_alien:
			move_and_slide(delta2D)


func _on_Area2D_body_entered(body):
	if not SceneManager.win:
		SceneManager.score += 10
		SE.effect("Alien_Death")
		dead = true
		$AnimationPlayer.play("death")
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D.global_position.x -= 500
		$Area2D/CollisionShape2D2.set_deferred("disabled", true)
		$Area2D/CollisionShape2D2.global_position.x -= 500
		yield(get_tree().create_timer(0.5), "timeout")
		self.queue_free()
