extends Node

const menu_slot = preload("res://UI/Slot.tscn")
onready var slot = menu_slot.instance()
var item_name : String
var item_index : int
var shop_name : String

var this_shop : Array
var Tom : Array = []
var Cranston : Array = []

func _ready():
	this_shop = Tom
	item_name = "Yummy Cake"
	add_item()
	item_name = "Pretty Gem"
	add_item()
	item_name = "Sugar Pill"
	add_item()
	item_name = "Ginger Tea"
	add_item()
	item_name = "Gold Bracelet"
	add_item()
	item_name = "Gold Chain"
	add_item()
		
	
	this_shop = Cranston
	item_name = "Yummy Cake"
	add_item()
	item_name = "Pretty Gem"
	add_item()
	item_name = "Ginger Tea"
	add_item()
	item_name = "Bounty Herb"
	add_item()
	
func add_item():
	var new_slot = slot.duplicate()
	new_slot.text = item_name
	this_shop.append(new_slot)

func remove_item():
	if shop_name == "Tom":
		Tom.remove(item_index)
		item_index = clamp(item_index, 0, Tom.size() - 1)
