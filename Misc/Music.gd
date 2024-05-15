extends Node

var id : String

func music():
	if id == "Garys_House":
		$Garys_House.play()
	if id == "Cherry_Trail":
		$Cherry_Trail.play(0)
			
