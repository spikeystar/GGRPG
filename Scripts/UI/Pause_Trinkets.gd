extends Sprite
var trinket_id

func _ready():
	trinket_id = $TrinketsNode/TrinketsInventory.initial_id()
	set_id()
	$TrinketsNode/TrinketsCursor.inventory_max = $TrinketsNode/TrinketsInventory.trinket_max

func reset():
	trinket_id = $TrinketsNode/TrinketsInventory.initial_id()
	set_id()

func _process(delta):
	trinket_id = $TrinketsNode/TrinketsInventory.get_id()
	set_id()

func set_trinket_holder():
	$Held_name.text = $TrinketsNode/TrinketsInventory.get_holder_name()

func _on_TrinketsInventory_empty_trinkets():
	$TrinketInventory.hide()
	$TrinketInfo.text = "No trinkets"
	
func set_id():
	if trinket_id == "Gold Bracelet":
		$TrinketInventory.show()
		$TrinketInventory.frame = 6
		$TrinketInfo.text = "Increases holder's Attack by 30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Gold Chain":
		$TrinketInventory.show()
		$TrinketInventory.frame = 7
		$TrinketInfo.text = "Increases holder's Defense by 30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Gold Earring":
		$TrinketInventory.show()
		$TrinketInventory.frame = 8
		$TrinketInfo.text = "Increases holder's Magic by 30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "-":
		$TrinketInventory.hide()
		$TrinketInventory.frame = 0
		$TrinketInfo.text = "Remove the trinket from a party member"
		set_trinket_holder()

func _on_Members_main_retread():
	$TrinketsNode/TrinketsInventory.trinket_index = 0
	$TrinketsNode/TrinketsCursor.cursor_index = 0
