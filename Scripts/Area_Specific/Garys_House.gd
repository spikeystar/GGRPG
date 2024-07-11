extends Node

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
onready var transition = TransitionPlayer.instance()

enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;


func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name

func _ready():
	SceneManager.SceneEnemies = []
	if Music.id != "Garys_House":
		Music.switch_songs()
		Music.id = "Garys_House"
		#Music.id = "Cherry_Trail"
		Music.music()
	
	if SceneManager.new_file:
		PlayerManager.sleep = true
		PlayerManager.ongoing = true
		add_child(transition)
		transition.slow_down_alot()
		transition.ease_in()
		SceneManager.new_file = false
		yield(get_tree().create_timer(1.8), "timeout")
		PlayerManager.ongoing = false
	
	
	
