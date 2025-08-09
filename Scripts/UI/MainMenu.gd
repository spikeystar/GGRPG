extends Node2D

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const TransitionPlayer2 = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
onready var Gary = PlayerManager.player_instance

enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

var able = false

func _ready():
	SceneManager.loading = true
	SceneManager.game_over = false
	SceneManager.enemy_turn = false

	Global.battle_ended = false
	Global.battling = false
	
	PlayerManager.cutscene = false
	PlayerManager.freeze = false
	Gary.set_right()
	
	
	
	yield(get_tree().create_timer(1.5), "timeout")
	$AnimationPlayer2.play("Intro")
	
	yield(get_tree().create_timer(2.6), "timeout")
	
	if Music.id != "Standard_Battle":
		Music.switch_songs()
		Music.id = "Standard_Battle"
		Music.music()
		Music.loud_2()
	
	var transition = TransitionPlayer.instance()
	add_child(transition)
	transition.backwards_star()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	able = true
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able:
		SE.effect("Switch")
		Music.quiet_2()
		able = false
		var transition = TransitionPlayer2.instance()
		get_tree().get_root().add_child(transition)
		transition.transition_in(target_scene, _get_animation_name())

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
