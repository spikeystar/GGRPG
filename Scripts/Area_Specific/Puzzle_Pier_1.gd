extends Node
onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

onready var Irina = $YSort/MiddleGround/Irina
onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

onready var Pierre = $YSort/MiddleGround/Pierre
onready var PierrePlayer = $YSort/MiddleGround/Pierre/BodyYSort/AnimationPlayer

onready var Alison = $YSort/MiddleGround/Alison
onready var AlisonPlayer = $YSort/MiddleGround/Alison/BodyYSort/AnimationPlayer

onready var Brody = $YSort/MiddleGround/Brody
onready var BrodyPlayer = $YSort/MiddleGround/Brody/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/SceneTransition.tscn")
const FerrisWheel = preload("res://Areas/Puzzle Pier/Minigame/FerrisWheel.tscn")
const Fortune = preload("res://Areas/Puzzle Pier/Minigame/Fortune.tscn")
const Crane_Machine = preload("res://Areas/Puzzle Pier/Minigame/Crane_Machine.tscn")
const Space_Quest = preload("res://Areas/Puzzle Pier/Minigame/Space_Quest.tscn")
const Water_Guns = preload("res://Areas/Puzzle Pier/Minigame/Water_Guns.tscn")


func _ready():
	if not SceneManager.time_decided:
		SceneManager.day = false
		SceneManager.night = false
		randomize()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var cycle = rng.randi_range(1, 100)
		if cycle <= 50:
			night()
		else:
			day()
			
	if SceneManager.time_decided:
		if SceneManager.day:
			day()
		if SceneManager.night:
			night()
	
	#EventManager.Puzzle_Pier = true
	
	SceneManager.SceneEnemies = []
	
	#SceneManager.location = "Puzzle Pier"
	
	EventManager.Puzzle_Pier = true
	
	if Music.id != "Puzzle_Pier" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Puzzle_Pier"
		Music.music()
		
	if EventManager.Brody_Intro and EventManager.Brody_Entry:
		$Circus1/CollisionPolygon2D.disabled = false
		Brody.global_position = Vector2(2187, 914)
		BrodyPlayer.play("idle_f")
		$CollisionRoot/NPC10.global_position = Vector2(1405, 1384)
		
	if not EventManager.Puzzle_Pier:
		EventManager.Puzzle_Pier = true
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Pierre.global_position = $PierrePOS_Intro.global_position
		Alison.global_position = $AlisonPOS.global_position
		AlisonPlayer.play("idle_back")
		Gary.animation("d_down_r_idle")
		
		yield(get_tree().create_timer(0.4), "timeout")
		$Camera2D.follow_player = false
		var camera_tween = create_tween()
		camera_tween.tween_property($Camera2D, "global_position", $CameraIntroPOS.position, 2)
		yield(camera_tween, "finished")
		
		yield(get_tree().create_timer(0.5), "timeout")
		SE.effect("Select")
		SE.effect("Drama Jump")
		PierrePlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What did you think you were doing leaving your post!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		PierrePlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I-I'm sorry, sir! It's just that I haven't had a break in a long time and I..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		PierrePlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "If you can't do your job, I'll find someone else who can!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		PierrePlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		PierrePlayer.play("idle_back_f")
		yield(get_tree().create_timer(0.8), "timeout")
		SE.effect("Drama Jump")
		PierrePlayer.play("front_hop")
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "And look, we have new guests! Hurry up and welcome them here!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		PierrePlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, sir..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		yield(get_tree().create_timer(0.4), "timeout")
		
		PierrePlayer.play("idle_f")
		var tween = create_tween()
		tween.tween_property(Pierre, "global_position", $PierrePOS_Intro2.position, 2)
		yield(get_tree().create_timer(0.5), "timeout")
		
		Gary.animation("d_down_r_walk")
		
		var tween2 = create_tween()
		tween2.tween_property(Alison, "global_position", $AlisonPOS2.position, 0.8)
		var tween3 = create_tween()
		tween3.tween_property(Gary.motion_root, "global_position", $GaryPOS_Intro.position, 2)
		yield(get_tree().create_timer(0.8), "timeout")
		AlisonPlayer.play("idle_back_f")
		yield(tween3, "finished")
		Gary.animation("d_down_r_idle")
		Jacques.global_position = Gary.motion_root.global_position
		Irina.global_position = Gary.motion_root.global_position
		JacquesPlayer.play("front_walk")
		IrinaPlayer.play("back_walk_f")
		var tween4 = create_tween()
		tween4.tween_property(Jacques, "global_position", $JacquesPOS_Intro.position, 0.5)
		var tween5 = create_tween()
		tween5.tween_property(Irina, "global_position", $IrinaPOS_Intro.position, 0.5)
		yield(tween5, "finished")
		JacquesPlayer.play("front_idle_f")
		IrinaPlayer.play("front_idle_f")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Welcome to Puzzle Pier, where every moment is a piece to remember!"
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks for the welcome, but jeez what was that all about?"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "S-sorry you had to see that..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Things haven't really been the same since the old owner went missing..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "That happened recently?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, it was quite sudden."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Pierre just used to be in charge of the circus."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But he says the owner left the whole pier up to him before he disappeared."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "None of us have heard from him since so we're kind of worried..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "That is pretty odd..."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well, we think you're doing a great job!"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, thank you..."
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I hope you enjoy your time here!"
		$Camera2D/Interaction/Dialogue/Name.text = "Alison:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		AlisonPlayer.play("idle_back")
		var tween6 = create_tween()
		tween6.tween_property(Alison, "global_position", $AlisonPOS3.position, 1.5)
		yield(tween6, "finished")
		AlisonPlayer.play("idle")
		
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("front_idle")
		Gary.animation("d_down_idle")
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Something's off with that Pierre guy to me..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Let's look around a bit and see if we can find out anything else."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		SE.effect("Drama Jump")
		Gary.animation("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yeah! And let's play some games!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ok, just don't get too distracted..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_walk_f")
		IrinaPlayer.play("front_walk")
		var tween7 = create_tween()
		tween7.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.5)
		var tween8 = create_tween()
		tween8.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.5)
		yield(tween8, "finished")
		Jacques.queue_free()
		Irina.queue_free()
		Pierre.global_position = Vector2(5000, 5000)
		
		yield(get_tree().create_timer(0.2), "timeout")
		var camera_tween2 = create_tween()
		var camera_position = Vector2((Gary.motion_root.global_position.x + $Camera2D.player_offset.x), (Gary.motion_root.global_position.y - $Camera2D.z_offset + $Camera2D.player_offset.y))
		camera_tween2.tween_property($Camera2D, "global_position", camera_position, 0.5)
		yield(camera_tween2, "finished")
		
		$Camera2D.follow_player = true
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		

