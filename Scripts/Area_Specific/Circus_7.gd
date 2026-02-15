extends Node2D

func _ready():
	SceneManager.counter = 0
	
	SceneManager.location = "Circus"
	if Music.id != "Circus":
		Music.switch_songs()
		Music.id = "Circus"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if SceneManager.time_decided:
		SceneManager.time_decided = false
		
	if EventManager.circus_puzzle:
		$YSort/MiddleGround/BlocksA.queue_free()
