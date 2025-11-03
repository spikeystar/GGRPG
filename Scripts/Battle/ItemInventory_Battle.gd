extends VBoxContainer

var item_active = false
var empty_items = false
var item_id : String

export var tutorial : bool

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
	if tutorial:
		for x in range (Party.Tutorial.size()):
			inventory.append(Party.Tutorial[x].duplicate())
		for item_index in inventory.size():
			add_slot(item_index)
	
	if not tutorial:
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
	item_index = clamp(item_index, 0, inventory.size() - 1)
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and item_active and item_index < inventory_max and not tutorial:
		SE.effect("Move Between")
		item_index += 1
	if Input.is_action_just_pressed("ui_up") and item_active and item_index > 0 and not tutorial:
		SE.effect("Move Between")
		item_index -= 1
		
func _input(event):
	var inventory_max = (inventory.size() -1)
	
	#if Input.is_action_just_pressed("ui_down") and item_active and item_index < inventory_max and not tutorial:
	#	SE.effect("Move Between")
	#	item_index += 1
	#if Input.is_action_just_pressed("ui_up") and item_active and item_index > 0 and not tutorial:
	#	SE.effect("Move Between")
	#	item_index -= 1
	
	
	
	if Input.is_action_just_pressed("ui_down") and item_active and item_index == inventory_max and not tutorial:
		SE.effect("Move Between")
		emit_signal("go_to_Defend")
		item_active = false
		#item_index = 0
	if Input.is_action_just_pressed("ui_down") and item_active and empty_items and not tutorial:
		SE.effect("Move Between")
		emit_signal("go_to_Defend")
		item_active = false
	if Input.is_action_just_pressed("ui_select") and item_active:
		SE.effect("Select")
		get_id()
		item_active = false
		if item_id == "Yummy Cake" or item_id == "Bounty Herb" or item_id == "Sugar Pill" or item_id == "Ginger Tea" or item_id == "Flummery Flambé" or item_id == "Saffron Soufflé" or item_id == "Polar Parfait" or item_id == "Nori Cookie" or item_id == "Starberry" or item_id == "Hocus Potion" or item_id == "Magic Mushroom" or item_id == "Delicious Cake" or item_id == "Amazing Cake":
			emit_signal("heal_item_chosen")
			emit_signal("item_chosen")
		if item_id == "Picnic Pie" or item_id == "Pretty Gem" or item_id == "Lovely Gem" or item_id == "Beautiful Gem" or item_id == "Remedy Bouquet" or item_id == "Perfect Panacea":
			emit_signal("all_heal_item_chosen")
			emit_signal("item_chosen")
		if item_id == "Jinx Doll":
			emit_signal("battle_item_chosen")
		if item_id == "Spikey Bomb" or item_id == "Blister Grenade" or item_id == "Faulty Amp" or item_id == "Chilly Globe" or item_id == "Power Drill" or item_id == "Strange Perfume":
			emit_signal("all_battle_item_chosen")
		Party.item_index = item_index
		
		
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
