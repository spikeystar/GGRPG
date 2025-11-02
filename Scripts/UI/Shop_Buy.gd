extends Sprite
var item_id
var buying = false
var able = false
var item_cost : int
var bag_name : String
var bag_number : int

signal shop_check
signal not_enough

func _ready():
	item_id = $MenuCursor.menu_name
	set_id()

func reset():
	$MenuCursor.cursor_index = 0
	item_id = $MenuCursor.menu_name
	set_id()
	
func storage_count():
	for x in range (Party.Inventory.size()):
		bag_name = Party.Inventory[x].get_id()
		if bag_name == item_id:
			bag_number += 1

func _process(delta):
	item_id = $MenuCursor.menu_name
	set_id()
	storage_count()
	$Bag_Marbles.text = thousands_sep(Party.marbles) + " Mb"
	$Carrying.text = "Bag: " + str(bag_number)
	
static func thousands_sep(number, prefix=''):
	var neg = false
	if number < 0:
		number = -number
		neg = true
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	if neg: res = '-'+prefix+res
	else: res = prefix+res
	return res
	
func set_id():
	bag_number = 0
	if item_id == "Yummy Cake":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	if item_id == "Pretty Gem":
		$Display.show()
		$Display.frame = 1
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "20 SP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	if item_id == "Sugar Pill":
		$Display.show()
		$Display.frame = 3
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "30 HP & 5 SP\nGrants a random buff"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	if item_id == "Ginger Tea":
		$Display.show()
		$Display.frame = 4
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "10 HP & 5 SP\nHeals all statuses and debuffs"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	if item_id == "Bounty Herb":
		$Display.show()
		$Display.frame = 5
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "Revives a fallen party member to half health"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	if item_id == "Gold Bracelet":
		$Display.show()
		$Display.frame = 6
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Attack +30%\nWhammy! chance +5"
		$Carrying.hide()
		$Display.position = Vector2(85, -82)
	if item_id == "Gold Chain":
		$Display.show()
		$Display.frame = 7
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Defense +30%\nWhammy! chance +5"
		$Carrying.hide()
		$Display.position = Vector2(85, -82)
		
		
	if item_id == "Picnic Pie":
		$Display.show()
		$Display.frame = 2
		$Cost.text = "500 Mb"
		item_cost = 500
		$Info.text = "100 HP for all"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
		
	if item_id == "Delicious Cake":
		$Display.show()
		$Display.frame = 45
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "150 HP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Amazing Cake":
		$Display.show()
		$Display.frame = 46
		$Cost.text = "600 Mb"
		item_cost = 600
		$Info.text = "300 HP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Lovely Gem":
		$Display.show()
		$Display.frame = 47
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "50 SP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Beautiful Gem":
		$Display.show()
		$Display.frame = 48
		$Cost.text = "600 Mb"
		item_cost = 600
		$Info.text = "100 SP"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	
	if item_id == "Polar Parfait":
		$Display.show()
		$Display.frame = 50
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "50 HP & 10 SP\nApplies Water type"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Flummery Flambé":
		$Display.show()
		$Display.frame = 49
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "50 HP & 10 SP\nApplies Fire type"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Saffron Soufflé":
		$Display.show()
		$Display.frame = 51
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "50 HP & 10 SP\nApplies Air type"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Nori Cookie":
		$Display.show()
		$Display.frame = 52
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "50 HP & 10 SP\nApplies Earth type"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Icescream":
		$Display.show()
		$Display.frame = 54
		$Cost.text = "500 Mb"
		item_cost = 500
		$Info.text = "100 HP & 20 SP\nHeals Stun status"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Hocus Potion":
		$Display.show()
		$Display.frame = 63
		$Cost.text = "2,000 Mb"
		item_cost = 2000
		$Info.text = "30 SP\nPrevents all statuses for 3 turns"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
	
	if item_id == "Magic Mushroom":
		$Display.show()
		$Display.frame = 56
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "100 HP & 20 SP\nHeals all statuses & applies all buffs"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Starberry":
		$Display.show()
		$Display.frame = 55
		$Cost.text = "3,000 Mb"
		item_cost = 3000
		$Info.text = "150 HP & 50 SP\nHeals Poison status"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Remedy Bouquet":
		$Display.show()
		$Display.frame = 58
		$Cost.text = "4,000 Mb"
		item_cost = 4000
		$Info.text = "30 HP & 5 SP for all\nHeals all statuses and debuffs"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Perfect Panacea":
		$Display.show()
		$Display.frame = 57
		$Cost.text = "20,000 Mb"
		item_cost = 20000
		$Info.text = "Fully heals & revives party\nApllies all buffs"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Strange Perfume":
		$Display.show()
		$Display.frame = 64
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Inverts all enemy types & applies a random debuff"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Spikey Bomb":
		$Display.show()
		$Display.frame = 53
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Damage all enemies with a Neutral attack"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Jinx Doll":
		$Display.show()
		$Display.frame = 65
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Inflicts all debuffs & Poison on one enemy"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Faulty Amp":
		$Display.show()
		$Display.frame = 61
		$Cost.text = "2,000 Mb"
		item_cost = 2000
		$Info.text = "Damage all enemies with an Air attack"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Blister Grenade":
		$Display.show()
		$Display.frame = 59
		$Cost.text = "2,000 Mb"
		item_cost = 2000
		$Info.text = "Damage all enemies with a Fire attack"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Chilly Globe":
		$Display.show()
		$Display.frame = 60
		$Cost.text = "2,000 Mb"
		item_cost = 2000
		$Info.text = "Damage all enemies with a Water attack"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Power Drill":
		$Display.show()
		$Display.frame = 62
		$Cost.text = "2,000 Mb"
		item_cost = 2000
		$Info.text = "Damage all enemies with an Earth attack"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	#####
	
	if item_id == "Ruby Pendant":
		$Display.show()
		$Display.frame = 18
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Magic & Defense +20%\nSets type to Fire & Whammy! chance +2"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Sapphire Pendant":
		$Display.show()
		$Display.frame = 19
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Magic & Defense +20%\nSets type to Water & Whammy! chance +2"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Topaz Pendant":
		$Display.show()
		$Display.frame = 20
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Magic & Defense +20%\nSets type to Air & Whammy! chance +2"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Peridot Pendant":
		$Display.show()
		$Display.frame = 21
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Magic & Defense +20%\nSets type to Earth & Whammy! chance +2"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Flashlight":
		$Display.show()
		$Display.frame = 24
		$Cost.text = "4,000 Mb"
		item_cost = 4000
		$Info.text = "Holder's Magic +20%\nPrevents Targeted status on party"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Compass":
		$Display.show()
		$Display.frame = 29
		$Cost.text = "3,000 Mb"
		item_cost = 3000
		$Info.text = "Holder's Magic +20%\nPrevents Dizzy status on party"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "White Flag":
		$Display.show()
		$Display.frame = 32
		$Cost.text = "5,000 Mb"
		item_cost = 5000
		$Info.text = "Party's Defense +30%\nKeeps party types as Neutral"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Antique Watch":
		$Display.show()
		$Display.frame = 33
		$Cost.text = "7,000 Mb"
		item_cost = 7000
		$Info.text = "Magic +10%\nStun chance +10% & Whammy! chance +2"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Black Bass":
		$Display.show()
		$Display.frame = 84
		$Cost.text = "3,000 Mb"
		item_cost = 3000
		$Info.text = "A hefty weapon that can crush opponents"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Flying V":
		$Display.show()
		$Display.frame = 85
		$Cost.text = "7,000 Mb"
		item_cost = 7000
		$Info.text = "A lightweight guitar that deals devastating blows"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Silly Hammer":
		$Display.show()
		$Display.frame = 87
		$Cost.text = "6,000 Mb"
		item_cost = 6000
		$Info.text = "A toy hammer that hits suprisingly hard"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Pink Key":
		$Display.show()
		$Display.frame = 88
		$Cost.text = "7,000 Mb"
		item_cost = 7000
		$Info.text = "A majestic key that is meant for battle"
		$Carrying.show()
		$Display.position = Vector2(85, -82)
		
	if item_id == "Fork & Knife":
		$Display.show()
		$Display.frame = 89
		$Cost.text = "7,000 Mb"
		item_cost = 7000
		$Info.text = "A set of cutlery that can tear up enemies"
		$Carrying.show()
		$Display.position = Vector2(85, -82)

