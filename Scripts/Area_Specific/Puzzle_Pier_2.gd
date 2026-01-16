extends Node

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
	
	#EventManager.Pivot_Town = true
	
	SceneManager.SceneEnemies = []
	
	#SceneManager.location = "Pivot Town"
	
	if Music.id != "Puzzle_Pier" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Puzzle_Pier"
		Music.music()

func day():
	SceneManager.day = true
	SceneManager.time_decided = true
	$YSort/Background/NightBckgd.hide()
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Day")
	
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
	
	$YSort/MiddleGround/Streetlamps/Streetlamp_A/AnimationPlayer.play("Night")

