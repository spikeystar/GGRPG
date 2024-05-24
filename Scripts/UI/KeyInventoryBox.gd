extends VBoxContainer


onready var Members = get_tree().get_root().get_node("PauseMenu/Members")

var key_active = false
var empty_key = false
var key_id : String

signal empty_key()

onready var inventory : Array = []
var key_index : int

func _ready():
	inventory = Party.KeyItems
	for key_index in inventory.size():
		add_slot(key_index)
	if inventory.size() == 0:
		empty_key = true
		emit_signal("empty_key")
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
			
		
func add_slot(key_index):
	var key_slot = inventory[key_index]
	self.add_child(key_slot)
	
func scroll_down():
	inventory[key_index].show()
	inventory[key_index - 10].hide()
	
func scroll_up():
	inventory[key_index - 9].show()
	inventory[key_index + 1].hide()
	
func _process(delta):
	var size_max = inventory.size()
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and key_active and key_index < inventory_max:
		key_index += 1
		print(key_index)
	if Input.is_action_just_pressed("ui_up") and key_active and key_index > 0:
		key_index -= 1
		print(key_index)
	if Input.is_action_just_pressed("ui_down") and key_index >=10:
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and key_index >=9:
		scroll_up()
		
		
func get_id():
	if key_active and not empty_key:
		key_id = inventory[key_index].get_id()
		return key_id
		

func _on_KeyCursor_retread():
	if inventory.size() > 10:
		for x in range(10, inventory.size()):
			inventory[x].hide()
		for x in range(0, 9):
			inventory[x].show()
	key_index = 0
	key_active = false

func _on_MenuCursor_key_selecting():
	key_active = true
