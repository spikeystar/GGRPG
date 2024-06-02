extends Node2D
var tween
var dialogue_cursor = false
var welcome = true
var options = false
var menu_name : String
var item_selecting = false
var able = false
var complete = false
var ongoing = false

signal option_selecting
signal restart
signal buying
signal selling
signal deposit
signal withdraw
signal retread

func welcome():
	$Dialogue/Label.percent_visible = 0.1
	$Dialogue.show()
	$Dialogue/Label.text = "Hey. What do you need?"
	tween = create_tween()
	tween.tween_property($Dialogue/Label, "percent_visible", 1, 1)
	yield(get_tree().create_timer(1), "timeout")
	$Dialogue/DialogueCursor.show()
	dialogue_cursor = true
	
func _process(delta):
	if options:
		menu_name = $ShopOptions/MenuCursor.menu_name
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and dialogue_cursor and welcome:
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$Dialogue/Label.percent_visible = 0.1
		$ShopOptions.show()
		welcome = false
		options = true
		emit_signal("option_selecting")
		
	if Input.is_action_just_pressed("ui_accept") and dialogue_cursor and not item_selecting and not ongoing or Input.is_action_just_pressed("ui_left") and dialogue_cursor and not item_selecting and not ongoing:
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$ShopOptions.hide()
		welcome = true
		dialogue_cursor = false
		options = false
		$ShopOptions/MenuCursor.cursor_index = 0
		menu_name = ""
		PlayerManager.freeze = false
		emit_signal("restart")
	
	if Input.is_action_just_pressed("ui_select") and menu_name == "Talk" and not able and not complete and not item_selecting:
		ongoing = true
		$ShopOptions.hide()
		$Dialogue.show()
		$Dialogue/Label.text = "Someday I'm gonna leave this town."
		tween_go()
		yield(get_tree().create_timer(1), "timeout")
		$Dialogue/DialogueCursor.show()
		able = true
	if Input.is_action_just_pressed("ui_select") and menu_name == "Talk" and able:
		$Dialogue/DialogueCursor.hide()
		$Dialogue/Label.text = "There's gotta be somewhere more interesting to live than here."
		tween_go()
		yield(get_tree().create_timer(2), "timeout")
		$Dialogue/DialogueCursor.show()
		able = false
		complete = true
	if Input.is_action_just_pressed("ui_select") and menu_name == "Talk" and complete:
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		welcome = true
		dialogue_cursor = false
		options = false
		complete = false
		menu_name = ""
		PlayerManager.freeze = false
		ongoing = false
		yield(get_tree().create_timer(0.1), "timeout")
		emit_signal("restart")

	if Input.is_action_just_pressed("ui_select") and menu_name == "Buy" and not item_selecting and not ongoing:
		emit_signal("buying")
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$ShopOptions.hide()
		$ShopOptions/MenuCursor.option_selecting = false
		$ShopOptions/MenuCursor.able = false
		$Buy.show()
		$Buy/MenuCursor.cursor_index = 0
		item_selecting = true
		options = false
		
	if Input.is_action_just_pressed("ui_select") and menu_name == "Sell" and not item_selecting and not ongoing:
		emit_signal("selling")
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$ShopOptions.hide()
		$ShopOptions/MenuCursor.option_selecting = false
		$ShopOptions/MenuCursor.able = false
		$Sell.show()
		$Sell/MenuCursor.cursor_index = 0
		item_selecting = true
		options = false
		
	if Input.is_action_just_pressed("ui_accept") and item_selecting or Input.is_action_just_pressed("ui_left") and item_selecting:
		$Buy.hide()
		$Sell.hide()
		$ShopOptions.show()
		$ShopOptions/MenuCursor.able = false
		item_selecting = false
		options = true
		ongoing = false
		dialogue_cursor = true
		emit_signal("option_selecting")

func _on_Shop_interaction():
	welcome()
	
func tween_go():
	var length = $Dialogue/Label.text.length()
	$Dialogue/Label.percent_visible = 0.1
	tween = create_tween()
	tween.tween_property($Dialogue/Label, "percent_visible", 1, (length/27))
	
