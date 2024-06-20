extends Node2D

func _ready():
	if Music.id != "Cherry_Trail":
		Music.switch_songs()
		Music.id = "Cherry_Trail"
		Music.music()

	SceneManager.SceneEnemies = []

