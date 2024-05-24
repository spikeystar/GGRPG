extends Sprite

func _process(delta):
	var trinket_id = $TrinketsNode/TrinketsInventory.get_id()
	if trinket_id == "Gold Bracelet":
		$TrinketInventory.show()
		$TrinketInventory.frame = 6
		$TrinketInfo.text = "Increases holder's Attack by 20%"
		set_trinket_holder()
	if trinket_id == "Gold Necklace":
		$TrinketInventory.show()
		$TrinketInventory.frame = 7
		$TrinketInfo.text = "Increases holder's Defense by 20%"
		set_trinket_holder()
	if trinket_id == "Gold Earring":
		$TrinketInventory.show()
		$TrinketInventory.frame = 8
		$TrinketInfo.text = "Increases holder's Magic by 20%"
		set_trinket_holder()
	if trinket_id == "-":
		$TrinketInventory.hide()
		$TrinketInventory.frame = 0
		$TrinketInfo.text = "Remove the trinket from a party member"
		set_trinket_holder()

func set_trinket_holder():
	$Held_name.text = $TrinketsNode/TrinketsInventory.get_holder_name()

func _on_TrinketsInventory_empty_trinkets():
	$TrinketInventory.hide()
	$TrinketInfo.text = "No trinkets"
