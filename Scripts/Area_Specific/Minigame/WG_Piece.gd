extends KinematicBody2D

var vel : Vector2
var acceleration = 2000
var friction = 15
var input_dir = Vector2.ZERO
var origin : Vector2
var sensor_origin : Vector2
var speed = 1000

var Pieces = ["A", "B", "C", "D", "E", "W", "X", "Y", "Z"]

var able = false
var good
var bad
var move_right = false
var move_left = false

var dead = false

func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var piece_select = rng.randi_range(0, 8)
	
	$AnimationPlayer.play(Pieces[piece_select])
	
	if piece_select == 0 or piece_select == 1 or piece_select == 2 or piece_select == 3 or piece_select == 4:
		good = true
		
	if piece_select == 5 or piece_select == 6 or piece_select == 7 or piece_select == 8:
		bad = true
		
func _process(delta):
	if move_right:
		input_dir.x += 1.0
		
	if move_left:
		input_dir.x -= 1.0
	
	if input_dir.length_squared() > 1:
		input_dir = input_dir.normalized()
		
		
		vel.x += input_dir.x * acceleration * delta
		vel.x *= clamp(1 - (delta * friction), 0, 1);
		
		var delta2D = Vector2(vel.x, -vel.y * 0.5)
		
		if not SceneManager.win and SceneManager.event_start:
			move_and_slide(delta2D)


func hit():
	$Sprite.frame += 1
	$AnimationPlayer.play("hit")
	dead = true
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able:
		able = false
		if not dead:
			hit()
		
		if good and not dead:
			SceneManager.score += 10
			SE.effect("Marble")
		if bad:
			SceneManager.score -= 10
			SE.effect("Fail")

func _on_Area2D_body_entered(body):
	able = true

func _on_Area2D_body_exited(body):
	able = false
