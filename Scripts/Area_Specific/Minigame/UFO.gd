extends KinematicBody2D


var vel : Vector2
var acceleration = 2000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var ufo_b = false
var ufo_c = false


var path_alien = false
var dead = false

var move_right = false
var move_left = false


func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var ufo_pick = rng.randi_range(1,2)
	
	if ufo_pick == 1:
		ufo_b = true
		$AnimationPlayer.play("UFO_b")
	if ufo_pick == 2:
		ufo_c = true
		$AnimationPlayer.play("UFO_c")


func _process(delta):
	if SceneManager.score >= 200:
		acceleration = 3000
	if SceneManager.score >= 400:
		acceleration = 4000
	
	if move_right:
		input_dir.x += 1.0
		
	if move_left:
		input_dir.x -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.x += input_dir.x * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if not SceneManager.win and not dead:
			move_and_slide(delta2D)


func _on_Area2D_body_entered(body):
	if ufo_b:
		SceneManager.ammo_b = true
		SceneManager.ammo_c = false
		
	if ufo_c:
		SceneManager.ammo_b = false
		SceneManager.ammo_c = true
	
	SE.effect("UFO")
	dead = true
	$AnimationPlayer.play("death")
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D2.set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	self.queue_free()
