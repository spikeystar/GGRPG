extends Sprite

var length : int
var tween
var cursor_ready = false
signal text_ready
signal talk_done
signal section_done

var section_ready = false

func tween_go():
	length = $Name/Talk.text.length()
	if length <= 25:
		length = 25
	$Name/Talk.percent_visible = 0.0
	tween = create_tween()
	tween.tween_property($Name/Talk, "percent_visible", 1, (length/25))
	
func talk():
	yield(get_tree().create_timer((length/25)), "timeout")
	$DialogueCursor.show()
	
func talking():
		tween_go()
		yield(get_tree().create_timer((length/25)), "timeout")
		$DialogueCursor.show()
		cursor_ready = true
		yield(self, "text_ready")
		cursor_ready = false
		$DialogueCursor.hide()
		emit_signal("talk_done")
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and cursor_ready:
		SE.effect("Select")
		emit_signal("text_ready")
		
	if Input.is_action_just_pressed("ui_select") and section_ready:
		SE.effect("Select")
		emit_signal("section_done")
		section_ready = false
	
func window_show():
	show()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.2)
	
func window_hide():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	hide()

func Reeler_Event():
	SE.effect("Select")
	window_show()
	$Name.text = "Reeler:"
	$Name/Talk.text = "Hope you won't be needing these anymore!"
	$Name/Talk.percent_visible = 0.0
	var tween2 = create_tween()
	tween2.tween_property($Name/Talk, "percent_visible", 1, (1))
	yield(get_tree().create_timer((1.5)), "timeout")
	window_hide()
	
func Tutorial_1():
	SE.effect("Select")
	window_show()
	$Name.text = "Michael:"
	$Name/Talk.text = "This star is the selection cursor."
	talking()
	yield(self, "talk_done")
	#window_hide()
	
	#window_show()
	$Name/Talk.text = "When you see it you can press (Shift) to bring up your options."
	talking()
	yield(self, "talk_done")
	window_hide()
	section_ready = true
	
	
func Tutorial_2():
	window_show()
	$Name.text = "Michael:"
	$Name/Talk.text = "If you press (Return) before you've selected a move you can return to fighter selection."
	talking()
	yield(self, "talk_done")
	#window_hide()
	
	#window_show()
	$Name/Talk.text = "That will be more helpful once your party has grown!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "First, let's Attack by pressing the (Right Arrow) to use the Diamond button."
	talking()
	yield(self, "talk_done")
	window_hide()
	section_ready = true
	
func Tutorial_3():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "If there are multiple enemies, you can keep using the (Right Arrow) to select one."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Each fighter has a different way of attacking enemies."
	talking()
	yield(self, "talk_done")
	#window_hide()
	
	#window_show()
	$Name/Talk.text = "If you press the (Shift) button with the correct timing while attacking you'll do extra damage!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Pay attention to the sound effects and sparks to get the timing right."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Also, using an Attack will always restore some of your Star Power."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Give it a try by pressing (Shift) now to start the attack!"
	talking()
	yield(self, "talk_done")
	window_hide()
	section_ready = true

func Tutorial_4():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "Next, let's try a Magic attack."
	talking()
	yield(self, "talk_done")

	$Name/Talk.text = "Go to the Star button with the (Left Arrow)."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Magic attacks require Star Power (SP). Your party shares a pool of SP."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Magic attacks do not require timing and are more powerful."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "They also have special effects that can lead to strategies for dealing with enemies."
	talking()
	yield(self, "talk_done")
	
	window_hide()
	section_ready = true

func Tutorial_5():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "Now, let's talk about typing."
	talking()
	yield(self, "talk_done")
	
	SE.effect("Menu Open")
	$Typing.show()
	$Name/Talk.text = "There are 5 types. Each enemy has one."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Water & Fire and Air & Earth are paired types, they do 1.5X damage to each other."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "If you want to know what type an enemy is, look under its name in the info window."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "If you use magic with a type the same as the enemy you are attacking you will do 0.5X damage."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "You start Neutral, but eventually you'll see moves or items that will change your typing."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "You can use this to your advantage!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "When you are the same type as a move, that move will be powered up by 20%."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "And if you're the same type as an enemy attack, you're immune to its secondary effects."
	talking()
	yield(self, "talk_done")
	SE.effect("Menu Open")
	$Typing.hide()
	
	$Name/Talk.text = "You're running a bit low on SP now."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Let's try using an item now to fix that!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Go to the Clover button by using the (Up Arrow) and then use the Pretty Gem."
	talking()
	yield(self, "talk_done")
	
	window_hide()
	section_ready = true

func Tutorial_6():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "You can only have 10 items on you at a time."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Extra items you get are sent to your Storage, which can be accessed at any item store."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Items can also be helpful for dealing with statuses. Here's a list of them."
	talking()
	yield(self, "talk_done")
	
	SE.effect("Menu Open")
	$Statuses.show()
	
	$Name/Talk.text = "All statuses last for 3 turns, except Stun which lasts for 1 turn."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Some statuses are good like buffs, which increase your stats and Whammy! chance."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "A Whammy! is when you get really lucky and your attack does 2X damage!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Other statuses like Wimpy or Anxious can make battles pretty difficult."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "You can see what statuses you have by looking at your fighter's health bar."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "You'll be able to afflict some statuses on enemies too, so strategize wisely!"
	talking()
	yield(self, "talk_done")
	
	SE.effect("Menu Open")
	$Statuses.hide()
	
	$Name/Talk.text = "Finally, let's go over what you can do with the Spade button. Use the (Down Arrow)."
	talking()
	yield(self, "talk_done")
	
	window_hide()
	section_ready = true
	
func Tutorial_7():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "Defend will increase your defense by 50% for that turn."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Flee lets you run away from battle- but you'll lose some of your marbles!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Alright, we've gone over the basics."
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "Go ahead and select Flee and we'll wrap this up!"
	talking()
	yield(self, "talk_done")
	
	window_hide()
	section_ready = true
	
