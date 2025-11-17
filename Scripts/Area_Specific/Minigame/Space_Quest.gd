extends Node2D


var FirstPool = ["Spikey Bomb", "Blister Grenade", "Power Drill", "Chilly Globe", "Faulty Amp"]
var SecondPool = ["Polar Parfait", "Nori Cookie", "Flummery Flambe", "Saffron Souffle", "Lovely Gem", "Delicious Cake"]
var ThirdPool = ["Bounty Herb", "Yummy Cake", "Pretty Gem", "Sugar Pill", "Ginger Tea", "Bounty Herb", "Yummy Cake"]

var item1 : String
var item2 : String
var item3 : String

var intro = false
var game_ready = false
var ammo_ready = false
var ammo_cooldown = 0.7
var spawn_ready = false
var ufo_spawn_ready = false
var spawn_time = 3
var type_cooldown = false
var double = false
var triple = false

const Ammo = preload("res://Assets/Puzzle Pier/Space_Quest/Ammo.tscn")
const Alien = preload("res://Assets/Puzzle Pier/Space_Quest/Alien.tscn")
const UFO = preload("res://Assets/Puzzle Pier/Space_Quest/UFO.tscn")
const PathB = preload("res://Assets/Puzzle Pier/Space_Quest/AlienBPath.tscn")
const PathC = preload("res://Assets/Puzzle Pier/Space_Quest/AlienCPath.tscn")


func _ready():
	SE.effect("Menu Open")
	SceneManager.minigame_done = false
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
		
	if SceneManager.score >= 100:
		spawn_time = 1.5
		
	if SceneManager.score >= 200:
		double = true
		
	if SceneManager.score >= 400:
		spawn_time = 1
		
	if SceneManager.score >= 600:
		triple = true
		
	if SceneManager.score >= 900:
		spawn_time = 0.5
		
	
	if game_ready and spawn_ready and not SceneManager.win and not SceneManager.minigame_done:
		spawn_ready = false
		var timer = Timer.new()
		add_child(timer)
		timer.start(spawn_time)
		if not SceneManager.win and not SceneManager.minigame_done:
			timer.connect("timeout", self, "_on_timer_timeout")
		
		var ufo_timer = Timer.new()
		add_child(ufo_timer)
		ufo_timer.start(20)
		if not SceneManager.win and not SceneManager.minigame_done:
			ufo_timer.connect("timeout", self, "_on_ufo_timer_timeout")
		
	if SceneManager.ammo_b and not SceneManager.win and not SceneManager.minigame_done and not type_cooldown or SceneManager.ammo_c and not SceneManager.win and not SceneManager.minigame_done and not type_cooldown:
		type_cooldown = true
		var reset_timer = Timer.new()
		reset_timer.one_shot = true
		add_child(reset_timer)
		reset_timer.start(25)
		if not SceneManager.win and not SceneManager.minigame_done:
			reset_timer.connect("timeout", self, "_on_reset_timer_timeout")
		
	if SceneManager.ammo_b:
		ammo_cooldown = 0.1
		
	if SceneManager.ammo_c:
		ammo_cooldown = 0.4
		
	if not SceneManager.ammo_b or SceneManager.ammo_c:
		ammo_cooldown = 0.7
		
	

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
		ammo_ready = true
		$Game/Spaceship.initial = true
		yield(get_tree().create_timer(2), "timeout")
		spawn_ready = true
		
	if Input.is_action_just_pressed("ui_push") and game_ready and ammo_ready and not SceneManager.win:
		ammo_ready = false
		var ammo_timer = Timer.new()
		ammo_timer.one_shot = true
		add_child(ammo_timer)
		ammo_timer.start(ammo_cooldown)
		ammo_timer.connect("timeout", self, "_on_ammo_timer_timeout")
		
		SE.effect("Move Between")
		var ammo_piece = Ammo.instance()
		add_child(ammo_piece)
		ammo_piece.global_position = $Game/Spaceship/AmmoSpawn.global_position

