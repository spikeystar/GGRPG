extends Node

var id : String
var active : AudioStreamPlayer
var saved_time : float
var is_playing = false

func music():
	if id == "Garys_House":
		active = $Garys_House
		active.play()
	if id == "Cherry_Trail":
		active = $Cherry_Trail
		active.play(0)
	is_playing = true
	
func switch_songs():
	if is_playing:
		active.stop()

func pause():
	saved_time = active.get_playback_position()
	active.stop()
	
func unpause():
	active.play()
	active.seek(saved_time)
	
func quiet():
	active.volume_db -= 4
	
func loud():
	active.volume_db += 4
