extends Node
onready var Gary = PlayerManager.player_instance

#onready var Jacques = $YSort/MiddleGround/Jacques
#onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

#onready var Irina = $YSort/MiddleGround/Irina
#onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/SceneTransition.tscn")
const FerrisWheel = preload("res://Areas/Puzzle Pier/Minigame/FerrisWheel.tscn")
const Fortune = preload("res://Areas/Puzzle Pier/Minigame/Fortune.tscn")
const Crane_Machine = preload("res://Areas/Puzzle Pier/Minigame/Crane_Machine.tscn")




func _ready():
	SceneManager.day = false
	SceneManager.night = false
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cycle = rng.randi_range(1, 100)
	if cycle <= 50:
		night()
		SceneManager.night = true
	else:
		day()
		SceneManager.day = true
	
	#EventManager.Pivot_Town = true
	
	SceneManager.SceneEnemies = []
	
	#SceneManager.location = "Pivot Town"
	
	if Music.id != "Puzzle_Pier" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Puzzle_Pier"
		Music.music()

func day():
	print("day")
	$YSort/Background/NightBckgd.hide()
	
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
	$YSort/NightRect.show()
	$YSort/Background/NightBckgd.show()
	
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
			$Camera2D.follow_player = true
			$Camera2D.current = true
			yield(get_tree().create_timer(0.5), "timeout")
			$CollisionRoot/CraneStand.reset()
			if SceneManager.win:
				SceneManager.win = false
				SE.effect("Item_Get")
				$Camera2D._on_Item_Get_item_get()
				if Party.add_key_item_name == "Jhumki":
					Party.add_key_item()
					Party.add_item_name = "False"
				if Party.add_trinket_name == "Stress Ball":
					Party.add_trinket()
					Party.add_item_name = "False"
				Party.add_item()
			if not SceneManager.win:
				yield(get_tree().create_timer(0.5), "timeout")
				PlayerManager.freeze = false
				PlayerManager.cutscene = false

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
		$Camera2D.add_child(Fortune_Scene)
		
	if SceneManager.npc_name == "Nathan":
		var Crane_Scene = Crane_Machine.instance()
		$Camera2D.basic_transition_out()
		yield(get_tree().create_timer(0.5), "timeout")
		$Camera2D.add_child(Crane_Scene)
