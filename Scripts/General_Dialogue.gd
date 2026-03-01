extends Sprite
var npc_name : String
var tween
var cursor_ready = false
signal text_ready
signal talk_done
signal restart
signal quest_item
signal event_trigger
var length : int
var alternate = false
var js = Party.jewel_seeds

var dolly_quest


onready var Gary = PlayerManager.player_instance

func _on_NPC_general_dialogue():
	npc_name = SceneManager.npc_name
	show()
	talk()
	
func _on_NPC2_general_dialogue():
	npc_name = SceneManager.npc_name
	show()
	talk()
	
func _on_NPC3_general_dialogue():
	npc_name = SceneManager.npc_name
	show()
	talk()
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and cursor_ready:
		SE.effect("Select")
		emit_signal("text_ready")
	
func tween_go():
	length = $Name/Talk.text.length()
	if length <= 25:
		length = 25
	$Name/Talk.percent_visible = 0.0
	tween = create_tween()
	tween.tween_property($Name/Talk, "percent_visible", 1, (length/25))
	
func talking():
		tween_go()
		yield(get_tree().create_timer((length/25)), "timeout")
		$DialogueCursor.show()
		cursor_ready = true
		yield(self, "text_ready")
		cursor_ready = false
		$DialogueCursor.hide()
		emit_signal("talk_done")
		
func talking_autoend():
	tween_go()
	yield(get_tree().create_timer((length/25) + 0.5), "timeout")
	$DialogueCursor.show()
	emit_signal("talk_done")
	
		
func done():
	hide()
	PlayerManager.freeze = false
	yield(get_tree().create_timer(0.1), "timeout")
	SceneManager.ready_again = true

func talk():
	$Name.text = npc_name + ":"
	if npc_name == "Victor":
		Victor()
	if npc_name == "Derek":
		Derek()
	if npc_name == "Marjorie":
		Marjorie()
	if npc_name == "Penelope":
		Penelope()
	if npc_name == "Edgar":
		Edgar()
	if npc_name == "Henry":
		Henry()
	if npc_name == "Reeler":
		Reeler()
	if npc_name == "Alison":
		Alison()
	if npc_name == "Quinn":
		Quinn()
	if npc_name == "Ruben":
		Ruben()
	if npc_name == "Andrew":
		Andrew()
	if npc_name == "Peter":
		Peter()
	if npc_name == "Taylor":
		Taylor()
	if npc_name == "Haley":
		Haley()
	if npc_name == "Kate":
		Kate()
	if npc_name == "Nikolai":
		Nikolai()
	if npc_name == "Brody":
		Brody()
	if npc_name == "Calico":
		Calico()
		
func Victor():
	if js < 2 and not alternate:
		$Name/Talk.text = "I wonder what that strange noise was."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "It's usually so quiet around here. I have a bad feeling about it..."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif js < 2 and alternate:
		$Name/Talk.text = "That's a nice guitar you have! I used to work the bass back in the day."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Now it hurts my wrists too much... Wish I had a different instrument I could play."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false
	
func Derek():
	if js < 2 and not alternate:
		$Name/Talk.text = "Pivot Town is known for being a meeting place."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "They say the wind brings people here."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif js < 2 and alternate:
		$Name/Talk.text = "Henry and Tom live next door to us. They're nice to have as neighbors since they're so quiet."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I hope they don't mind how loud Penelope can be..."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false
		
func Marjorie():
	if js < 2 and not alternate:
		$Name/Talk.text = "We're having a carrot cake I made later."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm hoping this helps Penelope learn to like vegetables..."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif js < 2 and alternate:
		$Name/Talk.text = "Penelope can be a bit of a handful sometimes..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "She just has so much energy, I worry about keeping up with her."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false
		
func Penelope():
	#dolly_quest = true
	if dolly_quest:
		$Name/Talk.text = "Yay!! Thank you for finding my dolly!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Here, you can have this thingy I found the other day."
		talking()
		yield(self, "talk_done")
		done()
		PlayerManager.freeze = true
		PlayerManager.cutscene = true
		Party.add_item_name = "Jhumki"
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("quest_item")
		
	
	if js < 2 and not alternate:
		$Name/Talk.text = "What do you think that strange noise was?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "It sounded like a big crash!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
			
			
		
	elif js < 2 and alternate:
		$Name/Talk.text = "Mommy and Daddy said that if I'm good they'll take me to Puzzle Pier!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I want to go so bad!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false
			

func Edgar():
	if not EventManager.Jacques_Meetup_CS:
		$Name/Talk.text = "Good afternoon, young man."
		talking()
		yield(self, "talk_done")
		done()
	if js == 0 and EventManager.Edgar_Tea_CS:
		$Name/Talk.text = "Let me know if you find anything at the lake."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm curious to know if our theory is correct!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	if js == 1 and EventManager.Edgar_Check_In_CS:
		$Name/Talk.text = "I will be rooting for you all!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I hope the rest of your journey goes well."
		talking()
		yield(self, "talk_done")
		done()
		
func Henry():
	if js < 2 and not alternate:
		$Name/Talk.text = "I've been working on all the fences around town."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "If somewhere is closed off come back later, ok?"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif js < 2 and alternate:
		$Name/Talk.text = "I need to finish chopping that wood soon... And then check out the boiler at the Inn..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "It'll be a while before I can start clearing away that landslide by the windmill."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Reeler():
		$Name/Talk.text = "Get lost, I'm busy!"
		talking()
		yield(self, "talk_done")
		done()

