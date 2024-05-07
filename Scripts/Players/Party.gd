extends Node


var current_health = 88
var max_health = 88
var attack = 10
var party_id : int
var party_members = 3
var f_turns : int = 0
var party_level : int = 1
var spell_name : String
var remove_item_name: String

const menu_slot = preload("res://UI/Slot.tscn")
onready var slot = menu_slot.instance()
var add_item_name : String

var Inventory : Array = []

func _ready():
	add_item_name = "Pretty Gem"
	add_item()
	add_item_name = "Pretty Gem"
	add_item()
		
func add_item():
	slot.text = add_item_name
	Inventory.append(slot)
		
func remove_item():
	if Inventory.size() == 10:
		return
	for remove_item_name in Inventory:
		Inventory.remove(1)
