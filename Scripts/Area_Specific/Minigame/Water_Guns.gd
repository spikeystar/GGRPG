extends Node2D


var FirstPool = ["Spikey Bomb", "Blister Grenade", "Power Drill", "Chilly Globe", "Faulty Amp"]
var SecondPool = ["Polar Parfait", "Nori Cookie", "Flummery Flambe", "Saffron Souffle", "Lovely Gem", "Delicious Cake"]
var ThirdPool = ["Bounty Herb", "Yummy Cake", "Pretty Gem", "Sugar Pill", "Ginger Tea", "Bounty Herb", "Picnic Pie", "Picnic Pie", "Picnic Pie", "Picnic Pie"]

var item1 : String
var item2 : String
var item3 : String

var intro = false
var done = false
var game_ready = false
var spawn_ready = false
var spawn_time = 2
var time_up = false

const Piece = preload("res://Assets/Puzzle Pier/Water_Guns/Piece.tscn")
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SE.effect("Menu Open")
	SceneManager.score = 0
	SceneManager.win = false
	SceneManager.minigame_done = false
	SceneManager.event_start = true
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
	
	if not EventManager.Water_Item_1:
		$Intro/Item1.item_name = "Surfboard"
		
	if not EventManager.Water_Item_2:
		$Intro/Item2.item_name = "Jhumki"
		
	$Intro/Item1.item_set()
	$Intro/Item2.item_set()
	$Intro/Item3.item_set()

	yield(get_tree().create_timer(0.3), "timeout")
	intro = true


func _process(delta):
	$Game/Score.text = "Score: " + str(SceneManager.score)
	
	if game_ready and spawn_ready and not SceneManager.win and not SceneManager.minigame_done:
		spawn_ready = false
		var timer = Timer.new()
		add_child(timer)
		timer.start(spawn_time)
		if not SceneManager.win and not SceneManager.minigame_done:
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
		yield(get_tree().create_timer(2), "timeout")
		SceneManager.event_start = true
		initial_pieces()
		spawn_left()
		spawn_right()
		spawn_ready = true
		
func _on_timer_timeout():
	spawn_left()
	spawn_right()

func initial_pieces():
	$Game/Piece.move_left = true
	$Game/Piece2.move_left = true
	$Game/Piece3.move_left = true
	$Game/Piece4.move_left = true
	$Game/Piece5.move_right = true
	$Game/Piece6.move_right = true
	$Game/Piece7.move_right = true
	$Game/Piece8.move_right = true

func spawn_left():
	var new_piece = Piece.instance()
	new_piece.global_position = $Game/SpawnLeft.global_position
	new_piece.move_right = true
	$Game.add_child(new_piece)
	
func spawn_right():
	var new_piece = Piece.instance()
	new_piece.global_position = $Game/SpawnRight.global_position
	new_piece.move_left = true
	$Game.add_child(new_piece)