func _on_timer_timeout():
	spawn_ready = true
	if spawn_ready and not SceneManager.win and not SceneManager.minigame_done:
		alien_spawn()
		if double:
			alien_spawn()
		if triple:
			alien_spawn()
		
func _on_ammo_timer_timeout():
	ammo_ready = true
	
func _on_ufo_timer_timeout():
	ufo_spawn_ready = true
	if ufo_spawn_ready and not SceneManager.ammo_b and not SceneManager.ammo_c:
		ufo_spawn()
		
func _on_reset_timer_timeout():
	if SceneManager.ammo_b or SceneManager.ammo_c:
		SceneManager.ammo_b = false
		SceneManager.ammo_c = false
		type_cooldown = false

func alien_spawn():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawn_location : Vector2
	spawn_location = Vector2((rng.randi_range($Game/SpawnLeft.global_position.x, $Game/SpawnRight.global_position.x)), $Game/SpawnRight.global_position.y)
	
	var alien_rng = RandomNumberGenerator.new()
	alien_rng.randomize()
	var pick = alien_rng.randi_range(1, 3)
	var alien = Alien.instance()
	alien.alien_pick = pick
	
	if pick == 1:
		add_child(alien)
		alien.global_position = spawn_location
		spawn_ready = false
	
	if pick == 2:
		var path_b = PathB.instance()
		spawn_location = Vector2((rng.randi_range($Game/SpawnLeft.global_position.x + 140, $Game/SpawnRight.global_position.x - 20)), $Game/SpawnRight.global_position.y)
		path_b.global_position = Vector2(spawn_location.x, spawn_location.y + 300)
		$Game.add_child(path_b)
		alien.path_alien = true
		path_b.get_node("Follow").add_child(alien)
		spawn_ready = false
		
	if pick == 3:
		var path_c = PathC.instance()
		spawn_location = Vector2((rng.randi_range($Game/SpawnLeft.global_position.x + 170, $Game/SpawnRight.global_position.x - 20)), $Game/SpawnRight.global_position.y)
		path_c.global_position = Vector2(spawn_location.x, spawn_location.y + 300)
		$Game.add_child(path_c)
		alien.path_alien = true
		path_c.get_node("Follow").add_child(alien)
		spawn_ready = false
		
func ufo_spawn():
	ufo_spawn_ready = false
	var new_ufo = UFO.instance()
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var ufo_direction = rng.randi_range(1,2)
	if ufo_direction == 1:
		new_ufo.move_right = true
	if ufo_direction == 2:
		new_ufo.move_left = true

	if ufo_direction == 1:
		add_child(new_ufo)
		new_ufo.global_position = $Game/UFOLeft.global_position
		
	if ufo_direction == 2:
		add_child(new_ufo)
		new_ufo.global_position = $Game/UFORight.global_position
		
		
	
func _on_MoonArea_body_entered(body):
	SE.effect("Splat")
	SceneManager.win = true
	
	$Game/Score.hide()
	
	yield(get_tree().create_timer(1.5), "timeout")
	$TextPlayer.play("final_score")
	$FinalScore.text = str(SceneManager.score) + "pts"
	SceneManager.minigame_done = true
	
	if SceneManager.score >= 250:
		SE.effect("Win")
		$Place.show()
		if SceneManager.score >= 250:
			$Place.text = "3rd!"
			Party.add_item_name = $Intro/Item3.item_name
		if SceneManager.score >= 500:
			$Place.text = "2nd!"
			Party.add_item_name = $Intro/Item2.item_name
			if $Intro/Item2.item_name == "Jhumki":
				Party.add_key_item_name = "Jhumki"
				Party.add_item_name = "False"
		if SceneManager.score >= 1000:
			$Place.text = "1st!"
			Party.add_item_name = $Intro/Item1.item_name
			if $Intro/Item1.item_name == "Comfy Blanket":
				Party.add_trinket_name = "Comfy Blanket"
				Party.add_item_name = "False"
	if SceneManager.score < 250:
		SE.effect("Fail")
			
	
		
	
