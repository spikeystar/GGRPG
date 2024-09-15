extends Node

var id : String
var active : AudioStreamPlayer
var saved_time : float
var is_playing = false

func music():
	if id == "Standard_Battle":
		active = $Standard_Battle
		active.play()
		is_playing = true
	if id == "Miniboss_Battle":
		active = $Miniboss_Battle
		active.play()
		is_playing = true
	if id == "Boss_Battle":
		active = $Boss_Battle
		active.play()
		is_playing = true
	if id == "Victory":
		active = $Victory
		active.play()
		is_playing = true
	
func switch_songs():
	if is_playing:
		active.stop()
		
func quiet():
	active.volume_db -= 2
	
func loud():
	active.volume_db += 2
	
func fade_out():
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(0.1), "timeout")
	active.volume_db -= 0.5
	yield(get_tree().create_timer(1,5), "timeout")
	active.volume_db += 4

