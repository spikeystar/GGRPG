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
var timer_ready = false
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
	SceneManager.event_start = false
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

	yield(get_tree().create_timer(0.7), "timeout")
	intro = true


func _process(delta):
	$Game/Score.text = "Score: " + str(SceneManager.score)
	
	if SceneManager.current_time <= 45 and SceneManager.event_start:
		spawn_time = 1.3
		$Game/Belt1.speed_scale = 1.9
		$Game/Belt2.speed_scale = 1.9
		
	if SceneManager.current_time <= 35 and SceneManager.event_start:
		spawn_time = 1
		$Game/Belt1.speed_scale = 3
		$Game/Belt2.speed_scale = 3
		
	if SceneManager.current_time <= 25 and SceneManager.event_start:
		spawn_time = 0.67
		$Game/Belt1.speed_scale = 4
		$Game/Belt2.speed_scale = 4
		
	if SceneManager.current_time <= 15 and SceneManager.event_start:
		spawn_time = 0.55
		$Game/Belt1.speed_scale = 5
		$Game/Belt2.speed_scale = 5
	
	if game_ready and spawn_ready and not SceneManager.win and not SceneManager.minigame_done:
		spawn_ready = false
		var timer = Timer.new()
		timer.one_shot = true
		add_child(timer)
		timer.start(spawn_time)
		if not SceneManager.win and not SceneManager.minigame_done:
			timer.connect("timeout", self, "_on_timer_timeout")
			
	if timer_ready:
		$Game/Time.text = str(int($Game/Timer.time_left))
		SceneManager.current_time = int($Game/Timer.time_left)
		if $Game/Time.text == "4":
			SE.effect("Countdown")
		if $Game/Time.text == "3":
			SE.effect("Countdown2")
		if $Game/Time.text == "2":
			SE.effect("Countdown")
		if $Game/Time.text == "1":
			SE.effect("Metal Door")
		if $Game/Time.text == "0":
			SceneManager.event_start = false
			timer_ready = false
			$Game/Belt1.playing = false
			$Game/Belt2.playing = false
			yield(get_tree().create_timer(0.5), "timeout")
			final_score()
		
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and intro:
		SE.effect("Menu Open")
		intro = false
		$AnimationPlayer.play_backwards("open")
		$AnimationPlayer.playback_speed = 1
		yield(get_tree().create_timer(0.5), "timeout")
		$Intro.hide()
		$AnimationPlayer.play("open")
		yield(get_tree().create_timer(0.6), "timeout")
		game_ready = true
		SE.effect("Countdown")
		$Game/Countdown.text = "3"
		$AnimationPlayer.play("Countdown")
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Countdown")
		$Game/Countdown.text = "2"
		$AnimationPlayer.play("Countdown")
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Countdown")
		$Game/Countdown.text = "1"
		$AnimationPlayer.play("Countdown")
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Metal Door")
		SE.effect("Switch")
		SceneManager.event_start = true
		initial_pieces()
		spawn_left()
		spawn_right()
		spawn_ready = true
		SceneManager.current_time = 60
		$Game/Timer.start()
		timer_ready = true
		$Game/Belt1.playing = true
		$Game/Belt2.playing = true
		
func _on_timer_timeout():
	spawn_ready = true
	if spawn_ready and SceneManager.event_start and not SceneManager.win and not SceneManager.minigame_done:
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
	
func final_score():
	SceneManager.win = true
	$Game/Time.hide()
	$Game/TimeWindow.hide()
	$Game/Score.hide()
	
	yield(get_tree().create_timer(1.5), "timeout")
	$TextPlayer.play("final_score")
	$FinalScore.text = str(SceneManager.score) + "pts"
	done = true
	
	if SceneManager.score >= 250:
		SE.effect("Win")
		$Place.show()
		if SceneManager.score >= 250 and SceneManager.score < 500:
			$Place.text = "3rd!"
			Party.add_item_name = $Intro/Item3.item_name
			return
		if SceneManager.score >= 500 and SceneManager.score < 1000:
			$Place.text = "2nd!"
			Party.add_item_name = $Intro/Item2.item_name
			if $Intro/Item2.item_name == "Jhumki":
				EventManager.Water_Item_2 = true
				Party.add_key_item_name = "Jhumki"
				return
		if SceneManager.score >= 1000:
			$Place.text = "1st!"
			Party.add_item_name = $Intro/Item1.item_name
			if $Intro/Item1.item_name == "Surfboard":
				EventManager.Water_Item_1 = true
				PartyStats.jacques_weapon = "Surfboard"
	if SceneManager.score < 250:
		SE.effect("Fail")