func Alison():
	if not alternate:
		$Name/Talk.text = "Sometimes the pier can get really crowded..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "One time, the line for the Ferris Wheel went outside the front gate!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "I hope you have fun at the Pier!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "There's lots of stuff to do, so take your time."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Quinn():
	if not alternate:
		$Name/Talk.text = "Hi there! Are you enjoying Puzzle Pier?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "You can win lots of special prizes from our games, so take a look!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "Don't worry if you don't win the prize you wanted right away."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Some prizes will stay waiting for you get them, so keep trying!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Ruben():
	if not alternate:
		$Name/Talk.text = "Do you feel the breeze from the ocean?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I love how the salt air smells! So refreshing!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "Puzzle Pier is fun, but there's a lot going on."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "It's nice to watch the waves and take a little break too."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Andrew():
	if not alternate:
		$Name/Talk.text = "Darn it! I can't get to first place in Space Quest!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Maybe I'll give it just one more try..."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "I thought playing water guns would be easier..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "But it gets so fast at the end! I can't keep up!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Peter():
	if not alternate:
		$Name/Talk.text = "Woah, check out this Chilly Globe I got from the crane machine!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Not sure how you use it though... Maybe in a battle?"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "The crane machine is actually pretty easy if you know what you want."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Just make sure your hand doesn't slip..."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Taylor():
	if not alternate:
		$Name/Talk.text = "Should I get a Polar Parfait? Or a Nori Cookie?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm too hungry! I want both!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "Have you ridden the Ferris Wheel yet?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "You can see a really cool view from the top!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Haley():
	if not alternate:
		$Name/Talk.text = "Oh my gosh! My fortune was like totally spot on!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "And I got this Pretty Gem to keep... so cool!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "We should come here more often, I want to get my fortune read again."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "It's like kinda expensive though so I need to save up."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Kate():
	if not alternate:
		$Name/Talk.text = "I heard that getting your fortune told also gives you a bonus effect"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Like, you can be stronger in battles or something."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "This place is so cute, I want to get a photo at the end of the dock!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I want to add it to my scrapbook when I get home~"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Nikolai():
	if not alternate:
		$Name/Talk.text = "Please come back here anytime."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "We have plenty of rides and games to enjoy!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "I can't thank you enough for saving Puzzle Pier."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm sure the rest of your journey will go well!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Brody():
	if not alternate:
		$Name/Talk.text = "I can’t help it... I just really like Picnic Pie."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I know you're meant to share them... but this is just for me."
		talking()
		yield(self, "talk_done")
		done()
		alternate = true
	elif alternate:
		$Name/Talk.text = "I wish ocean water tasted good..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I’m kind of thirsty now too."
		talking()
		yield(self, "talk_done")
		done()
		alternate = false

func Calico():
	if not EventManager.calico_initial:
		emit_signal("event_trigger")
		$Name/Talk.text = "Ack! How did you get in here!?"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm supposed to keep this room hidden but..."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Have you heard of Jhumkis? I'm kind of obssesed with them."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Tell you what, if you can show me 5 Jhumkis I'll let you have a look in this room!"
		talking()
		yield(self, "talk_done")
		EventManager.calico_initial = true
		if Party.jhumki_amount >= 5:
			$Name/Talk.text = "Oh!! You have enough Jhumkis!"
			talking()
			yield(self, "talk_done")
			$Name/Talk.text = "Let me see! Let me see!"
			talking()
			yield(self, "talk_done")
			$Name/Talk.text = "They're so pretty... just the sight of one can make my day!"
			talking()
			yield(self, "talk_done")
			$Name/Talk.text = "Alright, here you go as promised."
			talking()
			yield(self, "talk_done")
			emit_signal("event_trigger")
			cursor_ready = false
			$DialogueCursor.hide()
			hide()
		if Party.jhumki_amount < 5:
			done()
			return
	if EventManager.calico_initial and Party.jhumki_amount <5:
		$Name/Talk.text = ""
		$Name/Talk.text = "If you can show me 5 Jhumkis I'll let you have a look in this room!"
		talking()
		yield(self, "talk_done")
		done()
	if EventManager.calico_initial and Party.jhumki_amount >= 5 and not EventManager.circus_extra:
		$Name/Talk.text = "Oh!! You have enough Jhumkis!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Let me see! Let me see!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "They're so pretty... just the sight of one can make my day!"
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "Alright, here you go as promised."
		talking()
		yield(self, "talk_done")
		emit_signal("event_trigger")
		cursor_ready = false
		$DialogueCursor.hide()
		hide()

func Calico_after():
	cursor_ready = false
	npc_name = SceneManager.npc_name
	show()
	$Name/Talk.text = "And now I'm outta here!"
	talking_autoend()
	yield(self, "talk_done")
	$DialogueCursor.hide()
	hide()
	cursor_ready = false
	

func _on_SaveStarIntro_area_event():
		show()
		$Name.text = "This is a Save Star. You can use it to save your game or fast travel to places you've been before."
		$Name/Talk.text = ""
		talking()
		yield(self, "talk_done")
		$Name.text = "It's a good idea to save whenever you see one of these!"
		talking()
		yield(self, "talk_done")
		done()


func _on_SaveStarIntro2_area_event():
		show()
		$Name.text = "Use the Save Star first!"
		$Name/Talk.text = ""
		talking()
		yield(self, "talk_done")
		done()


func _on_Michael_Stall_area_event():
	show()
	$Name.text = "Talk to Michael first!"
	$Name/Talk.text = ""
	talking()
	yield(self, "talk_done")
	done()
	
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk_left()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", Vector2(-379, 175), 0.8)
	yield(tween, "finished")
	PlayerManager.freeze = false
	PlayerManager.cutscene = false


