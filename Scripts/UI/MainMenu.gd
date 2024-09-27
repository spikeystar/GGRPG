extends Node2D

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const TransitionPlayer2 = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")

enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

func _ready():
	SceneManager.loading = true
	PlayerManager.hide_player()
	
	var transition = TransitionPlayer.instance()
	add_child(transition)
	transition.backwards_star()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	
func _input(event):
	if Input.is_action_just_pressed("ui_select"):
		var transition = TransitionPlayer2.instance()
		get_tree().get_root().add_child(transition)
		transition.transition_in(target_scene, _get_animation_name())

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
