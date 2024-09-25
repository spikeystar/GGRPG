extends Node2D

func _ready():
	EventManager.Cherry_Trail = true
	
	SceneManager.location = "Cherry Trail"
	if Music.id != "Cherry_Trail":
		Music.switch_songs()
		Music.id = "Cherry_Trail"
		Music.music()

	SceneManager.SceneEnemies = []
