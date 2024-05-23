extends ScrollContainer

const SCROLL_SPEED = 34
var active = false
var down_count = 0
var size_max : int
onready var scrollbar = get_v_scrollbar()

func _ready():
	size_max = scrollbar.max_value

func _process(delta):
	$TrinketsInventory.margin_left = margin_left + 3
	$TrinketsInventory.margin_top = margin_top + 3

func _input(event):
	if Input.is_action_just_pressed("ui_down") and active and not size_max:
		down_count += 1
		print(scrollbar.max_value)
		print(scroll_vertical)
	if Input.is_action_just_pressed("ui_up") and active and down_count >0:
		down_count -= 1
	if Input.is_action_just_pressed("ui_down") and active and down_count >= 19:
			scroll_vertical += SCROLL_SPEED
	if Input.is_action_just_pressed("ui_up") and active:
			scroll_vertical -= SCROLL_SPEED

func _on_MenuCursor_trinket_selecting():
	active = true

func _on_TrinketsCursor_retread():
	active = false

func _on_TrinketsInventory_size_max():
	size_max = true

func _on_TrinketsInventory_size_ready():
	size_max = false
