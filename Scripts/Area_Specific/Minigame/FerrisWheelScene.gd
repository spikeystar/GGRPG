extends Node2D

func _ready():
	$Day.hide()
	$Night.hide()
	
	if SceneManager.day:
		$Day.show()
		$Day.playing = true
	if SceneManager.night:
		$Night.show()
		$Night.playing = true