func day():
	SceneManager.day = true
	SceneManager.time_decided = true
	$YSort/Background/NightBckgd.hide()
	$YSort/NightRect.hide()
	$YSort/Background/Water.modulate.r = 1
	$YSort/Background/Water.modulate.g = 0.99
	$YSort/Background/Water.modulate.b = 1
	
	$YSort/MiddleGround/Archway/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Circus/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Ferris_Wheel/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Lighthouse/AnimationPlayer.play("Day")
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A2/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A3/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A4/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A5/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A6/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A7/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A8/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A9/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A10/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B2/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B3/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B4/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B5/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B6/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B7/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B8/AnimationPlayer.play("Day")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B9/AnimationPlayer.play("Day")
	
	$YSort/Foreground/StringLights.frame = 0
	$YSort/Foreground/StringLights2.frame = 0
	$YSort/Foreground/StringLights3.frame = 0
	$YSort/Foreground/StringLights4.frame = 0
	$YSort/Foreground/StringLights5.frame = 0
	$YSort/Foreground/StringLights6.frame = 0
	$YSort/Foreground/StringLights7.frame = 0
	$YSort/Foreground/StringLights8.frame = 0
	$YSort/Foreground/StringLights9.frame = 0
	$YSort/Foreground/StringLights10.frame = 0
	$YSort/Foreground/StringLights11.frame = 0
	$YSort/Foreground/StringLights12.frame = 0
	$YSort/Foreground/StringLights13.frame = 0
	$YSort/Foreground/StringLights14.frame = 0
	$YSort/Foreground/StringLights15.frame = 0
	
