extends Node

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
onready var transition = TransitionPlayer.instance()

onready var Gary = PlayerManager.player_instance

var able = false

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
	
func _input(event):
	if Input.is_action_pressed("ui_push") and PlayerManager.sleep and able:
		var tween = create_tween()
		tween.tween_property($Camera2D/Info_Window2, "modulate:a", 0, 0.2)
		yield(get_tree().create_timer(1), "timeout")
		$Camera2D/Info_Window2.hide()
		

func _ready():
	SceneManager.SceneEnemies = []
	SceneManager.location = "Gary's House"
	if Music.id != "Garys_House":
		Music.switch_songs()
		Music.id = "Garys_House"
		#Music.id = "Cherry_Trail"
		Music.music()
	
	if EventManager.new_file:
		Gary.anim_reset()
		PlayerManager.sleep = true
		PlayerManager.ongoing = true
		add_child(transition)
		transition.slow_down_alot()
		transition.ease_in()
		EventManager.new_file = false
		yield(get_tree().create_timer(3), "timeout")
		SE.effect("Select")
		$Camera2D/Info_Window2.modulate.a = 0.6
		$Camera2D/Info_Window2.show()
		var tween = create_tween()
		tween.tween_property($Camera2D/Info_Window2, "modulate:a", 1, 0.2)
		yield(get_tree().create_timer(0.6), "timeout")
		able = true
		
		#SE.effect("Select")
		#$Camera2D/Interaction/Dialogue.show()
		#$Camera2D/Interaction/Dialogue/Name/Talk.text = "Press (Spacebar) to jump!"
		#$Camera2D/Interaction/Dialogue/Name.text = ""
		#$Camera2D/Interaction/Dialogue.talking()
		#yield($Camera2D/Interaction/Dialogue, "talk_done")
		#$Camera2D/Interaction/Dialogue.done()
		#PlayerManager.freeze = true
		
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		PlayerManager.ongoing = false
	
	
	
