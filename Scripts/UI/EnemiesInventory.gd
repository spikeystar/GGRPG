extends VBoxContainer

#onready var Members = get_tree().get_root().get_node("PauseMenu/Members")

var enemies_active = false
var enemy_id : String

onready var inventory : Array = []
var enemy_index : int

func _ready():
	for x in range (Party.EnemyList.size()):
		inventory.append(Party.EnemyList[x].duplicate())
	for enemy_index in inventory.size():
		add_slot(enemy_index)
	if inventory.size() > 15:
		for x in range(15, inventory.size()):
			inventory[x].hide()
		
func add_slot(enemy_index):
	var enemy_slot = inventory[enemy_index].duplicate()
	self.add_child(enemy_slot)
	
func scroll_down():
	inventory[enemy_index].show()
	inventory[enemy_index - 15].hide()
	
func scroll_up():
	inventory[enemy_index - 14].show()
	inventory[enemy_index + 1].hide()
	
	
func _process(delta):
	var size_max = inventory.size()
	var inventory_max = (inventory.size() -1)
	if Input.is_action_just_pressed("ui_down") and enemies_active and enemy_index < inventory_max:
		SE.effect("Move Between")
		enemy_index += 1
	if Input.is_action_just_pressed("ui_up") and enemies_active and enemy_index > 0:
		SE.effect("Move Between")
		enemy_index -= 1
	if Input.is_action_just_pressed("ui_down") and enemy_index >=15:
		SE.effect("Move Between")
		scroll_down()
	if Input.is_action_just_pressed("ui_up") and enemy_index >=14:
		SE.effect("Move Between")
		scroll_up()
	
func get_id():
	if enemies_active:
		enemy_id = inventory[enemy_index].get_id()
		return enemy_id
		

func _on_EnemiesCursor_retread():
	if inventory.size() > 15:
		for x in range(15, inventory.size()):
			inventory[x].hide()
		for x in range(0, 14):
			inventory[x].show()
	enemy_index = 0
	enemies_active = false

func _on_MenuCursor_enemy_selecting():
	enemies_active = true
