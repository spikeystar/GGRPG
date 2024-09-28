extends Node

onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

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
		$YSort/MiddleGround/Jacques.queue_free()
		$YSort/MiddleGround/Edgar.queue_free()
		$Jacques_Meetup.queue_free()
		$CollisionRoot/NPC3.queue_free()

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
	Music.quiet()
	SE.effect("Party Joined")
	$Camera2D/Info_Window/First_Text.text = "Jacques joined your party!"
	$Camera2D.announcement()
	PartyStats.party_members = 2
	yield(get_tree().create_timer(1.8), "timeout")
	Music.loud()
	Gary.anim_reset()
	PlayerManager.freeze = false
	PlayerManager.cutscene = false
	$CollisionRoot/NPC3.queue_free()
