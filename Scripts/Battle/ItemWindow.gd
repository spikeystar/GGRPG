extends Node2D

var item_id = ""
var empty_items = false
var item_texture = preload("res://Assets/General/All Items.png")

func _ready():
	$ItemInventory.texture = item_texture
	$ItemInventory.vframes = 32
	$ItemWindowPanel.grow_horizontal = Control.GROW_DIRECTION_END
	$ItemWindowPanel/ItemInventory.alignment = BoxContainer.ALIGN_BEGIN
	$ItemWindowPanel/ItemInventory.grow_horizontal = Control.GROW_DIRECTION_END
	#$ItemWindowPanel/MenuCursor.show()
	
func _process(delta):
	if not empty_items:
		item_id = $ItemWindowPanel/ItemInventory.get_id()
		#item_id = $ItemWindowPanel/MenuCursor.menu_name
		item_check()

func item_check():
	#var item_id = $ItemWindowPanel/ItemInventory.get_id()
	if item_id == "Yummy Cake":
		$ItemInventory.show()
		$ItemInventory.frame = 0
		$ItemInfo.text = "50 HP"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Pretty Gem":
		$ItemInventory.show()
		$ItemInventory.frame = 1
		$ItemInfo.text = "20 SP"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Picnic Pie":
		$ItemInventory.show()
		$ItemInventory.frame = 2
		$ItemInfo.text = "100 HP for all"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Sugar Pill":
		$ItemInventory.show()
		$ItemInventory.frame = 3
		$ItemInfo.text = "30 HP & 5 SP\n\nGrants a random buff"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Ginger Tea":
		$ItemInventory.show()
		$ItemInventory.frame = 4
		$ItemInfo.text = "10 HP & 5 SP\n\nHeals all statuses and debuffs"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
	if item_id == "Bounty Herb":
		$ItemInventory.show()
		$ItemInventory.frame = 5
		$ItemInfo.text = "Revives a fallen party member to half health"
		$ItemInventory.position = Vector2(243, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
	if item_id == "Delicious Cake":
		$ItemInfo.text = "150 HP"
		$ItemInventory.position = Vector2(242, 63)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 45
		
	if item_id == "Amazing Cake":
		$ItemInfo.text = "300 HP"
		$ItemInventory.position = Vector2(241, 67)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 46
		
	if item_id == "Lovely Gem":
		$ItemInfo.text = "50 SP"
		$ItemInventory.position = Vector2(246, 63)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 47
		
	if item_id == "Beautiful Gem":
		$ItemInfo.text = "100 SP"
		$ItemInventory.position = Vector2(242, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 48
	
	if item_id == "Polar Parfait":
		$ItemInfo.text = "50 HP & 10 SP\nApplies Water type"
		$ItemInventory.position = Vector2(243, 65)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 50
		
	if item_id == "Flummery Flambé":
		$ItemInfo.text = "50 HP & 10 SP\nApplies Fire type"
		$ItemInventory.position = Vector2(241, 69)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 49
		
	if item_id == "Saffron Soufflé":
		$ItemInfo.text = "50 HP & 10 SP\nApplies Air type"
		$ItemInventory.position = Vector2(242, 75)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 51
		
	if item_id == "Nori Cookie":
		$ItemInfo.text = "50 HP & 10 SP\nApplies Earth type"
		$ItemInventory.position = Vector2(242.5, 72)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 52
		
	if item_id == "Icescream":
		$ItemInfo.text = "100 HP & 20 SP\nHeals Stun status"
		$ItemInventory.position = Vector2(240, 64)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 54
		
	if item_id == "Hocus Potion":
		$ItemInfo.text = "30 SP\nPrevents all statuses for 3 turns"
		$ItemInventory.position = Vector2(240, 69)
		$ItemInventory.scale = Vector2(1.12, 1.12)
		
		$ItemInventory.show()
		$ItemInventory.frame = 63
	
	if item_id == "Magic Mushroom":
		$ItemInfo.text = "100 HP & 20 SP\nHeals all statuses & applies all buffs"
		$ItemInventory.position = Vector2(243, 68)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 56
		
	if item_id == "Starberry":
		$ItemInfo.text = "150 HP & 50 SP\nHeals Poison status"
		$ItemInventory.position = Vector2(247.5, 62)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 55
		
	if item_id == "Remedy Bouquet":
		$ItemInfo.text = "30 HP & 5 SP for all\nHeals all statuses and debuffs"
		$ItemInventory.position = Vector2(247, 66)
		$ItemInventory.scale = Vector2(1.2, 1.2)
		
		$ItemInventory.show()
		$ItemInventory.frame = 58
		
	if item_id == "Perfect Panacea":
		$ItemInfo.text = "Fully heals & revives party\nApllies all buffs"
		$ItemInventory.position = Vector2(241, 66)
		$ItemInventory.scale = Vector2(1.25, 1.25)
		
		$ItemInventory.show()
		$ItemInventory.frame = 57
		
	if item_id == "Strange Perfume":
		$ItemInfo.text = "Inverts all enemy types & applies a random debuff"
		$ItemInventory.position = Vector2(246, 66)
		$ItemInventory.scale = Vector2(1.2, 1.2)
		
		$ItemInventory.show()
		$ItemInventory.frame = 64
		
	if item_id == "Spikey Bomb":
		$ItemInfo.text = "Damage all enemies with a Neutral attack"
		$ItemInventory.position = Vector2(243, 73)
		$ItemInventory.scale = Vector2(1.25, 1.25)
		
		$ItemInventory.show()
		$ItemInventory.frame = 53
		
	if item_id == "Jinx Doll":
		$ItemInfo.text = "Inflicts all debuffs & Poison on one enemy"
		$ItemInventory.position = Vector2(247, 69)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
		$ItemInventory.show()
		$ItemInventory.frame = 65
		
	if item_id == "Faulty Amp":
		$ItemInfo.text = "Damage all enemies with an Air attack"
		$ItemInventory.position = Vector2(245, 79)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
		$ItemInventory.show()
		$ItemInventory.frame = 61
		
	if item_id == "Blister Grenade":
		$ItemInfo.text = "Damage all enemies with a Fire attack"
		$ItemInventory.position = Vector2(244, 66)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
		$ItemInventory.show()
		$ItemInventory.frame = 59
		
	if item_id == "Chilly Globe":
		$ItemInfo.text = "Damage all enemies with a Water attack"
		$ItemInventory.position = Vector2(240, 75)
		$ItemInventory.scale = Vector2(1.1, 1.1)
		
		$ItemInventory.show()
		$ItemInventory.frame = 60
		
	if item_id == "Power Drill":
		$ItemInfo.text = "Damage all enemies with an Earth attack"
		$ItemInventory.position = Vector2(247, 77)
		$ItemInventory.scale = Vector2(1.15, 1.15)
		
		$ItemInventory.show()
		$ItemInventory.frame = 62
	
func get_item_id():
	var item_id = $ItemWindowPanel/ItemInventory.get_id()
	return item_id
	
func _on_Menu_Cursor_item_active():
	item_check()

func _on_ItemInventory_empty_items():
	empty_items = true
	$ItemInventory.hide()
	$ItemWindowPanel/MenuCursor.hide()
	$ItemInfo.text = "No items"
