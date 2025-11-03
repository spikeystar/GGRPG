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
	$Bag_Marbles.text = thousands_sep(Party.marbles) + " Mb"
	
	
func reset():
	item_id = $MenuCursor.menu_name
	set_id()
	
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
	if item_id == "Yummy Cake":
		$Display.show()
		$Cost.show()
		$Display.frame = 0
		$Cost.text = "30 Mb"
		item_cost = 30
		$Info.text = "50 HP"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Pretty Gem":
		$Display.show()
		$Cost.show()
		$Display.frame = 1
		$Cost.text = "30 Mb"
		item_cost = 30
		$Info.text = "20 SP"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Picnic Pie":
		$Display.show()
		$Cost.show()
		$Display.frame = 2
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "100 HP for all"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Sugar Pill":
		$Display.show()
		$Cost.show()
		$Display.frame = 3
		$Cost.text = "75 Mb"
		item_cost = 75
		$Info.text = "30 HP & 5 SP\nGrants a random buff"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Ginger Tea":
		$Display.show()
		$Cost.show()
		$Display.frame = 4
		$Cost.text = "75 Mb"
		item_cost = 75
		$Info.text = "10 HP & 5 SP\nHeals all statuses and debuffs"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
	if item_id == "Bounty Herb":
		$Display.show()
		$Cost.show()
		$Display.frame = 5
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "Revives a fallen party member to half health"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
		
	if $MenuCursor.empty:
		$Display.hide()
		$Cost.hide()
		$Info.text = "No items"
		
	if item_id == "Delicious Cake":
		$Display.show()
		$Display.frame = 45
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "150 HP"
		$Display.position = Vector2(85, -82)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Amazing Cake":
		$Display.show()
		$Display.frame = 46
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "300 HP"
		$Display.position = Vector2(83, -78)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Lovely Gem":
		$Display.show()
		$Display.frame = 47
		$Cost.text = "150 Mb"
		item_cost = 150
		$Info.text = "50 SP"
		$Display.position = Vector2(88, -80)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Beautiful Gem":
		$Display.show()
		$Display.frame = 48
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "100 SP"
		$Display.position = Vector2(85, -78)
		$Display.scale = Vector2(1.1, 1.1)
	
	if item_id == "Polar Parfait":
		$Display.show()
		$Display.frame = 50
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "50 HP & 10 SP\nApplies Water type"
		$Display.position = Vector2(85, -79)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Flummery Flambé":
		$Display.show()
		$Display.frame = 49
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "50 HP & 10 SP\nApplies Fire type"
		$Display.position = Vector2(83, -78)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Saffron Soufflé":
		$Display.show()
		$Display.frame = 51
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "50 HP & 10 SP\nApplies Air type"
		$Display.position = Vector2(85, -68)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Nori Cookie":
		$Display.show()
		$Display.frame = 52
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "50 HP & 10 SP\nApplies Earth type"
		$Display.position = Vector2(85, -71)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Icescream":
		$Display.show()
		$Display.frame = 54
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "100 HP & 20 SP\nHeals Stun status"
		$Display.position = Vector2(81, -78)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Hocus Potion":
		$Display.show()
		$Display.frame = 63
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "30 SP\nPrevents all statuses for 3 turns"
		$Display.position = Vector2(83, -74.5)
		$Display.scale = Vector2(1.12, 1.12)
	
	if item_id == "Magic Mushroom":
		$Display.show()
		$Display.frame = 56
		$Cost.text = "4,000 Mb"
		item_cost = 4000
		$Info.text = "100 HP & 20 SP\nHeals all statuses & applies all buffs"
		$Display.position = Vector2(85, -75)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Starberry":
		$Display.show()
		$Display.frame = 55
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "150 HP & 50 SP\nHeals Poison status"
		$Display.position = Vector2(89, -76)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Remedy Bouquet":
		$Display.show()
		$Display.frame = 58
		$Cost.text = "3,000 Mb"
		item_cost = 3000
		$Info.text = "30 HP & 5 SP for all\nHeals all statuses and debuffs"
		$Display.position = Vector2(87, -76)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Perfect Panacea":
		$Display.show()
		$Display.frame = 57
		$Cost.text = "15,000 Mb"
		item_cost = 15000
		$Info.text = "Fully heals & revives party\nApllies all buffs"
		$Display.position = Vector2(84, -76)
		$Display.scale = Vector2(1.25, 1.25)
		
	if item_id == "Strange Perfume":
		$Display.show()
		$Display.frame = 64
		$Cost.text = "700 Mb"
		item_cost = 700
		$Info.text = "Inverts all enemy types & applies a random debuff"
		$Display.position = Vector2(86.5, -77)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Spikey Bomb":
		$Display.show()
		$Display.frame = 53
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Damage all enemies with a Neutral attack"
		$Display.position = Vector2(83, -70)
		$Display.scale = Vector2(1.25, 1.25)
		
	if item_id == "Jinx Doll":
		$Display.show()
		$Display.frame = 65
		$Cost.text = "4,000 Mb"
		item_cost = 4000
		$Info.text = "Inflicts all debuffs & Poison on one enemy"
		$Display.position = Vector2(88.5, -75)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Faulty Amp":
		$Display.show()
		$Display.frame = 61
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Damage all enemies with an Air attack"
		$Display.position = Vector2(86, -66)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Blister Grenade":
		$Display.show()
		$Display.frame = 59
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Damage all enemies with a Fire attack"
		$Display.position = Vector2(85.5, -77)
		$Display.scale = Vector2(1.15, 1.15)
		
	if item_id == "Chilly Globe":
		$Display.show()
		$Display.frame = 60
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Damage all enemies with a Water attack"
		$Display.position = Vector2(81, -68)
		$Display.scale = Vector2(1.1, 1.1)
		
	if item_id == "Power Drill":
		$Display.show()
		$Display.frame = 62
		$Cost.text = "1,500 Mb"
		item_cost = 1500
		$Info.text = "Damage all enemies with an Earth attack"
		$Display.position = Vector2(88, -65)
		$Display.scale = Vector2(1.15, 1.15)

func _input(event):
	if Input.is_action_just_pressed("ui_select") and selling and able and Party.Inventory.size() > 0:
			SE.effect("Select")
			#Party.marbles = Party.marbles + item_cost
			Party.marbles = clamp(Party.marbles + item_cost, 0, 999999)
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
	
