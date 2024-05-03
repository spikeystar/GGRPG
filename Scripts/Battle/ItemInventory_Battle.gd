extends VBoxContainer
onready var inventory : Array = []
var item_index : int
var item_active = false

signal go_to_Defend()
signal item_chosen()

func _ready():
	inventory = get_children()
	
func _process(delta):
	item_index = clamp(item_index, 0, inventory.size() - 1)
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and item_active and item_index < inventory_max:
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and item_active and item_index > 0:
		item_index -= 1
		
func _input(event):
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and item_active and item_index == inventory_max:
		emit_signal("go_to_Defend")
		item_active = false
		item_index = 0
	if Input.is_action_just_pressed("ui_select") and item_active:
		emit_signal("item_chosen")
		item_active = false
		item_index = 0
		
func get_id():
	var item_id : String = inventory[item_index].get_id()
	return item_id

func _on_WorldRoot_item_active():
	item_active = true
	item_index = 0

func _on_WorldRoot_item_inactive():
	item_active = false
	item_index = 0
