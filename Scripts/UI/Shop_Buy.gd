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
	if item_id == "Pretty Gem":
		$Display.show()
		$Display.frame = 1
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "20 SP"
		$Carrying.show()
	if item_id == "Sugar Pill":
		$Display.show()
		$Display.frame = 3
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "30 HP & 5 SP\nGrants a random buff"
		$Carrying.show()
	if item_id == "Ginger Tea":
		$Display.show()
		$Display.frame = 4
		$Cost.text = "100 Mb"
		item_cost = 100
		$Info.text = "10 HP & 5 SP\nHeals all statuses and debuffs"
		$Carrying.show()
	if item_id == "Bounty Herb":
		$Display.show()
		$Display.frame = 5
		$Cost.text = "200 Mb"
		item_cost = 200
		$Info.text = "Revives a fallen party member to half health"
		$Carrying.show()
	if item_id == "Gold Bracelet":
		$Display.show()
		$Display.frame = 6
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Increases holder's Attack by 30%\nWhammy! chance +5"
		$Carrying.hide()
	if item_id == "Gold Chain":
		$Display.show()
		$Display.frame = 7
		$Cost.text = "1,000 Mb"
		item_cost = 1000
		$Info.text = "Increases holder's Defense by 30%\nWhammy! chance +5"
		$Carrying.hide()
		
	if item_id == "Delicious Cake":
		$Display.show()
		$Display.frame = 45
		$Cost.text = "300 Mb"
		item_cost = 300
		$Info.text = "150 HP"
		$Carrying.show()
		
	if item_id == "Amazing Cake":
		$Display.show()
		$Display.frame = 46
		$Cost.text = "600 Mb"
		item_cost = 600
		$Info.text = "300 HP"
		$Carrying.show()
		
	if item_id == "Lovely Gem":
		$Display.show()
		$Display.frame = 47
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Beautiful Gem":
		$Display.show()
		$Display.frame = 48
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
	
	if item_id == "Polar Parfait":
		$Display.show()
		$Display.frame = 49
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Flummery Flambé":
		$Display.show()
		$Display.frame = 50
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Saffron Soufflé":
		$Display.show()
		$Display.frame = 51
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Nori Cookie":
		$Display.show()
		$Display.frame = 52
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Icescream":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Hocus Potion":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
	
	if item_id == "Magic Mushroom":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Starberry":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Remedy Bouquet":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Perfect Panacea":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Strange Perfume":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Spikey Bomb":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Jinx Doll":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Faulty Amp":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Blister Grenade":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Chilly Globe":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Power Drill":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	#####
	
	if item_id == "Ruby Pendant":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Sapphire Pendant":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Topaz Pendant":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Peridot Pendant":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Flashlight":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Compass":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "White Flag":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Antique Watch":
		$Display.show()
		$Display.frame = 0
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Black Bass":
		$Display.show()
		$Display.frame = 84
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Flying V":
		$Display.show()
		$Display.frame = 85
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Silly Hammer":
		$Display.show()
		$Display.frame = 87
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Pink Key":
		$Display.show()
		$Display.frame = 88
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()
		
	if item_id == "Fork & Knife":
		$Display.show()
		$Display.frame = 89
		$Cost.text = "50 Mb"
		item_cost = 50
		$Info.text = "50 HP"
		$Carrying.show()

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
