extends Sprite

var item_id
var selling = false
var able = false
var item_cost : int

func _ready():
	item_id = $MenuCursor.menu_name
	set_id()

func _process(delta):
	if selling:
		item_id = $MenuCursor.menu_name
		set_id()
	
func set_id():
	if item_id == "Yummy Cake":
		$Display.show()
		$Cost.show()
		$Display.frame = 0
		$Cost.text = "75 Mb"
		item_cost = 75
		$Info.text = "50 HP"
	if item_id == "Pretty Gem":
		$Display.show()
		$Cost.show()
		$Display.frame = 1
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "20 SP"
	if item_id == "Picnic Pie":
		$Display.show()
		$Cost.show()
		$Display.frame = 2
		$Cost.text = "400 Mb"
		item_cost = 400
		$Info.text = "100 HP for all"
	if item_id == "Sugar Pill":
		$Display.show()
		$Cost.show()
		$Display.frame = 3
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "20 HP and grants a random buff"
	if item_id == "Ginger Tea":
		$Display.show()
		$Cost.show()
		$Display.frame = 4
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "Recovers from all debuffs and statuses"
	if item_id == "Bounty Herb":
		$Display.show()
		$Cost.show()
		$Display.frame = 5
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "Revives a fallen party member to 50% health"
	if $MenuCursor.empty:
		$Display.hide()
		$Cost.hide()
		$Info.text = "No items"

func _input(event):
	if Input.is_action_just_pressed("ui_select") and selling and able and Party.Inventory.size() > 0:
			SE.effect("Marble")
			Party.marbles = Party.marbles + item_cost
			Party.item_index = $Sell_Inventory.item_index
			Party.remove_item()
			$MenuCursor.item_selecting = false
			if $Sell_Inventory.item_index == $Sell_Inventory.inventory_max and $Sell_Inventory.inventory_max >0:
				$MenuCursor.cursor_index -= 1
			#$MenuCursor.cursor_index -= 1
			#$Sell_Inventory.item_index -= 1
			$Sell_Inventory.item_removed()
			$MenuCursor.item_selecting = true

func _on_Interaction_selling():
	selling = true
	yield(get_tree().create_timer(0.1), "timeout")
	able = true

func _on_Interaction_option_selecting():
	selling = false
	able = false
	
