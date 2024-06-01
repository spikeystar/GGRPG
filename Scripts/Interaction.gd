extends Node2D
var tween
var dialogue_cursor = false
var welcome = true
var options = false

signal option_selecting

func welcome():
	$Dialogue.show()
	$Dialogue/Label.text = "Tom: Hey. What do you need?"
	tween = create_tween()
	tween.tween_property($Dialogue/Label, "percent_visible", 1, 1)
	yield(get_tree().create_timer(1), "timeout")
	$Dialogue/DialogueCursor.show()
	dialogue_cursor = true
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and dialogue_cursor and welcome:
		$Dialogue.hide()
		$ShopOptions.show()
		welcome = false
		options = true
		
	if Input.is_action_just_pressed("ui_accept") and dialogue_cursor or Input.is_action_just_pressed("ui_left") and dialogue_cursor:
		$Dialogue.hide()
		$ShopOptions.hide()
		welcome = true
		options = false
		PlayerManager.freeze = false

func _on_Shop_interaction():
	welcome()
