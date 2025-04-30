extends Sprite

var item_id
var deposit = false
var able = false
var storage_number : int
var storage_name : String

func _ready():
	item_id = $MenuCursor.menu_name
	set_id()
	
func storage_count():
	for x in range (Party.Storage.size()):
		storage_name = Party.Storage[x].get_id()
		if storage_name == item_id:
			storage_number += 1

func _process(delta):
	if deposit:
		item_id = $MenuCursor.menu_name
		set_id()
		storage_count()
		if storage_number >99:
			storage_number = 99
		$Storage/Storage_info.text = str(storage_number)
		
	
func set_id():
	storage_number = 0
	if item_id == "Yummy Cake":
		$Display.show()
		$Storage.show()
		$Display.frame = 0
		$Info.text = "50 HP"
	if item_id == "Pretty Gem":
		$Display.show()
		$Storage.show()
		$Display.frame = 1
		$Info.text = "20 SP"
	if item_id == "Picnic Pie":
		$Display.show()
		$Storage.show()
		$Display.frame = 2
		$Info.text = "100 HP for all"
	if item_id == "Sugar Pill":
		$Display.show()
		$Storage.show()
		$Display.frame = 3
		$Info.text = "30 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$Display.show()
		$Storage.show()
		$Display.frame = 4
		$Info.text = "10 HP & 5 SP\n\nHeals all statuses and debuffs"
	if item_id == "Bounty Herb":
		$Display.show()
		$Storage.show()
		$Display.frame = 5
		$Info.text = "Revives a fallen party member to half health"
	if $MenuCursor.empty:
		$Display.hide()
		$Storage.hide()
		$Info.text = "No items"

func _input(event):
	if Input.is_action_just_pressed("ui_select") and deposit and able and Party.Inventory.size() > 0:
			SE.effect("Select")
			Party.item_index = $Deposit_Inventory.item_index
			Party.add_item_name = item_id
			Party.remove_item()
			Party.deposit_item()
			$MenuCursor.item_selecting = false
			if $Deposit_Inventory.item_index == $Deposit_Inventory.inventory_max and $Deposit_Inventory.inventory_max >0:
				$MenuCursor.cursor_index -= 1
			$Deposit_Inventory.item_removed()
			$MenuCursor.item_selecting = true

func _on_Interaction_option_selecting():
	deposit = false
	able = false

func _on_Interaction_deposit():
	deposit = true
	yield(get_tree().create_timer(0.1), "timeout")
	able = true
