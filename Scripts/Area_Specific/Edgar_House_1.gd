extends Node2D

onready var Gary = PlayerManager.player_instance

onready var Jacques = $Node2D/Jacques
onready var JacquesPlayer = $Node2D/Jacques/BodyYSort/AnimationPlayer

onready var Edgar = $Node2D/Edgar
onready var EdgarPlayer = $Node2D/Edgar/BodyYSort/AnimationPlayer

onready var Irina = $Node2D/Irina
onready var IrinaPlayer = $Node2D/Irina/BodyYSort/AnimationPlayer

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
		
	if EventManager.Irina_Meetup_CS and not EventManager.Edgar_Check_In_CS:
		EventManager.Edgar_Check_In_CS = true
		$Node2D/Jacques.position = Vector2(1000, 1000)
		PlayerManager.freeze = true
		yield(get_tree().create_timer(0.2), "timeout")
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Gary.walk_right()
		var tween = create_tween()
		tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1.7)
		yield(tween, "finished")
		PlayerManager.freeze = true
		Gary.set_right()
		Jacques.position = Gary.motion_root.global_position
		JacquesPlayer.play("back_walk")
		Irina.position = Gary.motion_root.global_position
		IrinaPlayer.play("front_walk_f")
		var tween2 = create_tween()
		tween2.tween_property(Jacques, "global_position", $Position2D2.position, 0.6)
		var tween3 = create_tween()
		tween3.tween_property(Irina, "global_position", $Position2D3.position, 0.6)
		yield(tween3, "finished")
		JacquesPlayer.play("back_idle_f")
		IrinaPlayer.play("back_idle_f")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Edgar, you were right! Take a look at this!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.animation("suggest")
		$Node2D/JewelSeed.position = $Position2D4.position
		
		yield(get_tree().create_timer(0.5), "timeout")
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I-It was t-true!?"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh my word…!!!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "To see one of the Jewel Seeds up close like this... truly such an honor!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		Gary.set_right()
		EdgarPlayer.play("idle")
		$Node2D/JewelSeed.position = Vector2(5000, 5000)
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "You two did well to protect this Jewel Seed! Good job!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh? And it appears you have a new friend with you?"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hello, I’m Irina! I'm also interested in the Jewel Seeds."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "That's great to hear."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "So, I take it that you all realize the gravity of this situation now?"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("suggest_back")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yeah, we were just talking about it a bit ago..."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "We've decided to look for all the Jewel Seeds and bring them back to the Inner Garden."
		$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("back_idle_f")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Wonderful!"
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I will try to assist you in any way that I can."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "For now, I was able to get some new information about a strange occurrence."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It appears there has been some turmoil down at Puzzle Pier."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Their leader has suddenly gone missing and the circus has been shut down."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "It may not be linked to the Jewel Seeds, but that's where I would suggest to check next."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "However, it looks like Henry hasn't finished repairing the fence that leads that way yet."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "So I guess the rest of our adventure will have to wait..."
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Before you go though, I have this note that I'd like you to read."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Blurb.show()
		$AnimationPlayer.play("open")
		SE.effect("Menu Open")
		yield($Camera2D/Blurb, "done")
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks Edgar!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course, and feel free to stop by here whenever you'd like."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		JacquesPlayer.play("front_walk_f")
		IrinaPlayer.play("back_walk")
		var tween4 = create_tween()
		tween4.tween_property(Jacques, "global_position", $Position2D.position, 0.6)
		var tween5 = create_tween()
		tween5.tween_property(Irina, "global_position", $Position2D.position, 0.6)
		yield(tween5, "finished")
		Jacques.queue_free()
		Irina.queue_free()
		
		PlayerManager.freeze = false
		PlayerManager.cutscene = false
		
		
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
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I wish I could go myself but... I'm simply not fit for such an excursion."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "My joints just aren't what they used to be, hah!"
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
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course! If it's a Jewel Seed then someone has to put it back where it belongs!"
		$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		Gary.set_right()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("front_hop")
		SE.effect("Drama Jump")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'm so glad to hear that! Thank you."
		$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		EdgarPlayer.play("idle")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "As I'm sure you both know, the Jewel Seeds harbor mysterious powers."
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
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hmm, yeah... If this really is true we should try to get there as quick as we can."
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
