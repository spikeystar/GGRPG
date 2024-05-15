extends Node

var id : String
var active : AudioStreamPlayer
var saved_time : float

func music():
	if id == "Garys_House":
		active = $Garys_House
		$Garys_House.play()
	if id == "Cherry_Trail":
		active = $Cherry_Trail
		$Cherry_Trail.play(0)
			

func pause():
	saved_time = active.get_playback_position()
	active.stop()
	
func unpause():
	active.play()
	active.seek(saved_time)
