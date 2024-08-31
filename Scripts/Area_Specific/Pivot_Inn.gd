extends Node2D

func _ready():
	PlayerManager.ongoing = false
	SceneManager.location = "Pivot Town"
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
