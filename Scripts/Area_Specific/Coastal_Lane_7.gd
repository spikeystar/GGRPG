extends Node2D

func _ready():
	SceneManager.location = "Coastal Lane"
	if Music.id != "Coastal_Lane":
		Music.switch_songs()
		Music.id = "Coastal_Lane"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if SceneManager.time_decided:
		SceneManager.time_decided = false
