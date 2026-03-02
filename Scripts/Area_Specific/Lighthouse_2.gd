extends Node2D
onready var Gary = PlayerManager.player_instance

onready var Jacques = $Node2D/YSort/Jacques
onready var JacquesPlayer = $Node2D/YSort/Jacques/BodyYSort/AnimationPlayer

onready var Irina = $Node2D/YSort/Irina
onready var IrinaPlayer = $Node2D/YSort/Irina/BodyYSort/AnimationPlayer

onready var Nikolai = $Node2D/Nikolai
onready var NikolaiPlayer = $Node2D/Nikolai/BodyYSort/AnimationPlayer

func _ready():
	SceneManager.SceneEnemies = []
	
	#SceneManager.location = "Pivot Town"
	
	if Music.id != "Puzzle_Pier" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Puzzle_Pier"
		Music.music()
		
	if EventManager.Lighthouse_Intro:
		Nikolai.global_position = Vector2(5000, 5000)
		$Node2D/YSort/Lightbulb.show()
		$Node2D/YSort/BulbShadow.position = Vector2(48.638, -70)
		$Node2D/YSort/SeedShadow.queue_free()
		$Node2D/JewelSeed.queue_free()
		
	if not EventManager.Lighthouse_Intro:
		$Node2D/YSort/BulbShadow.global_position = Vector2(5000, 5000)
		Gary.z_index(100)
		EventManager.Lighthouse_Intro = true
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		NikolaiPlayer.play("idle_back")
		yield(get_tree().create_timer(0.6), "timeout")
		Gary.animation("d_up_r_walk")
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $GaryPOS.position, 1)
		yield(tween, "finished")
		Gary.set_right()
		Jacques.global_position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.global_position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		var tween2 = create_tween()
		tween2.tween_property(Jacques, "global_position", $JacquesPOS.position, 0.6)
		var tween3 = create_tween()
		tween3.tween_property(Irina, "global_position", $IrinaPOS.position, 0.6)
		yield(tween3, "finished")
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle_f")
		yield(get_tree().create_timer(0.4), "timeout")
		
		NikolaiPlayer.play("front_hop")
		SE.effect("Drama Jump")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Who is it!? What are you here for?"
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		NikolaiPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.animation("suggest")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Don't worry! We're here to take the Jewel Seed back to the Inner Garden."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		Gary.set_right()
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "And we're here to set you free too! We just defeated Pierre."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		SE.effect("Drama Jump")
		NikolaiPlayer.play("front_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What a relief! Thank you! Thank you!"
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		NikolaiPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "When Pierre found this Jewel Seed he somehow used his magic to harness its power."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But before I could even get help he locked me away in here!"
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It must have taken a lot of courage to stand up to him."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thank you for your bravery and for saving Puzzle Pier."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We're just happy that you're safe and sound too."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "The workers at the pier have been so worried about you!"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh my, that brings tears to my eyes..."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We must all protect the things that are important to us."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You three!"
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I entrust this Jewel Seed to you."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Please take good care of it."
		$Camera2D/Interaction/Dialogue/Name.text = "Nikolai:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		yield(get_tree().create_timer(0.8), "timeout")
		
		Music.pause()
		SE.effect("Jewel Seeds")
		Gary.animation("hold_seed")
		JacquesPlayer.play("front_idle_f")
		IrinaPlayer.play("back_idle")
		$Node2D/JewelSeed/WorldEnvironment.environment.glow_enabled = true
		$Node2D/YSort/SeedShadow.queue_free()
		$Node2D/JewelSeed.position = $JSPOS1.position
		var tween4 = create_tween()
		tween4.tween_property($Node2D/JewelSeed, "position", $JSPOS2.position, 3)
		
		yield(get_tree().create_timer(8), "timeout")
		
		Music.unpause()
		
		$Node2D/JewelSeed.queue_free()
		Gary.set_right()
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween5 = create_tween()
		tween5.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		var tween6 = create_tween()
		tween6.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween6, "finished")
		Jacques.global_position = Vector2(5000, 5000)
		Irina.global_position = Vector2(5000, 5000)
		
		yield(get_tree().create_timer(0.5), "timeout")
		
		Gary.z_index(0)
		Party.jewel_seeds = 2
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		
		

