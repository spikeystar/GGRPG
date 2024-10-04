extends Sprite

var item_id
var withdraw = false
var able = false
var bag_number : int
var bag_name : String
var delay

func _ready():
	item_id = $MenuCursor.menu_name
	set_id()
	
func storage_count():
	for x in range (Party.Inventory.size()):
		bag_name = Party.Inventory[x].get_id()
		if bag_name == item_id:
			bag_number += 1

func _process(delta):
	if withdraw:
		item_id = $MenuCursor.menu_name
		set_id()
		storage_count()
		$Bag/Bag_info.text = str(bag_number)
		
	
func set_id():
	bag_number = 0
	if item_id == "Yummy Cake":
		$Display.show()
		$Bag.show()
		$Display.frame = 0
		$Info.text = "50 HP"
	if item_id == "Pretty Gem":
		$Display.show()
		$Bag.show()
		$Display.frame = 1
		$Info.text = "20 SP"
	if item_id == "Picnic Pie":
		$Display.show()
		$Bag.show()
		$Display.frame = 2
		$Info.text = "100 HP for all"
	if item_id == "Sugar Pill":
		$Display.show()
		$Bag.show()
		$Display.frame = 3
		$Info.text = "20 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$Display.show()
		$Bag.show()
		$Display.frame = 4
		$Info.text = "Recovers from all debuffs and statuses"
	if item_id == "Bounty Herb":
		$Display.show()
		$Bag.show()
		$Display.frame = 5
		$Info.text = "Revives a fallen party member to 50% health"
	if $MenuCursor.empty:
		$Display.hide()
		$Bag.hide()
		$Info.text = "No items"

func _input(event):
	if Input.is_action_just_pressed("ui_select") and withdraw and able and Party.Inventory.size() < 10 and $Withdraw_Inventory.size_max >0:
			SE.effect("Select")
			Party.storage_index = $Withdraw_Inventory.item_index
			Party.add_item_name = item_id
			Party.remove_storage()
			Party.add_item()
			$MenuCursor.item_selecting = false
			if $Withdraw_Inventory.item_index == $Withdraw_Inventory.inventory_max and $Withdraw_Inventory.inventory_max >0:
				$MenuCursor.cursor_index -= 1
			$Withdraw_Inventory.item_removed()
			$MenuCursor.item_selecting = true
			delay = true
			yield(get_tree().create_timer(0.05), "timeout")
			delay = false
	if Input.is_action_just_pressed("ui_select") and withdraw and able and Party.Inventory.size() == 10 and not delay:
		SE.effect("Unable")
		return

func _on_Interaction_option_selecting():
	withdraw = false
	able = false

func _on_Interaction_withdraw():
	withdraw = true
	yield(get_tree().create_timer(0.1), "timeout")
	able = true
