extends Sprite
var item_id

func _ready():
	item_id = $ItemPanel/ItemInventoryBox.initial_id()
	set_id()

func reset():
	item_id = $ItemPanel/ItemInventoryBox.initial_id()
	set_id()

func _process(delta):
	item_id = $ItemPanel/ItemInventoryBox.get_id()
	set_id()

func _on_ItemInventoryBox_empty_items():
	$ItemInventory.hide()
	$ItemInfo.text = "No items"
	
func set_id():
	if item_id == "Yummy Cake":
		$ItemInventory.show()
		$ItemInventory.frame = 0
		$ItemInfo.text = "50 HP"
	if item_id == "Pretty Gem":
		$ItemInventory.show()
		$ItemInventory.frame = 1
		$ItemInfo.text = "20 SP"
	if item_id == "Picnic Pie":
		$ItemInventory.show()
		$ItemInventory.frame = 2
		$ItemInfo.text = "50 HP for all"
	if item_id == "Sugar Pill":
		$ItemInventory.show()
		$ItemInventory.frame = 3
		$ItemInfo.text = "30 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$ItemInventory.show()
		$ItemInventory.frame = 4
		$ItemInfo.text = "Heals all statuses and debuffs"
	if item_id == "Bounty Herb":
		$ItemInventory.show()
		$ItemInventory.frame = 5
		$ItemInfo.text = "Revives a fallen party member to half health"
