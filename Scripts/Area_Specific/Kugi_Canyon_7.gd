extends Node

func _ready():
	EventManager.Kugi_Canyon = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Kugi Canyon"
	if Music.id != "Kugi_Canyon" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Kugi_Canyon"
		Music.music()
