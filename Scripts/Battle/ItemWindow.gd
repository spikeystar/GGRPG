extends Node2D

func _ready():
	pass

func item_check():
	var item_id = $ItemWindowPanel/ItemInventory.get_id()
	if item_id == "Yummy Cake":
		$ItemInventory.frame = 0
		$ItemInfo.text = "20 HP"
	if item_id == "Pretty Gem":
		$ItemInventory.frame = 1
		$ItemInfo.text = "10 SP"
	if item_id == "Picnic Pie":
		$ItemInventory.frame = 2
		$ItemInfo.text = "50 HP for all"
	if item_id == "Sugar Pill":
		$ItemInventory.frame = 3
		$ItemInfo.text = "30 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$ItemInventory.frame = 4
		$ItemInfo.text = "Heals all statuses and debuffs"
	if item_id == "Bounty Herb":
		$ItemInventory.frame = 5
		$ItemInfo.text = "Revives a fallen party member to half health"
	
func get_item_id():
	var item_id = $ItemWindowPanel/ItemInventory.get_id()
	return item_id
	
func _on_Menu_Cursor_item_active():
	item_check()
