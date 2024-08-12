extends Node

func _ready():
	SceneManager.SceneEnemies = []
	pass
	if Music.id != "Kugi_Canyon" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Kugi_Canyon"
		Music.music()
