extends VBoxContainer


var active = false
var item_id : String

onready var inventory : Array = []
var item_index : int
var inventory_max : int

signal empty_items

func _ready():
	for x in range (Party.Inventory.size()):
			inventory.append(Party.Inventory[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
	#if inventory.size() == 0:
		#empty_key = true
		#emit_signal("empty_key")
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
			
func refresh():
	for x in self.get_children():
		self.remove_child(x)
		inventory = []
	for x in range (Party.Inventory.size()):
			inventory.append(Party.Inventory[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
		
func add_slot(item_index):
	var item_slot = inventory[item_index]
	self.add_child(item_slot)
	
	
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
		SE.effect("Move Between")
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and active and item_index > 0:
		SE.effect("Move Between")
		item_index -= 1
	if Input.is_action_just_pressed("ui_down") and item_index >=10:
		SE.effect("Move Between")
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and item_index >=9:
		SE.effect("Move Between")
		scroll_up()
		
	if inventory.size() == 0:
		emit_signal("empty_items")
		
		
#func get_id():
	#if key_active and not empty_key:
	#	key_id = inventory[key_index].get_id()
	#	return key_id
	#else:
	#	pass
		
func item_removed():
	for x in self.get_children():
		self.remove_child(x)
		inventory = []
	for x in range (Party.Inventory.size()):
			inventory.append(Party.Inventory[x].duplicate())
	item_index = clamp(item_index, 0, inventory.size() - 1)
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() == 0:
		#empty_items = true
		emit_signal("empty_items")
	print(item_index)
	

func reset():
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		for x in range(0, 9):
			inventory[x].show()
	item_index = 0
	active = false

func _on_Interaction_selling():
	active = true
	item_index = 0
	refresh()
	

func _on_Interaction_option_selecting():
	active = false
	refresh()
	
	
