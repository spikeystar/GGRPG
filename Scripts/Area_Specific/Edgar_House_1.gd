extends Node2D

onready var Gary = PlayerManager.player_instance

onready var Jacques = $Node2D/Jacques
onready var JacquesPlayer = $Node2D/Jacques/BodyYSort/AnimationPlayer

onready var Edgar = $Node2D/Edgar
onready var EdgarPlayer = $Node2D/Edgar/BodyYSort/AnimationPlayer

const TransitionPlayer = preload("res://UI/BattleTransition.tscn")

func _ready():
	PlayerManager.ongoing = false
	SceneManager.location = "Pivot Town"
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
		
	if EventManager.Edgar_Tea_CS:
		$Node2D/Jacques.position = Vector2(1000, 1000)
		
	if not EventManager.Edgar_Tea_CS:
		EventManager.Edgar_Tea_CS = true
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.speed_up()
		transition.ease_in()
		yield(get_tree().create_timer(0.1), "timeout")
		PlayerManager.freeze = true
		JacquesPlayer.play("back_idle_f")
		Gary.motion_root.global_position = Vector2(190, 94)
		Gary.set_right()
		yield(get_tree().create_timer(0.4), "timeout")
		PlayerManager.freeze = true
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks for the tea, Edgar. That was really nice!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true

		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "So you were saying that you're a geologist, right?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, though I suppose technically not anymore since I've retired..."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "However, that's partly why I think those objects from the sky weren't just anything normal."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You see, last night I was out late and happened to see one of them falling towards Berry Lake."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "And based on the way it glowed... and the color of the light..."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I don't mean to shock you two, but..."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I believe it was one of the Jewel Seeds!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("idle")
		JacquesPlayer.play("shock_back_jump")
		Gary.shock_back_jump()
		SE.effect("Drama Shock")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "The Jewel Seeds!?"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield(get_tree().create_timer(0.4), "timeout")
		SE.effect("Drama Land")
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		Gary.set_right()
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "B-but that would be a catastrophe! How could this have happened!?"
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Your guess is as good as mine on that part..."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What I do know is that it is certainly worth confirming with our own eyes."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I wish I could go myself but... I am simply too old for such an excursion."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "My joints just aren’t what they used to be, hah!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "This is why I was so keen to ask you boys to meet with me."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "What do you say? Would you be willing to go to Berry Lake and see if it really was a Jewel Seed?"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_idle_f")
		Gary.set_right_f()
		yield(get_tree().create_timer(1), "timeout")
		JacquesPlayer.play("back_idle_f")
		Gary.animation("back_hop_f")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course! If it's the Jewel Seeds then someone has to put them back where they belong!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		Gary.set_right()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I’m so glad to hear that! Thank you."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "As I'm sure you both know, the Jewel Seeds harbor mysterious power."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "If they fall into nefarious hands it could mean horrible things will happen."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We should hope that no one with bad intentions finds them first!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hmm, yes. If this really is true we should try to get there as quick as we can."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "The fastest way to Berry Lake is through Kugi Canyon."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "The path under the archway will lead you there."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "In the meantime, I'll research any other occurances that could be linked to a Jewel Seed."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks, Edgar! We'll let you know what happens."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_walk_f")
		var tween = create_tween()
		tween.tween_property(Jacques, "global_position", Gary.motion_root.global_position, 0.6)
		yield(tween, "finished")
		Jacques.queue_free()
		
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