func night():
	SceneManager.night = true
	SceneManager.time_decided = true
	$YSort/NightRect.show()
	$YSort/Background/NightBckgd.show()
	$YSort/Background/Water.modulate.r = 2.6
	$YSort/Background/Water.modulate.g = 0.24
	$YSort/Background/Water.modulate.b = 0.26
	$YSort/Background/Deco.modulate.r = 0.72
	$YSort/Background/Deco.modulate.g = 0.72
	$YSort/Background/Deco.modulate.b = 0.92
	
	$YSort/MiddleGround/Archway/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Circus/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Ferris_Wheel/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Lighthouse/AnimationPlayer.play("Night")
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A2/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A3/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A4/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A5/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A6/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A7/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A8/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A9/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_A10/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B2/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B3/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B4/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B5/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B6/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B7/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B8/AnimationPlayer.play("Night")
	$YSort/MiddleGround/Streetlamps/Streetlamp_B9/AnimationPlayer.play("Night")
	
	$YSort/Foreground/StringLights.frame = 1
	$YSort/Foreground/StringLights2.frame = 1
	$YSort/Foreground/StringLights3.frame = 1
	$YSort/Foreground/StringLights4.frame = 1
	$YSort/Foreground/StringLights5.frame = 1
	$YSort/Foreground/StringLights6.frame = 1
	$YSort/Foreground/StringLights7.frame = 1
	$YSort/Foreground/StringLights8.frame = 1
	$YSort/Foreground/StringLights9.frame = 1
	$YSort/Foreground/StringLights10.frame = 1
	$YSort/Foreground/StringLights11.frame = 1
	$YSort/Foreground/StringLights12.frame = 1
	$YSort/Foreground/StringLights13.frame = 1
	$YSort/Foreground/StringLights14.frame = 1
	$YSort/Foreground/StringLights15.frame = 1

func FerrisWheel_Start():
	PlayerManager.freeze = true

func _input(event):
	if Input.is_action_just_pressed("ui_select") and SceneManager.minigame_done:
		SceneManager.minigame_done = false
		
		if SceneManager.npc_name == "Estella":
			PlayerManager.freeze = true
			yield(get_tree().create_timer(0.5), "timeout")
			$Camera2D.basic_transition_in()
			yield(get_tree().create_timer(0.05), "timeout")
			Music.loud()
			$Camera2D.follow_player = true
			$Camera2D.current = true
			yield(get_tree().create_timer(0.5), "timeout")
			SE.effect("Item_Get")
			Party.add_item()
			$Camera2D._on_Item_Get_item_get()
			$CollisionRoot/FortuneStand.reset()
			
		if SceneManager.npc_name == "Nathan":
			PlayerManager.freeze = true
			yield(get_tree().create_timer(0.5), "timeout")
			$Camera2D.basic_transition_in()
			yield(get_tree().create_timer(0.05), "timeout")
			Music.loud()
			$Camera2D.follow_player = true
			$Camera2D.current = true
			yield(get_tree().create_timer(0.5), "timeout")
			if SceneManager.win:
				SE.effect("Item_Get")
				$Camera2D._on_Item_Get_item_get()
				if Party.add_key_item_name == "Jhumki":
					Party.add_key_item()
					Party.add_key_item_name = "False"
					Party.add_item_name = "False"
				if Party.add_trinket_name == "Stress Ball":
					Party.add_trinket()
					Party.add_trinket_name = "False"
					Party.add_item_name = "False"
				Party.add_item()
			if not SceneManager.win:
				yield(get_tree().create_timer(0.5), "timeout")
				PlayerManager.freeze = false
				PlayerManager.cutscene = false
			SceneManager.win = false
			$CollisionRoot/CraneStand.reset()
			
		if SceneManager.npc_name == "Terrence":
			PlayerManager.freeze = true
			yield(get_tree().create_timer(0.5), "timeout")
			$Camera2D.basic_transition_in()
			yield(get_tree().create_timer(0.05), "timeout")
			Music.loud()
			$Camera2D.follow_player = true
			$Camera2D.current = true
			yield(get_tree().create_timer(0.5), "timeout")
			if SceneManager.win:
				SE.effect("Item_Get")
				$Camera2D._on_Item_Get_item_get()
				if Party.add_key_item_name == "Jhumki":
					Party.add_key_item()
					Party.add_key_item_name = "False"
					Party.add_item_name = "False"
				if Party.add_trinket_name == "Comfy Blanket":
					Party.add_trinket()
					Party.add_trinket_name = "False"
					Party.add_item_name = "False"
				Party.add_item()
			if not SceneManager.win:
				yield(get_tree().create_timer(0.5), "timeout")
				PlayerManager.freeze = false
				PlayerManager.cutscene = false
			SceneManager.win = false
			SceneManager.score = 0
			$CollisionRoot/SpaceStand.reset()
			
		if SceneManager.npc_name == "Devin":
			PlayerManager.freeze = true
			yield(get_tree().create_timer(0.5), "timeout")
			$Camera2D.basic_transition_in()
			yield(get_tree().create_timer(0.05), "timeout")
			Music.loud()
			$Camera2D.follow_player = true
			$Camera2D.current = true
			yield(get_tree().create_timer(0.5), "timeout")
			if SceneManager.win:
				SE.effect("Item_Get")
				$Camera2D._on_Item_Get_item_get()
				if Party.add_key_item_name == "Jhumki":
					Party.add_key_item()
					Party.add_key_item_name = "False"
					Party.add_item_name = "False"
				if Party.add_item_name == "Surfboard":
					Party.add_item_name = "False"
				Party.add_item()
			if not SceneManager.win:
				yield(get_tree().create_timer(0.5), "timeout")
				PlayerManager.freeze = false
				PlayerManager.cutscene = false
			SceneManager.win = false
			SceneManager.score = 0
			SceneManager.event_start = false
			$CollisionRoot/WaterStand.reset()

