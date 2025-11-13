extends Node2D

var tween
var dialogue_cursor = false
var welcome = true
var length : float

func _ready():
	pass # Replace with function body.

func _welcome():
	welcome = true
	dialogue_cursor = false
	$Dialogue/Name/Talk.percent_visible = 0.0
	$Dialogue.show()
	welcome_text()
	length = $Dialogue/Name/Talk.text.length()
	tween = create_tween()
	tween.tween_property($Dialogue/Name/Talk, "percent_visible", 1, (length/25))
	yield(get_tree().create_timer((length/25)), "timeout")
	$Dialogue/DialogueCursor.show()
	dialogue_cursor = true
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and dialogue_cursor and welcome and $Dialogue/Name/Talk.percent_visible == 1:
		SE.effect("Select")
		$Dialogue.hide()
		$Dialogue/DialogueCursor.hide()
		$EventOptions.show()
		welcome = false
		#emit_signal("option_selecting")
		yield(get_tree().create_timer(0.05), "timeout")
		$EventOptions/MenuCursor.cursor_ready()
	
func welcome_text():
	$Dialogue/Name.text = SceneManager.npc_name + ":"
	if SceneManager.npc_name == "Jacob":
		$Dialogue/Name/Talk.text = "Would you like to ride the ferris wheel? It's only 100 Marbles!"
	if SceneManager.npc_name == "Estella":
		$Dialogue/Name/Talk.text = "Hello, my dear~ I can read your fortune for 2,000 marbles. It's worth it, I promise~"
	if SceneManager.npc_name == "Nathan":
		$Dialogue/Name/Talk.text = "Hello there! Wanna try your hand at the crane machine for 500 Marbles?"


func _on_FerrisWheel_interaction():
	SceneManager.npc_name = "Jacob"
	_welcome()

func _on_FortuneStand_interaction():
	SceneManager.npc_name = "Estella"
	_welcome()

func _on_CraneStand_interaction():
	SceneManager.npc_name = "Nathan"
	_welcome()
