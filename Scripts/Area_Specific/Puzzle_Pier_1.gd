extends Node

const FerrisWheel = preload("res://Areas/Puzzle Pier/Minigame/FerrisWheel.tscn")

onready var FerrisWheel_Scene = FerrisWheel.instance()

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
