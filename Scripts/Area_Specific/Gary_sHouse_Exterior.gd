extends Node

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
export(String, FILE, "*.tscn,*.scn") var target_scene

const TransitionPlayer2 = preload("res://UI/BattleTransition.tscn")
onready var transition2 = TransitionPlayer2.instance()

const event_battle = preload("res://Areas/Cherry Trail/Tutorial BA.tscn")
onready var tutorial_scene = event_battle.instance()
var event = false

onready var Gary = PlayerManager.player_instance

onready var Michael = $YSort/Michael
onready var MichaelPlayer = $YSort/Michael/BodyYSort/AnimationPlayer

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
	SceneManager.location = "Gary's House"
	if Music.id != "Garys_House":
		Music.switch_songs()
		Music.id = "Garys_House"
		#Music.id = "Cherry_Trail"
		Music.music()
		
		
	if EventManager.new_file:
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		add_child(transition2)
		transition2.slow_down_alot()
		transition2.ease_in()
		yield(get_tree().create_timer(0.2), "timeout")
	
		$Camera2D.follow_player = false
		$Camera2D.position = Vector2(22, -520)
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(22, -180), 6)
		yield(tween, "finished")
		
		yield(get_tree().create_timer(1), "timeout")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gary!"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gary, wake up!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It's me Michael, the mail mole!"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.transition_in(target_scene, _get_animation_name())
		yield(get_tree().create_timer(2), "timeout")
		
		
		
		
	if EventManager.first_save:
		$SaveStarIntro2/CollisionPolygon2D.disabled = true
		$SaveStarIntro/CollisionPolygon2D.disabled = true
		$CollisionRoot/DoorwayToCherryTrail1/CollisionPolygon2D.disabled = false
		
	if EventManager.Michael_Meetup_CS:	
		$Michael_Stall.queue_free()
		$YSort/Michael.queue_free()
		
	
func _process(delta):
	if EventManager.first_save:
		$SaveStarIntro2/CollisionPolygon2D.disabled = true
		$CollisionRoot/DoorwayToCherryTrail1/CollisionPolygon2D.disabled = false
	
	if Global.battle_ended and event:
		$Camera2D.current = true
		$Camera2D.follow_player = true
		event = false
		Music.unpause()
		SceneManager.SceneEnemies = []
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(tutorial_scene)
		var transition = TransitionPlayer2.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		Global.battle_ended = false
		Global.battling = false
		
		Gary.set_right()
		
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I think you should be all set now!"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Don’t forget you can always check the pause menu by pressing (Option)"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks, Michael!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "See you later!"
		$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Ascend")
		MichaelPlayer.play("exit")
		yield(get_tree().create_timer(0.7), "timeout")
		SE.effect("Drama Thud")
		EventManager.Michael_Meetup_CS = true
		$Michael_Stall.queue_free()
	
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
	

func _on_Michael_Meetup_area_event():
	event = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk_left()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1.2)
	yield(tween, "finished")
	Gary.set_right()
	
	SE.effect("Select")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Morning, Michael! You have some letters for me?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "No letters today, just a message from Jacques."
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true

	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "A message from Jacques? Does he want to meet in town?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	MichaelPlayer.play("hand")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yep, he wants to meet in Pivot Town and talk about that loud noise from last night."
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	MichaelPlayer.play("idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "What loud noise? Did something happen?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	MichaelPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You didn't hear it!? I swear you could sleep through anything..."
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	MichaelPlayer.play("idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Last night something fell from the sky near here and made a loud crash."
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "It seems like there have been a couple other places where something similar happened too..."
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, that's so weird..."
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ok! Well, I'll head to Pivot Town to see Jacques right away."
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "By the way, there's lots of monsters out lately. Do you want a reminder on how battling works?"
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/TutorialOptions.show()
	$Camera2D/TutorialOptions/MenuCursor.cursor_ready()
	yield($Camera2D/TutorialOptions, "chosen")
	
	
func _on_TutorialOptions_no():
	SE.effect("Select")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Sounds good, I'll be off then. See you later!"
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Ascend")
	MichaelPlayer.play("exit")
	yield(get_tree().create_timer(0.7), "timeout")
	SE.effect("Drama Thud")
	EventManager.Michael_Meetup_CS = true
	Gary.set_right()
	$Michael_Stall.queue_free()
	
	PlayerManager.freeze = false
	PlayerManager.cutscene = false


func _on_TutorialOptions_yes():
	SE.effect("Select")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ok, let's get started!"
	$Camera2D/Interaction/Dialogue/Name.text = "Michael:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Music.pause()
	BattleMusic.id = "Standard_Battle"
	BattleMusic.music()
	Global.battling = true
	get_tree().paused = true
	var transition = TransitionPlayer2.instance()
	get_tree().get_root().add_child(transition2)
	transition2.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition2.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(tutorial_scene)
