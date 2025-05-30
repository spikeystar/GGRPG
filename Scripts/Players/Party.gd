extends Node

var f_turns : int = 0
var marbles : int = 0
var jewel_seeds : int = 0
var spell_name : String
var remove_item_name: String
var marbles_get = false
var trinket_get = false
var sent_storage = false
var event_name : String

const menu_slot = preload("res://UI/Slot.tscn")
onready var slot = menu_slot.instance()
var add_item_name : String
var add_trinket_name : String
var add_enemy_name : String
var add_key_item_name : String
var item_index : int
var storage_index : int
var spell_index : int

var Tutorial : Array = []
var Inventory : Array = []
var Storage : Array = []
var Trinkets : Array = []
var KeyItems : Array = []
var EnemyList : Array = []
var Gary_Spells : Array = []
var Jacques_Spells : Array = []
var Irina_Spells : Array = []
var Suzy_Spells : Array = []
var Damien_Spells : Array = []

func _ready():
	marbles = 0
	
	add_item_name = "Yummy Cake"
	add_item()
	add_item_name = "Pretty Gem"
	add_item()
	add_item_name = "Yummy Cake"
	add_item()
	add_item_name = "Pretty Gem"
	add_item()	
	
	add_item_name = "Pretty Gem"
	add_tutorial_item()
	
	spell_name = "Thunderstorm"
	populate_Gary()
	spell_name = "Icicle"
	populate_Jacques()

	spell_name = "Sweet Gift"
	populate_Irina()
	spell_name = "Precious Beam"
	populate_Irina()
	
	add_enemy_name = "Cheribo"
	add_enemy()
	
	#add_trinket_name = "Gold Bracelet"
	#add_trinket()	
	#add_trinket_name = "Gold Chain"
	#add_trinket()	
	#add_trinket_name = "Gold Earring"
	#add_trinket()	
	
	#add_item_name = "Bounty Herb"
	#add_item()	
	#add_item_name = "Bounty Herb"
	#add_item()	
		
func add_item():
	if Inventory.size() == 10:
		var new_slot = slot.duplicate()
		new_slot.text = add_item_name
		Storage.append(new_slot)
		sent_storage = true
	else:
		var new_slot = slot.duplicate()
		new_slot.text = add_item_name
		Inventory.append(new_slot)
		
func add_tutorial_item():
	var new_slot = slot.duplicate()
	new_slot.text = add_item_name
	Tutorial.append(new_slot)
		
	
func add_trinket():
	if Trinkets.size() > 1:
		Trinkets.remove(Trinkets.size() - 1)
		new_trinket()
		blank_trinket()
	if Trinkets.size() == 0:
		new_trinket()
		blank_trinket()
		
func blank_trinket():
	var new_slot = slot.duplicate()
	new_slot.text = "-"
	Trinkets.append(new_slot)
	
func new_trinket():
	var new_slot = slot.duplicate()
	new_slot.text = add_trinket_name
	Trinkets.append(new_slot)
	
func add_key_item():
	var new_slot = slot.duplicate()
	new_slot.text = add_key_item_name
	KeyItems.append(new_slot)
	
func add_enemy():
	var SearchList : Array = []
	var search_name : String
	for x in range (EnemyList.size()):
		search_name = EnemyList[x].get_id()
		SearchList.append(search_name)
	if SearchList.has(add_enemy_name):
			return
	else:
		var new_slot = slot.duplicate()
		new_slot.text = add_enemy_name
		EnemyList.append(new_slot)
	
func populate_Gary():
	var new_slot = slot.duplicate()
	new_slot.text = spell_name
	Gary_Spells.append(new_slot)
	
func populate_Jacques():
	var new_slot = slot.duplicate()
	new_slot.text = spell_name
	Jacques_Spells.append(new_slot)
	
func populate_Irina():
	var new_slot = slot.duplicate()
	new_slot.text = spell_name
	Irina_Spells.append(new_slot)
		
func remove_item():
	Inventory.remove(item_index)
	item_index = clamp(item_index, 0, Inventory.size() - 1)
	
func deposit_item():
	var new_slot = slot.duplicate()
	new_slot.text = add_item_name
	Storage.append(new_slot)
	
func remove_storage():
	Storage.remove(storage_index)
	storage_index = clamp(storage_index, 0, Storage.size() - 1)
	

func boss_event():
	if event_name == "Saguarotel":
		add_enemy_name = "Saguarotel"
		add_enemy()
		add_enemy_name = "Tenant A"
		add_enemy()
		add_enemy_name = "Tenant B"
		add_enemy()
	if event_name == "Reeler":
		add_enemy_name = "Reeler"
		add_enemy()
