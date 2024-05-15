extends Node

func _ready():
	if Music.id != "Garys_House":
		Music.switch_songs()
		Music.id = "Garys_House"
		#Music.id = "Cherry_Trail"
		Music.music()
	