func _input(event):
	if Input.is_action_just_pressed("ui_select") and buying and able and Party.marbles >= item_cost:
		if item_id == "Gold Bracelet" or item_id == "Gold Chain":
			SE.effect("Select")
			Party.marbles = Party.marbles - item_cost
			Party.add_trinket_name = item_id
			Party.add_trinket()
			Shops.shop_name = "Tom"
			Shops.item_index = $Buy_Inventory.item_index
			Shops.remove_item()
			$MenuCursor.item_selecting = false
			if $Buy_Inventory.item_index == $Buy_Inventory.inventory_max:
				$Buy_Inventory.item_index -=1
				$MenuCursor.cursor_index -= 1
			$Buy_Inventory.item_removed()
			$MenuCursor.item_selecting = true
			able = false
			yield(get_tree().create_timer(0.1), "timeout")
			able = true
		else:
			#SE.effect("Marble")
			SE.effect("Select")
			Party.marbles = Party.marbles - item_cost
			Party.add_item_name = item_id
			Party.add_item()
			emit_signal("shop_check")
			able = false
			yield(get_tree().create_timer(0.1), "timeout")
			able = true
	if Input.is_action_just_pressed("ui_select") and able and buying:
		if Party.marbles < item_cost:
			SE.effect("Unable")
			#emit_signal("not_enough")
			return

func _on_Interaction_buying():
	buying = true
	yield(get_tree().create_timer(0.1), "timeout")
	able = true

func _on_Interaction_option_selecting():
	buying = false
	able = false
