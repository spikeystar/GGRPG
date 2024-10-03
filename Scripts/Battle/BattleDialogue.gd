extends Sprite

var length : int
var tween
var cursor_ready = false
signal text_ready
signal talk_done
signal section_done

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
	emit_signal("section_done")
	
func Tutorial_2():
	SE.effect("Select")
	window_show()
	$Name.text = "Michael:"
	$Name/Talk.text = "If you press (Return) before you've selected a move you can return to fighter selection."
	talking()
	yield(self, "talk_done")
	#window_hide()
	
	#window_show()
	$Name/Talk.text = "This will be more helpful once your party has grown!"
	talking()
	yield(self, "talk_done")
	
	$Name/Talk.text = "First, let’s Attack by pressing the “Right Arrow” to use the Diamond button."
	talking()
	yield(self, "talk_done")
	
	window_hide()
	emit_signal("section_done")
	
func Tutorial_3():
	SE.effect("Select")
	window_show()
	$Name/Talk.text = "Each fighter has a different way of attacking enemies."
	talking()
	yield(self, "talk_done")
	#window_hide()
	
	#window_show()
	$Name/Talk.text = "If you press the “Shift” button with the correct timing while attacking you'll do extra damage!"
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
	emit_signal("section_done")

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
	emit_signal("section_done")
