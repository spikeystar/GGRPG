extends Node

onready var Gary = PlayerManager.player_instance

onready var Jacques = $Node2D/YSort/Jacques
onready var JacquesPlayer = $Node2D/YSort/Jacques/BodyYSort/AnimationPlayer

func _ready():
	SceneManager.SceneEnemies = []
	SceneManager.location = "Berry Lake"
	if Music.id != "Berry_Lake" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Berry_Lake"
		Music.music()
		
	if not EventManager.BL_Inn_CS:
		EventManager.BL_Inn_CS = true
		PlayerManager.freeze = true
		yield(get_tree().create_timer(0.2), "timeout")
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.walk_right()
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1)
		yield(tween, "finished")
		PlayerManager.freeze = true
		Gary.anim_reset()
		Jacques.position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk_f")
		var tween2 = create_tween()
		tween2.tween_property(Jacques, "global_position", $Position2D2.position, 0.5)
		yield(tween2, "finished")
		JacquesPlayer.play("back_idle_f")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Welcome to the Berry Lake Inn!"
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hello, we came here because of that loud crash from last night."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true

		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Have you noticed anything strange around here?"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh! That ruckus sure woke us up alright!"
		$Camera2D/Interaction/Dialogue/Name.text = "Cranston:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It seems like something fell straight into the lake."
		$Camera2D/Interaction/Dialogue/Name.text = "Cranston:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, we had to clean up some of the area by the dock."
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Is there something that you're looking for?"
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Actually yes, we were thinking of checking out the lake if that would be ok."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course, go ahead!"
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "But just to let you know, I saw Reeler down there fishing today..."
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You'd better hope he doesn't find whatever you're looking for first."
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "If he does, he won't let it go without a fight..."
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "He's not someone you want to mess around with!"
		$Camera2D/Interaction/Dialogue/Name.text = "Cranston:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Got it! We'll be careful then."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Please feel free to take a rest at our inn while you're here, we also have lots of items for sale."
		$Camera2D/Interaction/Dialogue/Name.text = "Loqua:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		
		JacquesPlayer.play("back_walk_f")
		var tween3 = create_tween()
		tween3.tween_property(Jacques, "global_position", $Position2D.position, 0.4)
		yield(tween3, "finished")
		Jacques.queue_free()
		
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.cutscene = false
		
		
