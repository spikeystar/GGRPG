extends VBoxContainer

var active = false
var item_id : String
export var shop_name : String
var inventory_max : int

onready var inventory : Array = []
var item_index : int

func _ready():
	if shop_name == "Tom":
		for x in range (Shops.Tom.size()):
			inventory.append(Shops.Tom[x].duplicate())
	if shop_name == "Cranston":
		for x in range (Shops.Cranston.size()):
			inventory.append(Shops.Cranston[x].duplicate())
	for item_index in inventory.size():
		add_slot(item_index)
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		
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
	if Input.is_action_just_pressed("ui_down") and active and item_index >=10:
		SE.effect("Move Between")
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and active and item_index >=9:
		SE.effect("Move Between")
		scroll_up()
	if Input.is_action_just_pressed("ui_accept") and active or Input.is_action_just_pressed("ui_left") and active:
		SE.effect("Cancel")
		reset()
		
		
#func get_id():
	#if key_active and not empty_key:
	#	key_id = inventory[key_index].get_id()
	#	return key_id
	#else:
	#	pass
		
func item_removed():
	for x in self.get_children():
		self.remove_child(x)
	_ready()
		
	#item_index = clamp(item_index, 0, inventory.size() - 1)
	#inventory = Shops.Tom.duplicate()
	#for item_index in inventory.size():
		#add_slot(item_index)
	#if inventory.size() == 0:
		#empty_items = true
		#emit_signal("empty_items")

func reset():
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		for x in range(0, 9):
			inventory[x].show()
	item_index = 0
	active = false

func _on_Interaction_buying():
	active = true
	item_index = 0

func _on_Interaction_option_selecting():
	active = false
