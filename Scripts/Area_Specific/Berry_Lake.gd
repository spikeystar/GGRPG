extends Node

func _ready():
	SceneManager.SceneEnemies = []
	SceneManager.location = "Berry Lake"
	if Music.id != "Berry_Lake" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Berry_Lake"
		Music.music()
		
