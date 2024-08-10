tool
extends Camera2D

# Ideally you'd want a more complex camera system
# Some way to set boundairies with area

export var vertical_speed : float = 64
export var player_offset : Vector2
export var minPos : Vector2
export var maxPos : Vector2
export var follow_player = false

const PauseMenu = preload("res://UI/PauseMenu.tscn")
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
onready var pause_menu = PauseMenu.instance()
var new_pause_menu
var able = false

var motion_root
var z_offset = 0
var is_in_editor = Engine.is_editor_hint()
var tween

func _ready():
	Global.current_camera = self
	z_index = 4096
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func item_window():
	PlayerManager.freeze = true
	$Info_Window.show()
	tween = create_tween()
	tween.tween_property($Info_Window, "modulate:a", 1, 0.2)
	yield(get_tree().create_timer(1.7), "timeout")
	var tween = create_tween()
	tween.tween_property($Info_Window, "modulate:a", 0, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	$Info_Window.hide()
	if Party.sent_storage:
		yield(get_tree().create_timer(0.1), "timeout")
		sent_storage()
	else:
		PlayerManager.freeze = false
	
func sent_storage():
	$Info_Window/First_Text.text = "Sent to storage"
	$Info_Window.show()
	tween = create_tween()
	tween.tween_property($Info_Window, "modulate:a", 1, 0.2)
	yield(get_tree().create_timer(0.9), "timeout")
	var tween = create_tween()
	tween.tween_property($Info_Window, "modulate:a", 0, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	$Info_Window.hide()
	Party.sent_storage = false
	PlayerManager.freeze = false

func _process(delta):
	if Global.battle_ended:
		current = true
	if not is_in_editor:
		if not motion_root:
			# Getting Gary. Pretty stupid way to do it. But Gary is spawned at runtime...
			motion_root = PlayerManager.player_motion_root
			z_offset = motion_root.pos_z
			
		if motion_root:
			z_offset = min(max(motion_root.shadow_z, motion_root.pos_z), z_offset)
			if z_offset < motion_root.shadow_z:
				z_offset = min(z_offset + vertical_speed * delta, max(motion_root.shadow_z, motion_root.pos_z))
			
			if follow_player:
				global_position.x = clamp(motion_root.global_position.x + player_offset.x, minPos.x, maxPos.x)
				global_position.y = clamp(motion_root.global_position.y - z_offset + player_offset.y, minPos.y, maxPos.y)

func _input(event):
		if Input.is_action_pressed("ui_pause") and not PlayerManager.freeze and not able:
			Music.quiet()
			SE.effect("Menu Open")
			PlayerManager.freeze = true
			get_tree().paused = true
			new_pause_menu = pause_menu.duplicate()
			add_child(new_pause_menu)
			yield(get_tree().create_timer(0.3), "timeout")
			able = true
		
		if Input.is_action_pressed("ui_pause") and PlayerManager.freeze and able:
			Music.loud()
			SE.effect("Menu Open")
			var transition = TransitionPlayer.instance()
			get_tree().get_root().add_child(transition)
			transition.speed_up()
			transition.ease_in()
			remove_child(new_pause_menu)
			PlayerManager.freeze = false
			get_tree().paused = false
			yield(get_tree().create_timer(0.6), "timeout")
			able = false
		
			

func _on_Item_Get_item_get():
	var item_name = Party.add_item_name
	$Info_Window/First_Text.text = "You got a " + item_name + "!"
	item_window()

func _on_Item_Interact_item_get():
	var item_name = Party.add_item_name
	$Info_Window/First_Text.text = "You got a " + item_name + "!"
	item_window()

func _on_PresentBase_item_get():
	if Party.marbles_get:
		var item_name = Party.add_item_name
		$Info_Window/First_Text.text = "You got " + item_name + "!"
		item_window()
		Party.marbles_get = false
	elif Party.trinket_get:
		var item_name = Party.add_trinket_name
		if item_name == "Overdrive":
			$Info_Window/First_Text.text = "You got an " + item_name + "!"
		else:
			$Info_Window/First_Text.text = "You got a " + item_name + "!"
		item_window()
		Party.trinket_get = false
	else:
		var item_name = Party.add_item_name
		$Info_Window/First_Text.text = "You got a " + item_name + "!"
		item_window()

func _on_PresentBase2_item_get():
	_on_PresentBase_item_get()
