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
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Pretty Gem":
		$ItemInventory.show()
		$ItemInventory.frame = 1
		$ItemInfo.text = "20 SP"
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Picnic Pie":
		$ItemInventory.show()
		$ItemInventory.frame = 2
		$ItemInfo.text = "100 HP for all"
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Sugar Pill":
		$ItemInventory.show()
		$ItemInventory.frame = 3
		$ItemInfo.text = "30 HP & 5 SP\n\nGrants a random buff"
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Ginger Tea":
		$ItemInventory.show()
		$ItemInventory.frame = 4
		$ItemInfo.text = "10 HP & 5 SP\n\nHeals all statuses and debuffs"
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Bounty Herb":
		$ItemInventory.show()
		$ItemInventory.frame = 5
		$ItemInfo.text = "Revives a fallen party member to half health"
		$ItemInventory.position = Vector2(90, -121)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Delicious Cake":
		$ItemInventory.frame = 45
		$ItemInfo.text = "150 HP"
		$ItemInventory.position = Vector2(89, -119)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Amazing Cake":
		$ItemInventory.frame = 46
		$ItemInfo.text = "300 HP"
		$ItemInventory.position = Vector2(88, -115)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Lovely Gem":
		$ItemInventory.frame = 47
		$ItemInfo.text = "50 SP"
		$ItemInventory.position = Vector2(93, -119)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Beautiful Gem":
		$ItemInventory.frame = 48
		$ItemInfo.text = "100 SP"
		$ItemInventory.position = Vector2(90, -117)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	
	if item_id == "Polar Parfait":
		$ItemInventory.frame = 50
		$ItemInfo.text = "50 HP & 10 SP\n\nApplies Water type"
		$ItemInventory.position = Vector2(90, -117)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Flummery Flambe":
		$ItemInventory.frame = 49
		$ItemInfo.text = "50 HP & 10 SP\n\nApplies Fire type"
		$ItemInventory.position = Vector2(89, -116)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Saffron Souffle":
		$ItemInventory.frame = 51
		$ItemInfo.text = "50 HP & 10 SP\n\nApplies Air type"
		$ItemInventory.position = Vector2(90, -108)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Nori Cookie":
		$ItemInventory.frame = 52
		$ItemInfo.text = "50 HP & 10 SP\n\nApplies Earth type"
		$ItemInventory.position = Vector2(88, -109)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Icescream":
		$ItemInventory.frame = 54
		$ItemInfo.text = "100 HP & 20 SP\n\nHeals Stun status"
		$ItemInventory.position = Vector2(87, -118)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Hocus Potion":
		$ItemInventory.frame = 63
		$ItemInfo.text = "30 SP\n\nPrevents all statuses for 3 turns"
		$ItemInventory.position = Vector2(88, -114)
		$ItemInventory.scale = Vector2(1.12, 1.12)
	
	if item_id == "Magic Mushroom":
		$ItemInventory.frame = 56
		$ItemInfo.text = "100 HP & 20 SP\n\nHeals all statuses & applies all buffs"
		$ItemInventory.position = Vector2(89, -114)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Starberry":
		$ItemInventory.frame = 55
		$ItemInfo.text = "150 HP & 50 SP\n\nHeals Poison status"
		$ItemInventory.position = Vector2(95, -116)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Remedy Bouquet":
		$ItemInventory.frame = 58
		$ItemInfo.text = "30 HP & 5 SP for all\n\nHeals all statuses and debuffs"
		$ItemInventory.position = Vector2(93, -115)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Perfect Panacea":
		$ItemInventory.frame = 57
		$ItemInfo.text = "Fully heals & revives party\n\nApllies all buffs"
		$ItemInventory.position = Vector2(88.5, -115)
		$ItemInventory.scale = Vector2(1.25, 1.25)
		
	if item_id == "Strange Perfume":
		$ItemInventory.frame = 64
		$ItemInfo.text = "Inverts all enemy types & applies a random debuff"
		$ItemInventory.position = Vector2(93, -117)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Spikey Bomb":
		$ItemInventory.frame = 53
		$ItemInfo.text = "Damage all enemies with a Neutral attack"
		$ItemInventory.position = Vector2(90, -109)
		$ItemInventory.scale = Vector2(1.25, 1.25)
		
	if item_id == "Jinx Doll":
		$ItemInventory.frame = 65
		$ItemInfo.text = "Inflicts all debuffs & Poison on one enemy"
		$ItemInventory.position = Vector2(94, -114)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Faulty Amp":
		$ItemInventory.frame = 61
		$ItemInfo.text = "Damage all enemies with an Air attack"
		$ItemInventory.position = Vector2(92, -103)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Blister Grenade":
		$ItemInventory.frame = 59
		$ItemInfo.text = "Damage all enemies with a Fire attack"
		$ItemInventory.position = Vector2(91, -116)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
	if item_id == "Chilly Globe":
		$ItemInventory.frame = 60
		$ItemInfo.text = "Damage all enemies with a Water attack"
		$ItemInventory.position = Vector2(87, -107)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Power Drill":
		$ItemInventory.frame = 62
		$ItemInfo.text = "Damage all enemies with an Earth attack"
		$ItemInventory.position = Vector2(94, -104)
		$ItemInventory.scale = Vector2(1.15, 1.15)


func _on_Members_main_retread():
	$ItemPanel/ItemInventoryBox.item_index = 0
	$ItemPanel/ItemMenuCursor.cursor_index = 0


func _on_ItemInventoryBox_return_to_item():
	reset()
