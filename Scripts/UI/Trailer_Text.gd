extends Node2D


const TransitionPlayer = preload("res://UI/BattleTransition.tscn")

func _ready():
	SceneManager.loading = true
	PlayerManager.hide_player()
	
	yield(get_tree().create_timer(1.5), "timeout")
	$AnimationPlayer.play("intro")
	$AnimationPlayer2.play("stars")
	yield(get_tree().create_timer(2.6), "timeout")
	
	var transition = TransitionPlayer.instance()
	add_child(transition)
	transition.backwards_star()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()

