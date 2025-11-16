extends Node2D


var FirstPool = ["Spikey Bomb", "Blister Grenade", "Power Drill", "Chilly Globe", "Faulty Amp"]
var SecondPool = ["Polar Parfait", "Nori Cookie", "Flummery Flambe", "Saffron Souffle", "Lovely Gem", "Delicious Cake"]
var ThirdPool = ["Bounty Herb", "Yummy Cake", "Pretty Gem", "Sugar Pill", "Ginger Tea", "Bounty Herb", "Yummy Cake"]

var item1 : String
var item2 : String
var item3 : String

var intro = false
var game_ready = false
var spawn_ready = false
var spawn_time = 4

const Ammo = preload("res://Assets/Puzzle Pier/Space_Quest/Ammo.tscn")
const Alien = preload("res://Assets/Puzzle Pier/Space_Quest/Alien.tscn")


func _ready():
	SE.effect("Menu Open")
	SceneManager.win = false
	SceneManager.score = 0
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var item1_pick = rng.randi_range(0, (FirstPool.size() - 1))
	var item1 = FirstPool[item1_pick]
	$Intro/Item1.item_name = item1
	var item2_pick = rng.randi_range(0, (SecondPool.size() - 1))
	var item2 = SecondPool[item2_pick]
	$Intro/Item2.item_name = item2
	var item3_pick = rng.randi_range(0, (ThirdPool.size() - 1))
	var item3 = ThirdPool[item3_pick]
	$Intro/Item3.item_name = item3
	
	if not EventManager.Space_Item_1:
		$Intro/Item1.item_name = "Comfy Blanket"
		
	if not EventManager.Space_Item_2:
		$Intro/Item2.item_name = "Jhumki"
		
	$Intro/Item1.item_set()
	$Intro/Item2.item_set()
	$Intro/Item3.item_set()
	
	$Game/Spaceship.MaxLeft = $Game/MaxLeft.global_position
	$Game/Spaceship.MaxRight = $Game/MaxRight.global_position
	
	yield(get_tree().create_timer(0.3), "timeout")
	intro = true
	
func _process(delta):
	$Game/Score.text = "Score: " + str(SceneManager.score)
	
	if SceneManager.score >= 50:
		spawn_time = 2
		
	
	if game_ready and spawn_ready:
		spawn_ready = false
		var timer = Timer.new()
		add_child(timer)
		timer.start(3)
		timer.connect("timeout", self, "_on_timer_timeout")
	

func _input(event):
	if Input.is_action_just_pressed("ui_select") and intro:
		SE.effect("Menu Open")
		intro = false
		$AnimationPlayer.play_backwards("open")
		$AnimationPlayer.playback_speed = 1
		yield(get_tree().create_timer(0.5), "timeout")
		$Intro.hide()
		$AnimationPlayer.play("open")
		yield(get_tree().create_timer(0.5), "timeout")
		game_ready = true
		$Game/Spaceship.initial = true
		yield(get_tree().create_timer(2), "timeout")
		spawn_ready = true
		
	if Input.is_action_just_pressed("ui_push") and game_ready and not SceneManager.win:
		SE.effect("Move Between")
		var ammo_piece = Ammo.instance()
		add_child(ammo_piece)
		ammo_piece.global_position = $Game/Spaceship/AmmoSpawn.global_position

func _on_timer_timeout():
	spawn_ready = true
	if spawn_ready:
		alien_spawn()

func alien_spawn():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawn_location : Vector2
	spawn_location = Vector2((rng.randi_range($Game/SpawnLeft.global_position.x, $Game/SpawnRight.global_position.x)), $Game/SpawnRight.global_position.y)
	var alien = Alien.instance()
	add_child(alien)
	alien.global_position = spawn_location
	spawn_ready = false


func _on_MoonArea_body_entered(body):
	SceneManager.win = true
