extends CanvasLayer

onready var animation_player = $BattleTransitionRect/AnimationPlayer

func transition():
	animation_player.play("StarTransition")
	
func ease_in():
	animation_player.play("TransitionIn")
