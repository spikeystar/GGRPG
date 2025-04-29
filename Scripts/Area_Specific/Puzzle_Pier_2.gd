extends Node

func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var cycle = rng.randi_range(1, 100)
	if cycle <= 50:
		night()
	else:
		day()
	
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
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Day")
	
func night():
	$YSort/NightRect.show()
	$YSort/Background/NightBckgd.show()
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Night")

