extends Node2D

func _ready():
	SceneManager.location = "Cherry Trail"
	if Music.id != "Cherry_Trail":
		Music.switch_songs()
		Music.id = "Cherry_Trail"
		Music.music()

	SceneManager.SceneEnemies = []

