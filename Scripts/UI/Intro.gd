extends Node2D

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const TransitionPlayer2 = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
export(String, FILE, "*.tscn,*.scn") var target_scene

enum TransitionType {
	FADE_TO_BLACK = 0,
}

export var exit_name : String;
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

var tween
var tween2
var length : int
signal done


func _ready():
	SceneManager.loading = true
	PlayerManager.hide_player()
	
	if Music.id != "Jewel_Seeds" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Jewel_Seeds"
		Music.music()
	
	$Text.modulate.a = 0
	$Text2.modulate.a = 0
	yield(get_tree().create_timer(2.3), "timeout")
	$AnimationPlayer.play("Start")
	yield(get_tree().create_timer(1.4), "timeout")
	$AnimationPlayer2.play("Spin")
	yield(get_tree().create_timer(1), "timeout")
	$Text.text = "In this world there is a set of ancient, sacred gemstones..."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$Text.text = "They are known as the seven Jewel Seeds."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer2.play("Inner_Garden")
	$Text.text = "Sealed within the Inner Garden, their mysterious powers are the subject of many legends."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(3), "timeout")
	$Text.text = "No one seems to know exactly what they are capable of..."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$Text.text = "But they are respected by all as a treasure of this land."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$Text.text = "However, one day..."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$Text.text = "A strange force erupted from the Inner Garden."
	tween_go()
	yield(get_tree().create_timer(1.5), "timeout")
	$AnimationPlayer.play("Explosion")
	yield(self, "done")
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer2.play("Comets")
	yield(get_tree().create_timer(1.5), "timeout")
	$Text.text = "The Jewel Seeds were scattered across the world as the Inner Garden was trapped in the odd vortex."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2.5), "timeout")
	$Text.text = "Never before had such a calamity occurred..."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(2.5), "timeout")
	$AnimationPlayer2.play("Edgar")
	yield(get_tree().create_timer(2), "timeout")
	$Text.text = "With the fate of the world in jeopardy..."
	tween_go()
	yield(self, "done")
	yield(get_tree().create_timer(1.5), "timeout")
	$AnimationPlayer2.play("Edgar_Fade")
	yield(get_tree().create_timer(2.5), "timeout")
	$Text2.text = "Will someone save the Jewel Seeds?"
	tween_go2()
	yield(self, "done")
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("Fade")
	Music.fade_out()
	yield(get_tree().create_timer(4), "timeout")
	SE.effect("Drama Blast")
	yield(get_tree().create_timer(3), "timeout")
	var transition = TransitionPlayer2.instance()
	get_tree().get_root().add_child(transition)
	transition.transition_in(target_scene, _get_animation_name())
	#yield(get_tree().create_timer(2), "timeout")
	yield(get_tree().create_timer(0.7), "timeout")
	PlayerManager.show_player()
	SceneManager.loading = false
	
	
func tween_go():
	$Text.modulate.a = 0
	tween = create_tween()
	tween.tween_property($Text, "modulate:a", 1, 0.5)
	length = $Text.text.length()
	if length <= 25:
		length = 25
	$Text.percent_visible = 0.0
	tween2 = create_tween()
	tween2.tween_property($Text, "percent_visible", 1, ((length/25) + 0.85))
	yield(tween2, "finished")
	yield(get_tree().create_timer(2), "timeout")
	tween = create_tween()
	tween.tween_property($Text, "modulate:a", 0, 0.5)
	yield(tween, "finished")
	emit_signal("done")
	
func tween_go2():
	$Text2.modulate.a = 0
	tween = create_tween()
	tween.tween_property($Text2, "modulate:a", 1, 0.5)
	length = $Text2.text.length()
	if length <= 25:
		length = 25
	$Text2.percent_visible = 0.0
	tween2 = create_tween()
	tween2.tween_property($Text2, "percent_visible", 1, ((length/25) + 0.85))
	yield(tween2, "finished")
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("done")
	yield(get_tree().create_timer(1.5), "timeout")
	tween = create_tween()
	tween.tween_property($Text2, "modulate:a", 0, 0.5)
	yield(tween, "finished")
	
	
func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
