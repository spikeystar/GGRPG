extends Node2D

onready var player_instance = PlayerManager.player_instance
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")

func _ready():
	#player_instance.queue_free()
	var transition = TransitionPlayer.instance()
	add_child(transition)
	transition.backwards_star()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
