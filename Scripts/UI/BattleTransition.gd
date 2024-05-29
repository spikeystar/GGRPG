extends CanvasLayer

onready var animation_player = $BattleTransitionRect/AnimationPlayer

func transition():
	animation_player.play("StarTransition")
	
func backwards_star():
	animation_player.play_backwards("StarTransition")
	
func ease_in():
	animation_player.play("TransitionIn")

func speed_up():
	animation_player.playback_speed = 1
