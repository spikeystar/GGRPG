extends Sprite

var ready = false
var menu_name : String
var cost = 0

export var minigame = false

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
		
	if SceneManager.npc_name == "Jacob":
		cost = 100
		
	if SceneManager.npc_name == "Estella":
		cost = 2000
		
	if SceneManager.npc_name == "Nathan":
		cost = 500
		
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and ready and menu_name == "Yes" and Party.marbles < cost:
		SE.effect("Unable")
		return
	
	if Input.is_action_just_pressed("ui_select") and ready and menu_name == "Yes" and Party.marbles >= cost:
		self.hide()
		Party.marbles -= cost
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
		
		if minigame:
			SE.effect("Cancel")
			reset()
			
func reset():
	$MenuCursor.option_selecting = false
	$MenuCursor.cursor_index = 0
	$MenuCursor.able = false
