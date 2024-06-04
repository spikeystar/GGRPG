extends Sprite
var npc_name : String
var tween
var cursor_ready = false
signal text_ready
signal talk_done
signal restart
var length : int

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
	emit_signal("restart")

func talk():
	$Name.text = npc_name + ":"
	if npc_name == "Victor":
		Victor()
		
func Victor():
	$Name/Talk.text = "I wonder what that strange noise was."
	talking()
	yield(self, "talk_done")
	$Name/Talk.text = "It's usually so quiet around here. I have a bad feeling about it..."
	talking()
	yield(self, "talk_done")
	done()
	
