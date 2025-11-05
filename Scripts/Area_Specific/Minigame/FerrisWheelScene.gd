extends Node2D

func _ready():
	$Day.hide()
	$Night.hide()
	
	if SceneManager.day:
		#yield(get_tree().create_timer(0.2), "timeout")
		$Day.show()
		$Day.playing = true
	if SceneManager.night:
		#yield(get_tree().create_timer(0.2), "timeout")
		$Night.show()
		$Night.playing = true
	
	yield(get_tree().create_timer(7), "timeout")
	$AnimationPlayer.play_backwards("open")
