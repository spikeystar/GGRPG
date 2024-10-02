extends Sprite

var ready = false
var menu_name : String

signal chosen
signal yes
signal no

func _process(delta):
	menu_name = $MenuCursor.menu_name
	ready = $MenuCursor.able
	
	if visible:
		$MenuCursor.option_selecting = true
	
	if not visible:
		$MenuCursor.option_selecting = false
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and ready and menu_name == "Yes":
		self.hide()
		$MenuCursor.option_selecting = false
		$MenuCursor.able = false
		emit_signal("chosen")
		emit_signal("yes")
	if Input.is_action_just_pressed("ui_select") and ready and menu_name == "No":
		self.hide()
		$MenuCursor.option_selecting = false
		$MenuCursor.able = false
		emit_signal("chosen")
		emit_signal("no")
