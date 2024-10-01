extends Node

onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

onready var Irina = $YSort/MiddleGround/Irina
onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

onready var Edgar = $YSort/MiddleGround/Edgar
onready var EdgarPlayer = $YSort/MiddleGround/Edgar/BodyYSort/AnimationPlayer

func _ready():
	EventManager.Pivot_Town = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Pivot Town"
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
		
	if EventManager.Jacques_Meetup_CS:
		$YSort/MiddleGround/Jacques.position = Vector2(5000, 5000)
		$YSort/MiddleGround/Edgar.queue_free()
		$Jacques_Meetup.queue_free()
		$CollisionRoot/NPC3.queue_free()
		$CollisionRoot/Edgar_Door/CollisionPolygon2D.disabled = false
		
	if EventManager.Edgar_Tea_CS:
		$YSort/MiddleGround/Edgar.queue_free()
		$YSort/Backarea/Fence5.queue_free()
		$YSort/Backarea/Fence6.queue_free()
		$YSort/Backarea/Fence7.position = Vector2(763, -775)
		$YSort/Backarea/Fence8.position = Vector2(851, -734)
		$CollisionRoot/PivotTown3/CollisionPolygon2D.disabled = false
		
	if EventManager.Reeler and not EventManager.Irina_Intro_CS:
		EventManager.Irina_Intro_CS = true
		$Irina_Meetup/CollisionPolygon2D.disabled = false
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		yield(get_tree().create_timer(0.3), "timeout")
		$Camera2D.follow_player = false
		var og_position = $Camera2D.position
		Irina.position = $Position2D7.position
		IrinaPlayer.play("worry_front")
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", $Position2D7.position, 3)
		yield(tween, "finished")
		
		SE.effect("Select")
		$Camera2D/Interaction/Dialogue.show()
		$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, what should I do... I really need someone's help..."
		$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
		$Camera2D/Interaction/Dialogue.talking()
		yield($Camera2D/Interaction/Dialogue, "talk_done")
		$Camera2D/Interaction/Dialogue.done()
		PlayerManager.freeze = true
		
		var tween2 = create_tween()
		tween2.tween_property($Camera2D, "position", og_position, 3)
		yield(tween2, "finished")
		$Camera2D.follow_player = true
		PlayerManager.freeze = false
		PlayerManager.cutscene = false

