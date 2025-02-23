extends Node

onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

onready var Reeler = $YSort/MiddleGround/Reeler
onready var ReelerPlayer = $YSort/MiddleGround/Reeler/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const event_battle = preload("res://Areas/Berry Lake/Berry Lake BA 16.tscn")
onready var target_scene = event_battle.instance()
var event = false


func _ready():
	EventManager.Berry_Lake = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Berry Lake"
	if Music.id != "Berry_Lake" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Berry_Lake"
		Music.music()
		
	if EventManager.BL_Inn_CS:
		$NPC.queue_free()
		$Reeler_Battle/CollisionPolygon2D.disabled = false
		ReelerPlayer.play("hold")
		Reeler.global_position = Vector2(-305, -280)
		$YSort/JewelSeed.position = Vector2(-303.5, -445)
		
	if EventManager.Reeler:
		$NPC.queue_free()
		$YSort/MiddleGround/Reeler.queue_free()
		
func _process(delta):
	if Global.battle_ended and event:
		event = false
		Music.switch_songs()
		Music.id = "Berry_Lake"
		Music.music()
		SceneManager.SceneEnemies = []
		get_tree().get_root().get_node("WorldRoot/Camera2D").remove_child(target_scene)
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_in()
		yield(get_tree().create_timer(0.01), "timeout")
		Global.battle_ended = false
		Global.battling = false
		
		
		JacquesPlayer.play("back_idle")
		Gary.set_right_f()
		yield(get_tree().create_timer(0.5), "timeout")
		SE.effect("Drama Shock")
		ReelerPlayer.play("ouch")
		yield(get_tree().create_timer(0.4), "timeout")
		SE.effect("Drama Land")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Y'OWCH!!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		ReelerPlayer.play("walk")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Fine, you jerks!! Take this stupid rock and leave me alone!"
		$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		ReelerPlayer.play("hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You'll pay for this someday!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Flee")
		ReelerPlayer.play("flee")
		var tween3 = create_tween()
		tween3.tween_property(Reeler, "global_position", $Position2D3.position, 0.3)
		yield(tween3, "finished")
		yield(get_tree().create_timer(0.1), "timeout")
		
		
		var tween4 = create_tween()
		tween4.tween_property(Reeler, "global_position", $Position2D4.position, 1.5)
		yield(tween4, "finished")
		Reeler.queue_free()
		
		yield(get_tree().create_timer(0.5), "timeout")
		
		Music.pause()
		SE.effect("Jewel Seeds")
		Gary.animation("hold_seed")
		JacquesPlayer.play("front_idle")
		$YSort/JewelSeed/WorldEnvironment.environment.glow_enabled = true
		$YSort/JewelSeed.position = $Position2D5.position
		var tween5 = create_tween()
		tween5.tween_property($YSort/JewelSeed, "position", $Position2D6.position, 3)
		
		yield(get_tree().create_timer(8), "timeout")
		
		Music.unpause()
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We did it!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Wow... So this is one of the Jewel Seeds. It's so beautiful."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		Gary.animation("back_hop_f")
		$YSort/JewelSeed.queue_free()
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We have to show Edgar, he's going to be so excited!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.set_left()
		JacquesPlayer.play("front_walk")
		var tween6 = create_tween()
		tween6.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.5)
		yield(tween6, "finished")
		Jacques.queue_free()
		
		Party.jewel_seeds = 1
		PlayerManager.freeze = false
		PlayerManager.cutscene = false

func _on_Reeler_Battle_area_event():
	event = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk_right_f()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1)
	yield(tween, "finished")
	Gary.set_right_f()
	
	Jacques.global_position = Gary.motion_root.global_position
	JacquesPlayer.play("back_walk_f")
	var tween2 = create_tween()
	tween2.tween_property(Jacques, "global_position", $Position2D2.position, 0.6)
	yield(tween2, "finished")
	JacquesPlayer.play("back_idle")
	
	SE.effect("Select")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Woah, what kind of weird rock is this? Is it some sort of gemstone?"
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("suggest_back_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ah! Excuse me, but we really need to take that thing back to... err... somewhere..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("back_idle")
	Reeler.global_position = Vector2(-312, -288)
	ReelerPlayer.play("walk")
	$YSort/JewelSeed.position = Vector2(1000, 1000)
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Huh? Who are you two?"
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "And why would I just give you this? I found it so it's MINE."
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	Gary.animation("back_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You don't understand! That's definitely one of the Jewel Seeds!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "We really should put it back where it belongs!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("exhaust_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Gary... Don't tell him that..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true

	JacquesPlayer.play("back_idle")
	ReelerPlayer.play("hop")
	SE.effect("Drama Jump")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "JEWEL SEEDS!?"
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	ReelerPlayer.play("walk")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You're telling me this thing is one of the Jewel Seeds!?"
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	ReelerPlayer.play("hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh boy, I could sell this for a fortune!"
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	ReelerPlayer.play("walk")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You pipsqueaks are out of your minds if you think I'll be handing this over."
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Music.switch_songs()
	Music.id = "High_Tension"
	Music.music()
	
	Gary.animation("battle_ready_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "No way! We're taking that Seed back whether you like it or not!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("battle_ready_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "He's right. I hope you're ready for a fight!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hah! Bring it on! I'll show you who's boss around here."
	$Camera2D/Interaction/Dialogue/Name.text = "Reeler:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	$YSort/JewelSeed/WorldEnvironment.environment.glow_enabled = false
	
	ReelerPlayer.play("attack")
	yield(get_tree().create_timer(0.6), "timeout")
	
	Music.pause()
	BattleMusic.id = "Boss_Battle"
	BattleMusic.music()
	Global.battling = true
	get_tree().paused = true
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition()
	yield(get_tree().create_timer(0.9), "timeout")
	transition.queue_free()
	get_tree().get_root().get_node("WorldRoot/Camera2D").add_child(target_scene)
