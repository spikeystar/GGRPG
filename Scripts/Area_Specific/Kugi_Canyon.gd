extends Node

func _ready():
	SceneManager.SceneEnemies = []
	pass
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