func _on_Jacques_Meetup_area_event():
	EventManager.Jacques_Meetup_CS = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1)
	yield(tween, "finished")
	Gary.set_right()
	
	SE.effect("Select")
	JacquesPlayer.play("suggest_front")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hey, thanks for coming into town."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You heard that loud crash last night, yeah? It woke up a lot of us in Needlepoint."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("front_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well no... but I heard -about- it!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true

	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hah, of course..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Anyways, I think it was something that crashed into Mt. Tiptop."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I figured we could go check it out and have a little adventure."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yeah that sounds fun!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "There's only one problem..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "After I came into town from Needlepoint there was a big landslide because of the crash."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I don't think we'll be able to get back there for a while..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Shoot! What do you think happened anyways?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Did anyone actually see what crashed into the mountain?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Not that I know of..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "But someone here in town told me they think they heard a different crash closer by..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	EdgarPlayer.play("front_hop")
	SE.effect("Drama Jump")
	yield(get_tree().create_timer(0.5), "timeout")
	
	EdgarPlayer.play("idle")
	var tween2 = create_tween()
	tween2.tween_property(Edgar, "global_position", $Position2D2.position, 1)
	yield(tween2, "finished")
	
	EdgarPlayer.play("idle_f")
	var tween3 = create_tween()
	tween3.tween_property(Edgar, "global_position", $Position2D3.position, 1.4)
	yield(tween3, "finished")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Excuse me!"
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.set_right_f()
	JacquesPlayer.play("back_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Pardon my eavesdropping, but would you boys happen to be talking about the event from last night?"
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ah, yeah we are actually. Is there something that you're wondering?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well, I have a theory about what might of happened... And it's something very important!"
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "If you don't mind, would you care to come to my home for some tea?"
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	EdgarPlayer.play("idle_back_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I can tell you more there. I live just around the corner in that house to the top left."
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	EdgarPlayer.play("idle_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Sure, why not!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I know we've seen you around here before, but what was your name again?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "My name is Edgar, it's nice to meet you both."
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	EdgarPlayer.play("front_hop_f")
	SE.effect("Drama Jump")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'll go on ahead and get that tea started."
	$Camera2D/Interaction/Dialogue/Name.text = "Edgar:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	EdgarPlayer.play("idle_back")
	var tween4 = create_tween()
	tween4.tween_property(Edgar, "global_position", $Position2D2.position, 1)
	yield(tween4, "finished")
	
	EdgarPlayer.play("idle_back_f")
	var tween5 = create_tween()
	tween5.tween_property(Edgar, "global_position", $Position2D4.position, 1.3)
	yield(tween5, "finished")
	
	EdgarPlayer.play("idle_f")
	var tween6 = create_tween()
	tween6.tween_property(Edgar, "global_position", $Position2D5.position, 0.8)
	yield(tween6, "finished")
	
	EdgarPlayer.play("idle_back_f")
	var tween7 = create_tween()
	tween7.tween_property(Edgar, "global_position", $Position2D6.position, 0.7)
	yield(tween7, "finished")
	SE.effect("Door")
	Edgar.queue_free()

	Gary.set_right()
	JacquesPlayer.play("front_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "This sounds interesting, let's see what this guy has to say."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "If anything, we might just get a good laugh if he just has some bonkers theory."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("front_walk")
	var tween8 = create_tween()
	tween8.tween_property(Jacques, "global_position", $Position2D.position, 0.7)
	yield(tween8, "finished")
	Jacques.queue_free()
	yield(get_tree().create_timer(0.3), "timeout")
	Gary.smile()
	Music.pause()
	SE.effect("Party Joined")
	$Camera2D/Info_Window/First_Text.text = "Jacques joined your party!"
	$Camera2D.announcement()
	PartyStats.party_members = 2
	yield(get_tree().create_timer(1.8), "timeout")
	Music.unpause()
	Gary.anim_reset()
	PlayerManager.freeze = false
	PlayerManager.cutscene = false
	$CollisionRoot/NPC3.queue_free()


func _on_Irina_Meetup_area_event():
	EventManager.Irina_Meetup_CS = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, excuse me!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.walk()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D8.position, 1)
	yield(tween, "finished")
	Gary.set_right()
	Jacques.position = Gary.motion_root.position
	JacquesPlayer.play("front_walk_f")
	var tween2 = create_tween()
	tween2.tween_property(Jacques, "global_position", $Position2D9.position, 0.8)
	yield(tween2, "finished")
	JacquesPlayer.play("back_idle_f")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'm sorry this is so out of the blue, but do you have some time?"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("suggest_back")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Ah, that's ok. What's the problem?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("back_idle_f")
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I came here from Tower Town and there's been a huge disaster!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("worry")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "All of the robots have suddenly started attacking everyone! I ran here to get some help."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("worry_back")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "And what's more is..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Shock")
	IrinaPlayer.play("shock_front_jump")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "The Jewel Seeds have been scattered from the Inner Garden!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield(get_tree().create_timer(0.4), "timeout")
	SE.effect("Drama Land")
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("front_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "W-why don't you look more surprised!?"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Did you not hear me? The Jewel Seeds are gone from the Inner Garden!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true

	Gary.set_left()
	JacquesPlayer.play("back_idle")
	yield(get_tree().create_timer(1), "timeout")
	Gary.set_right()
	JacquesPlayer.play("back_idle_f")
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh sorry, we heard you. It's just that we picked one of them up a bit ago."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("shock_front")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "O-one of the Jewel Seeds!?"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yeah, here we can show you!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.animation("suggest")
	$YSort/JewelSeed.position = $Position2D10.position
	yield(get_tree().create_timer(0.5), "timeout")
	
	SE.effect("Drama Shock")
	IrinaPlayer.play("shock_front_jump")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "!!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield(get_tree().create_timer(0.4), "timeout")
	SE.effect("Drama Land")
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("shock_front")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh my…!!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I can't believe it! It's one of the Jewel Seeds!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You're planning to take it back to the Inner Garden, aren't you?"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.set_right()
	$YSort/JewelSeed.position = Vector2(5000, 5000)
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, that's a relief to hear. It would be a disaster for them to fall into the wrong hands."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "What were you saying about the trouble in Tower Town?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "That's right, I nearly forgot!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "The robot situation might not be related to the Jewel Seeds, but it's definitely suspicious..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "In any case, I was hoping to find some help here."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "But right after I arrived there was a big landslide and now I can't even get back to Tower Town!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "But you have wings, don't you? Couldn't you just fly?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("worry_back")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I don't know how to fly..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "You have wings but you can't fly?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("cry_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Yes, that's right!! I don't know how to fly!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield(get_tree().create_timer(0.2), "timeout")
	IrinaPlayer.play("cry")
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Oh, everything is such a mess! I'm so stressed and worried!!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	Gary.animation("back_hop_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Hey, hey, it's ok! This gives me an idea."
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "How about you come along with us to find the rest of the Jewel Seeds?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "And once the landslide is cleared away we can help you out in Tower Town!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true

	Gary.set_left()
	JacquesPlayer.play("back_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Wait Gary..."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Do you really think we can handle finding -all- of the Jewel Seeds ourselves?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Of course we can! And look, now we have some more help!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.set_right()
	JacquesPlayer.play("back_idle_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "So what do you say?"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	IrinaPlayer.play("worry_front")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Well... I do think it's the right thing to try and find all of the Jewel Seeds..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "And since it doesn't seem like we'll be getting back to Tower Town anytime soon..."
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	SE.effect("Drama Jump")
	IrinaPlayer.play("front_hop")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Alright, I'll join you!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("suggest_back")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "What is your name by the way?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("back_idle_f")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "I'm Irina! It's nice to meet you!"
	$Camera2D/Interaction/Dialogue/Name.text = "Irina:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Thanks for coming with us! We're glad to have you!"
	$Camera2D/Interaction/Dialogue/Name.text = "Gary:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Alright, I'm on board too."
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	Gary.set_left()
	JacquesPlayer.play("back_idle")
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Let's go talk to Edgar before we make any other plans though, ok?"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	$Camera2D/Interaction/Dialogue.show()
	$Camera2D/Interaction/Dialogue/Name/Talk.text = "Maybe he'll know more about where the other Jewels Seeds are by now too!"
	$Camera2D/Interaction/Dialogue/Name.text = "Jacques:"
	$Camera2D/Interaction/Dialogue.talking()
	yield($Camera2D/Interaction/Dialogue, "talk_done")
	$Camera2D/Interaction/Dialogue.done()
	PlayerManager.freeze = true
	
	JacquesPlayer.play("back_walk")
	var tween3 = create_tween()
	tween3.tween_property(Jacques, "global_position", $Position2D8.position, 0.7)
	yield(tween3, "finished")
	Jacques.queue_free()
	
	IrinaPlayer.play("front_walk")
	var tween4 = create_tween()
	tween4.tween_property(Irina, "global_position", $Position2D8.position, 0.7)
	yield(tween4, "finished")
	Irina.queue_free()
	
	yield(get_tree().create_timer(0.3), "timeout")
	Gary.smile()
	Music.pause()
	SE.effect("Party Joined")
	$Camera2D/Info_Window/First_Text.text = "Irina joined your party!"
	$Camera2D.announcement()
	PartyStats.party_members = 3
	yield(get_tree().create_timer(1.8), "timeout")
	Music.unpause()
	Gary.anim_reset()
	PlayerManager.freeze = false
	PlayerManager.cutscene = false
	
