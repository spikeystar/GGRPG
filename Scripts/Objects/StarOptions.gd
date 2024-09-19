extends Sprite

var menu_name : String
var star_options = false

signal save_menu

func _process(delta):
	if star_options:
		menu_name = $MenuCursor.menu_name
		
func _input(event):
	if Input.is_action_just_pressed("ui_left") and star_options or Input.is_action_just_pressed("ui_accept") and star_options:
		star_options = false
		PlayerManager.freeze = false
		SE.effect("Cancel")
		$MenuCursor.option_selecting = false
		$MenuCursor.able = false
		self.hide()
		
	if Input.is_action_just_pressed("ui_select") and star_options and menu_name == "Save":
		SE.effect("Select")
		star_options = false
		emit_signal("save_menu")
		$MenuCursor.option_selecting = false
		$MenuCursor.able = false
		self.hide()

func _on_SaveStar_star_options():
	$MenuCursor.cursor_index = 0
	star_options = true
	self.show()
	$MenuCursor.option_selecting = true
	$MenuCursor.modulate.a = 1
	yield(get_tree().create_timer(0.2), "timeout")
	$MenuCursor.able = true
	
