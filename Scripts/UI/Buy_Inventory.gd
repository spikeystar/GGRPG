extends VBoxContainer

var active = false
var item_id : String
export var shop_name : String


onready var inventory : Array = []
var item_index : int

func _ready():
	#if SceneManager.location == "Pivot Town":
	inventory = Shops.Tom
	for item_index in inventory.size():
		add_slot(item_index)
	#if inventory.size() == 0:
		#empty_key = true
		#emit_signal("empty_key")
	if inventory.size() > 11:
		for x in range(11, inventory.size()):
			inventory[x].hide()
			
		
func add_slot(item_index):
	var item_slot = inventory[item_index].duplicate()
	self.add_child(item_slot)
	
	
func scroll_down():
	inventory[item_index].show()
	inventory[item_index - 11].hide()
	
func scroll_up():
	inventory[item_index - 10].show()
	inventory[item_index + 1].hide()
	
func _process(delta):
	var size_max = inventory.size()
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and active and item_index < inventory_max:
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and active and item_index > 0:
		item_index -= 1
	if Input.is_action_just_pressed("ui_down") and item_index >=11:
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and item_index >=10:
		scroll_up()
		
		
#func get_id():
	#if key_active and not empty_key:
	#	key_id = inventory[key_index].get_id()
	#	return key_id
	#else:
	#	pass
		
func item_removed():
	for x in self.get_children():
		self.remove_child(x)
	item_index = clamp(item_index, 0, inventory.size() - 1)
	inventory = Shops.Tom
	for item_index in inventory.size():
		add_slot(item_index)
	#if inventory.size() == 0:
		#empty_items = true
		#emit_signal("empty_items")

func reset():
	if inventory.size() > 11:
		for x in range(11, inventory.size()):
			inventory[x].hide()
		for x in range(0, 10):
			inventory[x].show()
	item_index = 0
	active = false

func _on_Interaction_buying():
	active = true
	item_index = 0
