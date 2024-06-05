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
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and cursor_ready:
		emit_signal("text_ready")
	
func tween_go():
	length = $Name/Talk.text.length()
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
	