func _on_EventOptions_yes():
	SE.effect("Switch")
	if SceneManager.npc_name == "Jacob":
		var FerrisWheel_Scene = FerrisWheel.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		$Camera2D.add_child(FerrisWheel_Scene)
		Gary.motion_root.global_position = $FerrisWheelSpawn.position
		Gary.set_right_f()
		yield(get_tree().create_timer(7), "timeout")
		#$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(3), "timeout")
		$Camera2D.remove_child(FerrisWheel_Scene)
		$Camera2D.basic_transition_in()
		yield(get_tree().create_timer(0.05), "timeout")
		SE.effect("Metal Door")
		$Camera2D.follow_player = true
		$Camera2D.current = true
		yield(get_tree().create_timer(0.7), "timeout")
		PlayerManager.freeze = false
		
	if SceneManager.npc_name == "Estella":
		var Fortune_Scene = Fortune.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		Music.quiet()
		$Camera2D.add_child(Fortune_Scene)
		
	if SceneManager.npc_name == "Nathan":
		var Crane_Scene = Crane_Machine.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		Music.quiet()
		$Camera2D.add_child(Crane_Scene)
		
	if SceneManager.npc_name == "Terrence":
		var Space_Scene = Space_Quest.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		Music.quiet()
		$Camera2D.add_child(Space_Scene)
		
	if SceneManager.npc_name == "Devin":
		var Water_Scene = Water_Guns.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		Music.quiet()
		$Camera2D.add_child(Water_Scene)


