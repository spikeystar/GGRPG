extends Node2D

onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

onready var Irina = $YSort/MiddleGround/Irina
onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

onready var Debrando = $YSort/MiddleGround/Debrando
onready var DebrandoPlayer = $YSort/MiddleGround/Debrando/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const event_battle = preload("res://Areas/Cherry Trail/Cherry Trail BA 1.tscn")
onready var target_scene = event_battle.instance()
var event = false
var OG_POS

func _ready():
	SceneManager.location = "Circus"
	if Music.id != "Circus":
		Music.switch_songs()
		Music.id = "Circus"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if SceneManager.time_decided:
		SceneManager.time_decided = false
		
	if EventManager.Debrando:
		$YSort/MiddleGround/BlocksA.queue_free()
		$Boss_Battle.queue_free()
		$Circus9/CollisionPolygon2D.disabled = false
		
		
func _process(delta):
	if Global.battle_ended and event:
		event = false
		EventManager.Debrando = true
	#	Music.unpause()
		SceneManager.SceneEnemies = []
		
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(target_scene)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")	
		Global.battle_ended = false
		Global.battling = false
		
		$YSort/MiddleGround/BlocksA.position.y += 1000
		$Circus9/CollisionPolygon2D.disabled = false
		
		$YSort/MiddleGround/Hoop_Fire.hide()
		$YSort/MiddleGround/Stage_Fire.hide()
		$YSort/Foreground/Stage_Fire2.hide()
		$YSort/MiddleGround/Step.texture_offset.y -= 1000
		$YSort/MiddleGround/Step2.texture_offset.y -= 1000
		$YSort/MiddleGround/Step3.texture_offset.y -= 1000
		$YSort/Shadows/RectangleShadowSmall.show()
		$YSort/Shadows/RectangleShadowSmall2.show()
		
		yield(get_tree().create_timer(0.4), "timeout")
		DebrandoPlayer.play("hop")
		SE.effect("Drama Jump")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gah!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		DebrandoPlayer.play("walk")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "How dare you miserable buffoons try to ruin our fun!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Just wait until Pierre hears about this!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		
		yield(get_tree().create_timer(0.7), "timeout")
		$PoofPlayer.play("Poof")
		SE.effect("Poof")
		yield(get_tree().create_timer(0.2), "timeout")
		Debrando.position.y += 1000
		yield(get_tree().create_timer(1.5), "timeout")
		
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle_f")
		Gary.set_right()
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "He called us buffoons..."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What a weirdo."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "This must be the Lighthouse Key if he was guarding it."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Let's take it and get out of here as soon as we can."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Roger that!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		yield(get_tree().create_timer(0.3), "timeout")
		
		Irina.z_index = 100
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween7 = create_tween()
		tween7.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		var tween8 = create_tween()
		tween8.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween8, "finished")
		Jacques.queue_free()
		Irina.queue_free()
		
		var camera_tween = create_tween()
		var camera_position = Vector2((Gary.motion_root.global_position.x + $Camera2D.player_offset.x), (Gary.motion_root.global_position.y - $Camera2D.z_offset + $Camera2D.player_offset.y))
		camera_tween.tween_property($Camera2D, "global_position", camera_position, 0.5)
		yield(camera_tween, "finished")
		
		$Camera2D.follow_player = true
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		

func _on_Camera2D_animate_Gary():
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.animation("hold_seed")

func _on_Boss_Battle_area_event():
		event = true
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.animation("d_up_r_walk")
		yield(get_tree().create_timer(0.2), "timeout")
		$Camera2D.follow_player = false
		PlayerManager.freeze = true
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $GaryPOS.position, 0.6)
		var camera_tween = create_tween()
		camera_tween.tween_property($Camera2D, "global_position", $CameraPOS.position, 0.6)
		yield(tween, "finished")
		PlayerManager.freeze = true
		Gary.set_right()
		Jacques.position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		Irina.z_index = 100
		$YSort/MiddleGround/Irina/ShadowYSort/ShadowVisualRoot/ShadowCircle.hide()
		var tween2 = create_tween()
		tween2.tween_property(Jacques, "global_position", $JacquesPOS.position, 0.6)
		var tween3 = create_tween()
		tween3.tween_property(Irina, "global_position", $IrinaPOS.position, 0.6)
		yield(tween3, "finished")
		Irina.z_index = 0
		$YSort/MiddleGround/Irina/ShadowYSort/ShadowVisualRoot/ShadowCircle.show()
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle_f")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hold on..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Do you guys smell something burning?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		IrinaPlayer.play("back_idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It kinda smells like a bonfire..."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		Gary.animation("back_hop_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It's making me hungry!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		yield(get_tree().create_timer(0.5), "timeout")
		

		$CanvasPlayer.play("Canvas")
		SE.effect("Drama Flash")
		yield(get_tree().create_timer(0.1), "timeout")
		
		$YSort/MiddleGround/Step.texture_offset.y += 1000
		$YSort/MiddleGround/Step2.texture_offset.y += 1000
		$YSort/MiddleGround/Step3.texture_offset.y += 1000
		$YSort/Shadows/RectangleShadowSmall.hide()
		$YSort/Shadows/RectangleShadowSmall2.hide()
		
		JacquesPlayer.play("shock_back_jump")
		IrinaPlayer.play("shock_back_jump")
		Gary.shock_back_jump()
		$YSort/MiddleGround/Hoop_Fire.show()
		$YSort/MiddleGround/Stage_Fire.show()
		$YSort/Foreground/Stage_Fire2.show()
		
		$YSort/MiddleGround/Trapeze.global_position = $TrapPOS.position
		Debrando.global_position = $DebrandoPOS2.position
		DebrandoPlayer.play("fall")
		var tween6 = create_tween()
		tween6.tween_property($YSort/MiddleGround/Trapeze, "global_position", $TrapPOS2.position, 1)
		var tween5 = create_tween()
		tween5.tween_property(Debrando, "global_position", $DebrandoPOS3.position, 0.8)
		yield(tween5, "finished")
		$YSort/MiddleGround/Trapeze.position.y += 1000
		SE.effect("Drama Thud")
		DebrandoPlayer.play("walk")
	
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well, what do we have here!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("battle_ready")
		IrinaPlayer.play("battle_ready")
		Gary.animation("battle_ready")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Too excited for the new circus and couldn't help but sneak a peek?"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You're hiding something important in that chest, aren't you!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Tsk, tsk, tsk..."
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Don't you know curiosity killed the goat?"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But if you're really dying to find out..."
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I might just let you!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gehehehe!"
		$Camera2D/Interaction/Dialogue/Name.text = "Debrando:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		DebrandoPlayer.play("attack")
		yield(get_tree().create_timer(0.2), "timeout")
		
		#Music.pause()
		BattleMusic.id = "Miniboss_Battle"
		BattleMusic.music()
		Global.battling = true
		get_tree().paused = true
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.transition()
		yield(get_tree().create_timer(1), "timeout")
		transition.queue_free()
		get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(target_scene)
