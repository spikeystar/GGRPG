extends Node

var id : String
var active : AudioStreamPlayer
var saved_time : float
var is_playing = false
var stopped = false

func music():
	if id == "Garys_House":
		active = $Garys_House
		active.play()
	if id == "Cherry_Trail":
		active = $Cherry_Trail
		active.play(0)
	if id == "Pivot_Town":
		active = $Pivot_Town
		active.play(0)
	if id == "Kugi_Canyon":
		active = $Kugi_Canyon
		active.play(0)
	if id == "Berry_Lake":
		active = $Berry_Lake
		active.play(0)
	if id == "Overworld":
		active = $Overworld
		active.play(0)
	if id == "High_Tension":
		active = $High_Tension
		active.play(0)
	is_playing = true
	
func switch_songs():
	if is_playing:
		active.stop()

func stopped():
	is_playing = false
	active.stop()

func pause():
	saved_time = active.get_playback_position()
	active.stop()
	
func unpause():
	active.play()
	active.seek(saved_time)
	
func quiet():
	active.volume_db -= 5
	
func loud():
	active.volume_db += 5
