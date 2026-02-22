extends Node
onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const event_battle = preload("res://Areas/Kugi Canyon/Kugi Canyon BA 11.tscn")
onready var target_scene = event_battle.instance()
var event = false


func _ready():
	EventManager.Kugi_Canyon = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Kugi Canyon"
	if Music.id != "Kugi_Canyon" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Kugi_Canyon"
		Music.music()
		
	if EventManager.Saguarotel:
		$AnimationPlayer.queue_free()
		$YSort/MiddleGround/Saguarotel.queue_free()
		$BerryLake1/CollisionPolygon2D.disabled = false

	
func _process(delta):
	if Global.battle_ended and event:
		event = false
		Music.unpause()
		SceneManager.SceneEnemies = []
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(target_scene)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		Global.battle_ended = false
		Global.battling = false
		
		Gary.set_right()
		Gary.motion_root.global_position = $Position2D.position
		Jacques.global_position = $Position2D2.position
		JacquesPlayer.play("back_idle_f")
		$AnimationPlayer.queue_free()
		$YSort/MiddleGround/Saguarotel.queue_free()
		yield(get_tree().create_timer(1), "timeout")
		SE.effect("Select")
		
		Gary.animation("back_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Jeez, that caught me off guard!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_front_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yeah... We're almost at Berry Lake though, let's keep going."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_walk_f")
		var tween = create_tween()
		tween.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween, "finished")
		Jacques.queue_free()
		
		$BerryLake1/CollisionPolygon2D.disabled = false
		PlayerManager.freeze = false
		PlayerManager.cutscene = false


func _on_Boss_Battle_area_event():
	event = true
	EventManager.Saguarotel_Intro = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.animation("d_up_r_walk")
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1)
	yield(tween, "finished")
	Gary.z_index(100)
	Gary.set_right()
	Jacques.position = Gary.motion_root.global_position
	JacquesPlayer.play("back_walk")
	var tween2 = create_tween()
	tween2.tween_property(Jacques, "global_position", $Position2D2.position, 0.5)
	yield(tween2, "finished")
	JacquesPlayer.play("back_idle_f")
	Gary.z_index(0)
	SE.effect("Select")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hmm, it looks like this big cactus is blocking the way."
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Doesn't it look kind of strange to you?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("back_walk")
	var tween3 = create_tween()
	tween3.tween_property(Jacques, "global_position", $Position2D3.position, 0.8)
	yield(tween3, "finished")
	
	JacquesPlayer.play("back_walk_f")
	var tween4 = create_tween()
	tween4.tween_property(Jacques, "global_position", $Position2D4.position, 0.8)
	yield(tween4, "finished")
	
	JacquesPlayer.play("suggest_front_f")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Something seems off about it to me..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.animation("worry_back")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Really? What do you mean?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.walk_right()
	var tween5 = create_tween()
	tween5.tween_property(Gary.motion_root, "global_position", $Position2D5.position, 0.7)
	yield(tween5, "finished")
	Gary.set_right()
	$AnimationPlayer.play("wiggle")
	JacquesPlayer.play("shock_front_f")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "W-wait don't get too close! I think it's moving!"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$AnimationPlayer.play("wiggle2")
	Gary.animation("shock_back")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gah! You're right!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Music.pause()
	BattleMusic.id = "Miniboss_Battle"
	BattleMusic.music()
	Global.battling = true
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(target_scene)