func _on_Dialogue_event_trigger():
	if not EventManager.Brody_Intro and not EventManager.Brody_Entry:
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.animation("d_up_r_walk")
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $GaryPOS_Brody.position, 1)
		yield(tween, "finished")
		Irina.z_index = 100
		Gary.animation("d_up_r_idle")
		Jacques.position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		var tween2 = create_tween()
		tween2.tween_property(Jacques, "global_position", $JacquesPOS_Brody.position, 0.6)
		var tween3 = create_tween()
		tween3.tween_property(Irina, "global_position", $IrinaPOS_Brody.position, 0.6)
		yield(tween3, "finished")
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle_f")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hey! The circus is closed for now, no one can come in!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, why is it closed?"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Boss said he needs time to hide the Lighthouse Key!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Why does he need to do that...?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		BrodyPlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oops!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.3), "timeout")
		BrodyPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Boss also said not to say that..."
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Anyways, you go away now!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("suggest_back")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Are you sure we can't just take a peek?"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		IrinaPlayer.play("back_idle_f")
		BrodyPlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Boss said no one goes in the circus!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.3), "timeout")
		BrodyPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Now go away, I'm too hungry to yell anymore!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Boss never lets us go on breaks..."
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I want a Picnic Pie so bad though... Hmm..."
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.set_right()
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween4 = create_tween()
		tween4.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		var tween5 = create_tween()
		tween5.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween5, "finished")
		Jacques.global_position = Vector2(5000, 5000)
		Irina.global_position = Vector2(5000, 5000)
		Irina.z_index = 0
		
		yield(get_tree().create_timer(0.4), "timeout")
		EventManager.Brody_Intro = true
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		return
		
	if EventManager.Brody_Intro and not EventManager.Brody_Entry:
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.animation("d_up_r_walk")
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $GaryPOS_Brody.position, 1)
		yield(tween, "finished")
		Gary.animation("d_up_r_idle")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hmm... Something smells good..."
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		BrodyPlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh! You have a Picnic Pie!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.3), "timeout")
		BrodyPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gimme, gimme!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.animation("suggest")
		yield(get_tree().create_timer(0.6), "timeout")
		Gary.animation("d_up_r_idle")
		
		SE.effect("Drama Jump")
		BrodyPlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Don’t tell Boss, but I'm going to take a break!"
		$Camera2D/Interaction/Dialogue/Name.text = "Brody:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.3), "timeout")
		BrodyPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Brody.z_index = 100
		yield(get_tree().create_timer(0.3), "timeout")
		SE.effect("Flee")
		var tween2 = create_tween()
		tween2.tween_property(Brody, "global_position", $BrodyPOS.position, 0.2)
		yield(tween2, "finished")
		var tween3 = create_tween()
		tween3.tween_property(Brody, "global_position", $BrodyPOS2.position, 0.2)
		yield(tween3, "finished")
		BrodyPlayer.play("idle_f")
		var tween4 = create_tween()
		tween4.tween_property(Brody, "global_position", $BrodyPOS3.position, 0.5)
		yield(tween4, "finished")
		Brody.z_index = 0
		Brody.global_position = Vector2(2187, 920)
		$CollisionRoot/NPC10.global_position = Vector2(1405, 1384)
		
		yield(get_tree().create_timer(1), "timeout")
		
		Irina.z_index = 100
		Jacques.position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		var tween5 = create_tween()
		tween5.tween_property(Jacques, "global_position", $JacquesPOS_Brody.position, 0.6)
		var tween6 = create_tween()
		tween6.tween_property(Irina, "global_position", $IrinaPOS_Brody.position, 0.6)
		yield(tween6, "finished")
		JacquesPlayer.play("suggest_front_f")
		IrinaPlayer.play("back_idle")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well, it looks like we can head into the circus now."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		Gary.animation("d_up_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What do you think?"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I say we take a look around!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("worry_back_f")
		Gary.animation("d_down_r_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I don’t know..."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("suggest_back_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Should we really be snooping around like this?"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_front_f")
		Gary.animation("d_up_idle")
		IrinaPlayer.play("back_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I get what you mean."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We don't have any actual evidence that there's something going on in here..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		Gary.animation("back_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yet!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But you guys saw how that guy Pierre was yelling earlier."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.animation("d_down_r_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I say anyone who does something like that is probably up to no good!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("worry_back_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hmm... I agree, it was strange."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("back_idle")
		Gary.animation("d_up_idle")
		JacquesPlayer.play("suggest_front_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "How about we just take a quick look?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It's true we won't get anywhere just idling around."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "And if a Jewel Seed is actually here it does seem like a place it could be."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Exactly!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "And if we get kicked out it's no big deal."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We just happened to wander in after all."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.animation("d_down_r_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Alright, let's go!"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Maybe we'll see some totally spectacular performances in there too~"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.set_right()
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween7 = create_tween()
		tween7.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		var tween8 = create_tween()
		tween8.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween8, "finished")
		Jacques.global_position = Vector2(5000, 5000)
		Irina.global_position = Vector2(5000, 5000)
		Irina.z_index = 0
		
		yield(get_tree().create_timer(0.4), "timeout")
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		$Circus1/CollisionPolygon2D.disabled = false
