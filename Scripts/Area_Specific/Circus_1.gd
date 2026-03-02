extends Node2D
onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

onready var Irina = $YSort/MiddleGround/Irina
onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

onready var Pierre = $YSort/MiddleGround/Pierre
onready var PierrePlayer = $YSort/MiddleGround/Pierre/BodyYSort/AnimationPlayer

onready var Calico = $YSort/MiddleGround/Calico
onready var CalicoPlayer = $YSort/MiddleGround/Calico/BodyYSort/AnimationPlayer

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
		$YSort/MiddleGround/BlocksB.queue_free()
		
	if not EventManager.Circus_Intro:
		EventManager.Circus_Intro = true
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Pierre.global_position = $PierrePOS.global_position
		Calico.global_position = $CalicoPOS.global_position
		PierrePlayer.play("idle_back_f")
		CalicoPlayer.play("idle")
		Gary.animation("d_up_r_idle")
		yield(get_tree().create_timer(0.8), "timeout")
		$Camera2D.follow_player = false
		var camera_tween = create_tween()
		camera_tween.tween_property($Camera2D, "global_position", $CameraPOS.position, 2.5)
		yield(camera_tween, "finished")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Sir, we're just about done setting up the circus as you asked."
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Perfect, perfect!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Once we're really in business everyone will forget about the old Puzzle Pier."
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It's time for me to lead a new era of entertainment!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes sir, it will be a stunning sight to behold!"
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But are you sure that no one will find the Jewel Seed that you locked up in the Lighthouse?"
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		PierrePlayer.play("back_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hush, you idiot!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		PierrePlayer.play("idle_back_f")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You better hope no one overheard you!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		CalicoPlayer.play("hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Eeek!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.25), "timeout")
		CalicoPlayer.play("idle")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'm sorry, I'm sorry!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "As long as I have that Jewel Seed I'll be invincible, you hear me?"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Even if some worm were to come across it, they would pose no threat to me, the great Pierre!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Drama Jump")
		PierrePlayer.play("back_hop")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Now get back to work!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		PierrePlayer.play("idle_back_f")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I want this circus polished down to the very last peanut!"
		$Camera2D/Interaction/Dialogue/Name.text = "Pierre:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, sir!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Calico:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		var tween = create_tween()
		tween.tween_property(Pierre, "global_position", $CameraPOS.position, 0.5)
		yield(tween, "finished")
		PierrePlayer.play("idle_back")
		var tween2 = create_tween()
		tween2.tween_property(Pierre, "global_position", $PierrePOS2.position, 0.8)
		yield(tween2, "finished")
		Pierre.global_position = Vector2(5000, 5000)
		yield(get_tree().create_timer(0.5), "timeout")
		var tween3 = create_tween()
		tween3.tween_property(Calico, "global_position", $CameraPOS.position, 0.5)
		yield(tween3, "finished")
		CalicoPlayer.play("idle_back")
		var tween4 = create_tween()
		tween4.tween_property(Calico, "global_position", $PierrePOS2.position, 0.8)
		yield(tween4, "finished")
		Calico.global_position = Vector2(5000, 5000)
		
		var camera_tween2 = create_tween()
		#var camera_position = Vector2((Gary.motion_root.global_position.x + $Camera2D.player_offset.x), (Gary.motion_root.global_position.y - $Camera2D.z_offset + $Camera2D.player_offset.y))
		var camera_position = Vector2(20, -55)
		camera_tween2.tween_property($Camera2D, "global_position", camera_position, 2.5)
		yield(camera_tween2, "finished")
		$Camera2D.follow_player = true
		
		Gary.animation("d_up_r_walk")
		var tween5 = create_tween()
		tween5.tween_property(Gary.motion_root, "global_position", $GaryPOS.position, 1)
		yield(tween5, "finished")
		Gary.set_right()
		Jacques.global_position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.global_position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		Irina.z_index = 100
		var tween6 = create_tween()
		tween6.tween_property(Jacques, "global_position", $JacquesPOS.position, 0.6)
		var tween7 = create_tween()
		tween7.tween_property(Irina, "global_position", $IrinaPOS.position, 0.6)
		yield(tween7, "finished")
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Did you hear that!?"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "So there really is a Jewel Seed here!"
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "This is not good..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'm willing to bet that guy has something to do with the missing owner too."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We better find that Lighthouse Key quick!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		yield(get_tree().create_timer(0.3), "timeout")
		
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween8 = create_tween()
		tween8.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		var tween9 = create_tween()
		tween9.tween_property(Irina, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween9, "finished")
		Jacques.global_position = Vector2(5000, 5000)
		Irina.global_position = Vector2(5000, 5000)
		
		yield(get_tree().create_timer(0.3), "timeout")
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
