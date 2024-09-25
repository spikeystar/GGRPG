extends Node

func _ready():
	EventManager.Pivot_Town = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Pivot Town"
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
		
	
