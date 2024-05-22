extends VBoxContainer

var item_active = false
var empty_items = false
var item_id : String

signal heal_item_chosen()
signal all_heal_item_chosen()
signal empty_items()
signal return_to_item()

onready var inventory : Array = []
var item_index : int

func _ready():
	inventory = Party.Inventory
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() == 0:
		empty_items = true
		emit_signal("empty_items")
		
func add_slot(item_index):
	var item_slot = inventory[item_index]
	self.add_child(item_slot)
	
func _process(delta):
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and item_active and item_index < inventory_max:
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and item_active and item_index > 0:
		item_index -= 1
		
func _input(event):
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_select") and item_active:
		get_id()
		if item_id == "Yummy Cake" or item_id == "Sugar Pill":
			emit_signal("heal_item_chosen")
		if item_id == "Picnic Pie" or item_id == "Pretty Gem":
			emit_signal("all_heal_item_chosen")
			emit_signal("item_chosen")
		if item_id == "Bounty Herb" or item_id == "Ginger Tea":
			pass
		Party.item_index = item_index
		item_active = false
		
func get_id():
	if item_active and not empty_items:
		item_id = inventory[item_index].get_id()
		return item_id

func item_removed():
	for x in self.get_children():
		self.remove_child(x)
	item_index = clamp(item_index, 0, inventory.size() - 1)
	inventory = Party.Inventory
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() == 0:
		empty_items = true
		emit_signal("empty_items")

func _on_MenuCursor_item_selecting():
	item_active = true

func _on_ItemMenuCursor_retread():
	item_active = false

func _on_Members_item_usage():
	if item_id == "Yummy Cake":
		print("healed")
	item_removed()
	yield(get_tree().create_timer(0.8), "timeout")
	emit_signal("return_to_item")
