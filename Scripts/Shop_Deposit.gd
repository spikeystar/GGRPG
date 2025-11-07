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
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Pretty Gem":
		$Display.show()
		$Storage.show()
		$Display.frame = 1
		$Info.text = "20 SP"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Picnic Pie":
		$Display.show()
		$Storage.show()
		$Display.frame = 2
		$Info.text = "100 HP for all"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Sugar Pill":
		$Display.show()
		$Storage.show()
		$Display.frame = 3
		$Info.text = "30 HP & 5 SP\nGrants a random buff"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Ginger Tea":
		$Display.show()
		$Storage.show()
		$Display.frame = 4
		$Info.text = "10 HP & 5 SP\nHeals all statuses and debuffs"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Bounty Herb":
		$Display.show()
		$Storage.show()
		$Display.frame = 5
		$Info.text = "Revives a fallen party member to half health"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Delicious Cake":
		$Display.show()
		$Display.frame = 45
		$Info.text = "150 HP"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Amazing Cake":
		$Display.show()
		$Display.frame = 46
		$Info.text = "300 HP"
		$Display.position = Vector2(83, -78)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Lovely Gem":
		$Display.show()
		$Display.frame = 47
		$Info.text = "50 SP"
		$Display.position = Vector2(88, -80)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Beautiful Gem":
		$Display.show()
		$Display.frame = 48
		$Info.text = "100 SP"
		$Display.position = Vector2(85, -78)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
	
	if item_id == "Polar Parfait":
		$Display.show()
		$Display.frame = 50
		$Info.text = "50 HP & 10 SP\nApplies Water type"
		$Display.position = Vector2(85, -79)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Flummery Flambé":
		$Display.show()
		$Display.frame = 49
		$Info.text = "50 HP & 10 SP\nApplies Fire type"
		$Display.position = Vector2(83, -78)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Saffron Soufflé":
		$Display.show()
		$Display.frame = 51
		$Info.text = "50 HP & 10 SP\nApplies Air type"
		$Display.position = Vector2(85, -68)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Nori Cookie":
		$Display.show()
		$Display.frame = 52
		$Info.text = "50 HP & 10 SP\nApplies Earth type"
		$Display.position = Vector2(85, -71)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Icescream":
		$Display.show()
		$Display.frame = 54
		$Info.text = "100 HP & 20 SP\nHeals Stun status"
		$Display.position = Vector2(81, -78)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Hocus Potion":
		$Display.show()
		$Display.frame = 63
		$Info.text = "30 SP\nPrevents all statuses for 3 turns"
		$Display.position = Vector2(83, -74.5)
		$Display.scale = Vector2(1.12, 1.12)
		$Storage.show()
	
	if item_id == "Magic Mushroom":
		$Display.show()
		$Display.frame = 56
		$Info.text = "100 HP & 20 SP\nHeals all statuses & applies all buffs"
		$Display.position = Vector2(85, -75)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Starberry":
		$Display.show()
		$Display.frame = 55
		$Info.text = "150 HP & 50 SP\nHeals Poison status"
		$Display.position = Vector2(89, -76)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Remedy Bouquet":
		$Display.show()
		$Display.frame = 58
		$Info.text = "30 HP & 5 SP for all\nHeals all statuses and debuffs"
		$Display.position = Vector2(87, -76)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Perfect Panacea":
		$Display.show()
		$Display.frame = 57
		$Info.text = "Fully heals & revives party\nApllies all buffs"
		$Display.position = Vector2(84, -76)
		$Display.scale = Vector2(1.25, 1.25)
		$Storage.show()
		
	if item_id == "Strange Perfume":
		$Display.show()
		$Display.frame = 64
		$Info.text = "Inverts all enemy types & applies a random debuff"
		$Display.position = Vector2(86.5, -77)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Spikey Bomb":
		$Display.show()
		$Display.frame = 53
		$Info.text = "Damage all enemies with a Neutral attack"
		$Display.position = Vector2(83, -70)
		$Display.scale = Vector2(1.25, 1.25)
		$Storage.show()
		
	if item_id == "Jinx Doll":
		$Display.show()
		$Display.frame = 65
		$Info.text = "Inflicts all debuffs & Poison on one enemy"
		$Display.position = Vector2(88.5, -75)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Faulty Amp":
		$Display.show()
		$Display.frame = 61
		$Info.text = "Damage all enemies with an Air attack"
		$Display.position = Vector2(86, -66)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Blister Grenade":
		$Display.show()
		$Display.frame = 59
		$Info.text = "Damage all enemies with a Fire attack"
		$Display.position = Vector2(85.5, -77)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if item_id == "Chilly Globe":
		$Display.show()
		$Display.frame = 60
		$Info.text = "Damage all enemies with a Water attack"
		$Display.position = Vector2(81, -68)
		$Display.scale = Vector2(1.1, 1.1)
		$Storage.show()
		
	if item_id == "Power Drill":
		$Display.show()
		$Display.frame = 62
		$Info.text = "Damage all enemies with an Earth attack"
		$Display.position = Vector2(88, -65)
		$Display.scale = Vector2(1.15, 1.15)
		$Storage.show()
		
	if $MenuCursor.empty:
		$Display.hide()
		$Storage.hide()
		$Info.text = "No items"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)

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
