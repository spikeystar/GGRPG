extends Sprite

func _process(delta):
	pass
	var trinket_id = $TrinketsNode/TrinketsPanel/TrinketsInventory.get_id()
	if trinket_id == "Gold Bracelet":
		$TrinketInventory.show()
		$TrinketInventory.frame = 6
		$TrinketInfo.text = "Increases holder's Attack by 20%"
	if trinket_id == "Gold Necklace":
		$TrinketInventory.show()
		$TrinketInventory.frame = 7
		$TrinketInfo.text = "Increases holder's Defense by 20%"
	if trinket_id == "Gold Earring":
		$TrinketInventory.show()
		$TrinketInventory.frame = 8
		$TrinketInfo.text = "Increases holder's Magic by 20%"


func _on_TrinketsInventory_empty_trinkets():
	$TrinketInventory.hide()
	$TrinketInfo.text = "No trinkets"
