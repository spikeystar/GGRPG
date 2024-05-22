extends Node

var current_health = 88
var max_health = 88
var attack = 10
var party_id : int
var party_members = 3
var f_turns : int = 0
var party_level : int = 1
var party_marbles : int = 100
var party_sp = 150
var party_max_sp = 150
var spell_name : String
var remove_item_name: String

const menu_slot = preload("res://UI/Slot.tscn")
onready var slot = menu_slot.instance()
var add_item_name : String
var add_trinket_name : String
var add_key_item_name : String
var item_index : int
var spell_index : int

var Inventory : Array = []
var Trinkets : Array = []
var KeyItems : Array = []
var Gary_Spells : Array = []
var Jacques_Spells : Array = []
var Irina_Spells : Array = []

func _ready():
	add_item_name = "Yummy Cake"
	add_item()
	add_item_name = "Pretty Gem"
	add_item()
	add_item_name = "Picnic Pie"
	add_item()
	
	add_trinket_name = "Gold Bracelet"
	add_trinket()
	add_trinket_name = "Gold Earring"
	add_trinket()
	
	spell_name = "Thunderstorm"
	populate_Gary()
	spell_name = "Earthslide"
	populate_Gary()
	spell_name = "Icicle"
	populate_Jacques()
	spell_name = "Prism Snow"
	populate_Jacques()
	spell_name = "Sweet Gift"
	populate_Irina()
	spell_name = "Precious Beam"
	populate_Irina()
	
		
func add_item():
	if Inventory.size() == 10:
		return
	var new_slot = slot.duplicate()
	new_slot.text = add_item_name
	Inventory.append(new_slot)
	
func add_trinket():
	var new_slot = slot.duplicate()
	new_slot.text = add_trinket_name
	Trinkets.append(new_slot)
	
func add_key_item():
	var new_slot = slot.duplicate()
	new_slot.text = add_key_item_name
	KeyItems.append(new_slot)
	
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
	
func initial_items():
	add_item_name = "Yummy Cake"
	add_item()
	add_item_name = "Pretty Gem"
	add_item()
