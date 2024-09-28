extends Node2D

onready var Gary = PlayerManager.player_instance
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const event_battle = preload("res://Areas/Cherry Trail/Cherry Trail BA 6.tscn")
onready var target_scene = event_battle.instance()
var event = false

func _ready():
	SceneManager.location = "Cherry Trail"
	if Music.id != "Cherry_Trail":
		Music.switch_songs()
		Music.id = "Cherry_Trail"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if EventManager.Tindrum:
		$YSort/Tindrum.queue_free()
	
func _process(delta):
	if Global.battle_ended and event:
		EventManager.Tindrum = true
		#after_battle()
		Music.unpause()
		SceneManager.SceneEnemies = []
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(target_scene)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		Global.battle_ended = false
		Global.battling = false
		
		Gary.anim_reset()
		$YSort/Tindrum.queue_free()
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Sheesh. Well I hope that bully learned his lesson..."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I hope I haven't kept Jacques waiting too long!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		
		event = false
		PlayerManager.cutscene = false
		PlayerManager.freeze = false

func _on_Event_area_event():
	event = true
	PlayerManager.freeze = true
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hey! Wait a minute!"
	$Camera2D/Interaction/Dialogue/Name.text = "Tindrum:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk_right()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 0.5)
	yield(tween, "finished")
	Gary.anim_reset()
	PlayerManager.cutscene = false
	SE.effect("Drama Descend")
	$YSort/Tindrum/BodyYSort/AnimationPlayer.play("fall")
	var tween2 = create_tween()
	tween2.tween_property($YSort/Tindrum, "global_position", $Position2D2.position, 1)
	yield(tween2, "finished")
	SE.effect("Drama Land")
	$YSort/Tindrum/BodyYSort/AnimationPlayer.play("idle")
	
	yield(get_tree().create_timer(0.6), "timeout")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "If you wanna pass through here, you're gonna have to pay a fee!"
	$Camera2D/Interaction/Dialogue/Name.text = "Tindrum:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "No way! You can't just stop people from going into town."
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hah, I sure CAN! And it looks like you want to find out the hard way."
	$Camera2D/Interaction/Dialogue/Name.text = "Tindrum:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	PlayerManager.cutscene = true
	Gary.battle_ready()
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "We'll see about that!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Music.pause()
	BattleMusic.id = "Standard_Battle"
	BattleMusic.music()
	Global.battling = true
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(target_scene)
	
