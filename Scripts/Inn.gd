extends Node2D
var tween
var dialogue_cursor = false
var welcome = true
var options = false
var menu_name : String
var able = false
var complete = false
var ongoing = false
export var inn_name : String
export var cost : int
var length : int

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
export(String, FILE, "*.tscn,*.scn") var target_scene

enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;

signal option_selecting
signal restart
signal sleep

func welcome():
	$Dialogue/Name/Talk.percent_visible = 0.0
	$Dialogue.show()
	welcome_text()
	length = $Dialogue/Name/Talk.text.length()
	tween = create_tween()
	tween.tween_property($Dialogue/Name/Talk, "percent_visible", 1, (length/25))
	yield(get_tree().create_timer((length/25)), "timeout")
	$Dialogue/DialogueCursor.show()
	dialogue_cursor = true
	
func _process(delta):
	if options:
		menu_name = $ShopOptions/MenuCursor.menu_name
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and dialogue_cursor and welcome:
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$Dialogue/Name/Talk.percent_visible = 0.1
		$ShopOptions.show()
		welcome = false
		options = true
		emit_signal("option_selecting")
		
	if Input.is_action_just_pressed("ui_accept") and dialogue_cursor and not ongoing or Input.is_action_just_pressed("ui_left") and dialogue_cursor and not ongoing:
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
	
	if Input.is_action_just_pressed("ui_select") and menu_name == "Talk" and not able and not complete:
		ongoing = true
		$ShopOptions.hide()
		$Dialogue.show()
		text_1()
		tween_go()
		yield(get_tree().create_timer((length/25)), "timeout")
		$Dialogue/DialogueCursor.show()
		able = true
	if Input.is_action_just_pressed("ui_select") and menu_name == "Talk" and able:
		$Dialogue/DialogueCursor.hide()
		text_2()
		tween_go()
		yield(get_tree().create_timer((length/25)), "timeout")
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
		
	if Input.is_action_just_pressed("ui_select") and menu_name == "Sleep" and Party.marbles >= cost:
		Party.marbles = Party.marbles - cost
		PartyStats.full_heal()
		PlayerManager.ongoing = true
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$ShopOptions.hide()
		welcome = true
		dialogue_cursor = false
		options = false
		complete = false
		menu_name = ""
		ongoing = false
		yield(get_tree().create_timer(0.1), "timeout")
		Global.door_name = "Sleep"
		SE.id = "Sleep"
		SE.effect()
		yield(get_tree().create_timer(0.7), "timeout")
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.fade_speed()
		yield(get_tree().create_timer(0.5), "timeout")
		transition.transition_in(target_scene, _get_animation_name())
		yield(get_tree().create_timer(0.8), "timeout")
		PlayerManager.sleep = true
		yield(get_tree().create_timer(0.5), "timeout")
		PlayerManager.ongoing = false
		
func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name

func _on_Shop_interaction():
	welcome()
	
func tween_go():
	length = $Dialogue/Name/Talk.text.length()
	$Dialogue/Name/Talk.percent_visible = 0.0
	tween = create_tween()
	tween.tween_property($Dialogue/Name/Talk, "percent_visible", 1, (length/25))
	
func welcome_text():
	$Dialogue/Name.text = inn_name + ":"
	if inn_name == "Freya":
		$Dialogue/Name/Talk.text = "Welcome to the Pivot Town Inn! One stay is 50 Marbles."
	
func text_1():
	if inn_name == "Freya":
		$Dialogue/Name/Talk.text = "Our children both moved to Tower Town a while ago."
	
func text_2():
	if inn_name == "Freya":
		$Dialogue/Name/Talk.text = "I wish they would come visit sometime. It's a bit lonely without them."
	

