extends Node

var id : String
var active : AudioStreamPlayer
var saved_time : float
var is_playing = false

func music():
	if id == "Standard_Battle":
		active = $Standard_Battle
		active.play()
	if id == "Miniboss_Battle":
		active = $Miniboss_Battle
		active.play()
	if id == "Boss_Battle":
		active = $Boss_Battle
		active.play()
	if id == "Victory":
		active = $Victory
		active.play()
	is_playing = true
	
func switch_songs():
	if is_playing:
		active.stop()

