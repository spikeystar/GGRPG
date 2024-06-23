extends VBoxContainer

var item_active = false
var empty_items = false
var item_id : String

signal go_to_Defend()
signal item_chosen()
signal heal_item_chosen()
signal all_heal_item_chosen()
signal battle_item_chosen()
signal all_battle_item_chosen()
signal empty_items()

onready var inventory : Array = []
var item_index : int

func _ready():
	for x in range (Party.Inventory.size()):
			inventory.append(Party.Inventory[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() == 0:
		empty_items = true
		emit_signal("empty_items")
		
func add_slot(item_index):
	var item_slot = inventory[item_index]
	self.add_child(item_slot)
	
func _process(delta):
	#item_index = clamp(item_index, 0, inventory.size() - 1)
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
		#item_index = 0
	if Input.is_action_just_pressed("ui_down") and item_active and empty_items:
		emit_signal("go_to_Defend")
		item_active = false
	if Input.is_action_just_pressed("ui_select") and item_active:
		get_id()
		if item_id == "Yummy Cake" or item_id == "Bounty Herb" or item_id == "Sugar Pill" or item_id == "Ginger Tea":
			emit_signal("heal_item_chosen")
			emit_signal("item_chosen")
		if item_id == "Picnic Pie" or item_id == "Pretty Gem":
			emit_signal("all_heal_item_chosen")
			emit_signal("item_chosen")
		if item_id == "Jinx Doll":
			emit_signal("battle_item_chosen")
		if item_id == "Spikey Bomb":
			emit_signal("all_battle_item_chosen")
		Party.item_index = item_index
		item_active = false
		
func get_id():
	if item_active and not empty_items:
		item_id = inventory[item_index].get_id()
		return item_id

func _on_WorldRoot_item_active():
	item_active = true
	item_index = 0

func _on_WorldRoot_item_inactive():
	item_active = false
	#item_index = 0

func _on_WorldRoot_item_removed():
	for x in self.get_children():
		self.remove_child(x)
	inventory = []
	item_index = clamp(item_index, 0, inventory.size() - 1)
	for x in range (Party.Inventory.size()):
			inventory.append(Party.Inventory[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() == 0:
		empty_items = true
		emit_signal("empty_items")
