extends Sprite
var item_id
var buying = false
var able = false
var item_cost : int

func _ready():
	item_id = $MenuCursor.menu_name
	set_id()

func reset():
	item_id = $MenuCursor.menu_name
	set_id()

func _process(delta):
	item_id = $MenuCursor.menu_name
	set_id()
	
func set_id():
	if item_id == "Yummy Cake":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "50 HP"
	if item_id == "Pretty Gem":
		$Display.show()
		$Display.frame = 1
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "20 SP"
	if item_id == "Sugar Pill":
		$Display.show()
		$Display.frame = 3
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "20 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$Display.show()
		$Display.frame = 4
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "Recovers from all debuffs and statuses"
	if item_id == "Bounty Herb":
		$Display.show()
		$Display.frame = 5
		$Cost.text = "400 Mb"
		item_cost = 400
		$Info.text = "Revives a fallen party member to 50% health"
	if item_id == "Gold Bracelet":
		$Display.show()
		$Display.frame = 6
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Increases holder's Attack by 20%"
	if item_id == "Gold Chain":
		$Display.show()
		$Display.frame = 7
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Increases holder's Defense by 20%"

func _input(event):
	if Input.is_action_just_pressed("ui_select") and buying and able and Party.marbles >= item_cost:
		if item_id == "Gold Bracelet" or item_id == "Gold Chain":
			Party.marbles = Party.marbles - item_cost
			Party.add_trinket_name = item_id
			Party.add_trinket()
			Shops.shop_name = "Tom"
			Shops.item_index = $Buy_Inventory.item_index
			Shops.remove_item()
			$MenuCursor.item_selecting = false
			if $Buy_Inventory.item_index == $Buy_Inventory.inventory_max:
				$MenuCursor.cursor_index -= 1
			$Buy_Inventory.item_removed()
			$MenuCursor.item_selecting = true
		else:
			Party.marbles = Party.marbles - item_cost
			Party.add_item_name = item_id
			Party.add_item()

func _on_Interaction_buying():
	buying = true
	yield(get_tree().create_timer(0.1), "timeout")
	able = true

func _on_Interaction_option_selecting():
	buying = false
	able = false
