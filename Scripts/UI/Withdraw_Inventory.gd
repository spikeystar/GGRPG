extends VBoxContainer

var active = false
var item_id : String
var inventory_max : int

const menu_slot = preload("res://UI/Slot.tscn")
onready var slot = menu_slot.instance()

onready var inventory : Array = []
var item_index : int
var new_name : String

func _ready():
	for x in range (Party.Storage.size()):
			inventory.append(Party.Storage[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
		
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		
func add_slot(item_index):
	var item_slot = inventory[item_index]
	self.add_child(item_slot)
	
#func add_slot():
	#var new_slot = slot.duplicate()
	#new_slot.text = new_name
	#self.add_child(new_slot)
	
	
func scroll_down():
	inventory[item_index].show()
	inventory[item_index - 10].hide()
	
func scroll_up():
	inventory[item_index - 9].show()
	inventory[item_index + 1].hide()
	
func _process(delta):
	var size_max = inventory.size()
	inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and active and item_index < inventory_max:
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and active and item_index > 0:
		item_index -= 1
	if Input.is_action_just_pressed("ui_down") and active and item_index >=10:
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and active and item_index >=9:
		scroll_up()
	if Input.is_action_just_pressed("ui_accept") and active or Input.is_action_just_pressed("ui_left") and active:
		pass
		#reset()
		
		
func item_removed():
	for x in self.get_children():
		self.remove_child(x)
	for x in range (Party.Storage.size()):
			inventory.append(Party.Storage[x].duplicate())
	item_index = clamp(item_index, 0, inventory.size() - 1)
	for item_index in inventory.size():
		add_slot(item_index)
	#for x in inventory.size():
		#new_name = inventory[x].get_id()
		#add_slot()	
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		
		
	#if inventory.size() == 0:
		#empty_items = true
		#emit_signal("empty_items")
		
func refresh():
	for x in self.get_children():
		self.remove_child(x)
	for x in range (Party.Storage.size()):
			inventory.append(Party.Storage[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
		
	#for x in inventory.size():
		#new_name = inventory[x].get_id()
		#add_slot()
		
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()

func reset():
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		for x in range(0, 9):
			inventory[x].show()
	item_index = 0
	active = false

func _on_Interaction_option_selecting():
	active = false
	refresh()
	reset()

func _on_Interaction_withdraw():
	active = true
	item_index = 0
