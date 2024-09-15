extends Sprite
var npc_name : String
var tween
var cursor_ready = false
signal text_ready
signal talk_done
signal restart
var length : int
var alternate = false
var js = Party.jewel_seeds

func _on_NPC_general_dialogue():
	npc_name = SceneManager.npc_name
	show()
	talk()
	
func _on_NPC2_general_dialogue():
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
		$Name/Talk.text = "Henry and Tom live next door to us. They're nice to have as neighbors since they're so quiet"
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
	if js < 1:
		$Name/Talk.text = "Let me know if you find anything at the lake."
		talking()
		yield(self, "talk_done")
		$Name/Talk.text = "I'm curious to know if our theory is correct!"
		talking()
		yield(self, "talk_done")
		done()
		alternate = true

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
