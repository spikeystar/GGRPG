extends Sprite
var trinket_id

func _ready():
	trinket_id = $TrinketsNode/TrinketsInventory.initial_id()
	set_id()
	$TrinketsNode/TrinketsCursor.inventory_max = $TrinketsNode/TrinketsInventory.trinket_max

func reset():
	trinket_id = $TrinketsNode/TrinketsInventory.trinket_id
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
		$TrinketInventory.position = Vector2(90, -121)
		$TrinketInfo.text = "Attack +30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Gold Chain":
		$TrinketInventory.show()
		$TrinketInventory.frame = 7
		$TrinketInventory.position = Vector2(90, -121)
		$TrinketInfo.text = "Defense +30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Gold Earring":
		$TrinketInventory.show()
		$TrinketInventory.frame = 8
		$TrinketInventory.position = Vector2(90, -121)
		$TrinketInfo.text = "Magic +30%\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "-":
		$TrinketInventory.hide()
		$TrinketInventory.frame = 0
		$TrinketInfo.text = "Remove the trinket from a party member"
		set_trinket_holder()
	if trinket_id == "Stress Ball":
		$TrinketInventory.show()
		$TrinketInventory.frame = 13
		$TrinketInventory.position = Vector2(90, -118)
		$TrinketInfo.text = "Attack +30%\n\nPrevents Wimpy status for whole party"
		set_trinket_holder()
	if trinket_id == "Comfy Blanket":
		$TrinketInventory.show()
		$TrinketInventory.frame = 12
		$TrinketInventory.position = Vector2(90, -118)
		$TrinketInfo.text = "Defense +30%\n\nPrevents Anxious status & SP loss for whole party"
		set_trinket_holder()
	if trinket_id == "Lucky Locket":
		$TrinketInventory.show()
		$TrinketInventory.frame = 14
		$TrinketInventory.position = Vector2(93, -111)
		$TrinketInfo.text = "Doubles battle marbles\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Beggar's Amulet":
		$TrinketInventory.show()
		$TrinketInventory.frame = 15
		$TrinketInventory.position = Vector2(91, -112)
		$TrinketInfo.text = "Magic & Defense +20%\n\n50% chance for party to keep an item after use"
		set_trinket_holder()
	if trinket_id == "Martyr's Medal":
		$TrinketInventory.show()
		$TrinketInventory.frame = 16
		$TrinketInventory.position = Vector2(88.5, -118)
		$TrinketInfo.text = "Attack & Magic +30%, but Defense -50%\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Ruby Pendant":
		$TrinketInventory.show()
		$TrinketInventory.frame = 18
		$TrinketInventory.position = Vector2(90, -117.5)
		$TrinketInfo.text = "Magic & Defense +20%\n\nSets default type to Fire, always prevents status effects from Fire moves\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Sapphire Pendant":
		$TrinketInventory.show()
		$TrinketInventory.frame = 19
		$TrinketInventory.position = Vector2(90, -117.5)
		$TrinketInfo.text = "Magic & Defense +20%\n\nSets default type to Water, always prevents status effects from Water moves\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Topaz Pendant":
		$TrinketInventory.show()
		$TrinketInventory.frame = 20
		$TrinketInventory.position = Vector2(90, -117.5)
		$TrinketInfo.text = "Magic & Defense +20%\n\nSets default type to Air, always prevents status effects from Air moves\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Peridot Pendant":
		$TrinketInventory.show()
		$TrinketInventory.frame = 21
		$TrinketInventory.position = Vector2(90, -117.5)
		$TrinketInfo.text = "Magic & Defense +20%\n\nSets default type to Earth, always prevents status effects from Earth moves\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Opal Pendant":
		$TrinketInventory.show()
		$TrinketInventory.frame = 22
		$TrinketInventory.position = Vector2(90, -119)
		$TrinketInfo.text = "Magic & Defense +30%\n\nAlways prevents status effects from Neutral moves\n\nWhammy! chance +4"
		set_trinket_holder()
	if trinket_id == "Bottlecap":
		$TrinketInventory.show()
		$TrinketInventory.frame = 17
		$TrinketInventory.position = Vector2(94.5, -124)
		$TrinketInfo.text = "Doubles battle EXP\n\nLowers all party stats by 30%"
		set_trinket_holder()
	if trinket_id == "Overdrive":
		$TrinketInventory.show()
		$TrinketInventory.frame = 23
		$TrinketInventory.position = Vector2(89, -120)
		$TrinketInfo.text = "Attack & Magic +20%\n\nWhammy! chance +7"
		set_trinket_holder()
	if trinket_id == "Flashlight":
		$TrinketInventory.show()
		$TrinketInventory.frame = 24
		$TrinketInventory.position = Vector2(89, -117)
		$TrinketInfo.text = "Magic +30%\n\nPrevents Targeted status for whole party"
		set_trinket_holder()
	if trinket_id == "Spiderbite Ring":
		$TrinketInventory.show()
		$TrinketInventory.frame = 25
		$TrinketInventory.position = Vector2(90.5, -115)
		$TrinketInfo.text = "All stats +30% & Whammy! chance +5 while afflicted by a status"
		set_trinket_holder()
	if trinket_id == "Pumpkin Pin":
		$TrinketInventory.show()
		$TrinketInventory.frame = 26
		$TrinketInventory.position = Vector2(92, -114.5)
		$TrinketInfo.text = "All stats +10%\n\nPrevents all debuffs on holder\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Ripple Ribbon":
		$TrinketInventory.show()
		$TrinketInventory.frame = 27
		$TrinketInventory.position = Vector2(91, -116)
		$TrinketInfo.text = "Attack & Magic +20%\n\n50% chance for a single attack to damage all enemies too\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Toxic Barb":
		$TrinketInventory.show()
		$TrinketInventory.frame = 28
		$TrinketInventory.position = Vector2(90, -116)
		$TrinketInfo.text = "Attack +30%\n\nAll attacks have a 25% chance to Poison"
		set_trinket_holder()
	if trinket_id == "Compass":
		$TrinketInventory.show()
		$TrinketInventory.frame = 29
		$TrinketInventory.position = Vector2(92, -117)
		$TrinketInfo.text = "Magic +30%\n\nPrevents Dizzy status for whole party"
		set_trinket_holder()
	if trinket_id == "Cloud Shroud":
		$TrinketInventory.show()
		$TrinketInventory.frame = 30
		$TrinketInventory.position = Vector2(90, -118)
		$TrinketInfo.text = "Defense +20% for whole party\n\n10% chance for attacks to miss a party member"
		set_trinket_holder()
	if trinket_id == "Shooting Star":
		$TrinketInventory.show()
		$TrinketInventory.frame = 31
		$TrinketInventory.position = Vector2(92.5, -116)
		$TrinketInfo.text = "All stats +10%\n\n30% chance to gain a random buff after attacking\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "White Flag":
		$TrinketInventory.show()
		$TrinketInventory.frame = 32
		$TrinketInventory.position = Vector2(90, -121)
		$TrinketInfo.text = "Defense +30% for whole party\n\nKeeps party types as Neutral entire battle"
		set_trinket_holder()
	if trinket_id == "Antique Watch":
		$TrinketInventory.show()
		$TrinketInventory.frame = 33
		$TrinketInventory.position = Vector2(91.5, -118.5)
		$TrinketInfo.text = "Magic +20% & prevent Stun\n\nAll attacks have a 10% chance to Stun"
		set_trinket_holder()
	if trinket_id == "Shiny Watch":
		$TrinketInventory.show()
		$TrinketInventory.frame = 34
		$TrinketInventory.position = Vector2(91.5, -118.5)
		$TrinketInfo.text = "Magic +30% & prevents Stun\n\nAll attacks have a 10% chance to Stun\n\nBuffs +1 turn"
		set_trinket_holder()
	if trinket_id == "Megaphone":
		$TrinketInventory.show()
		$TrinketInventory.frame = 36
		$TrinketInventory.position = Vector2(91, -122)
		$TrinketInfo.text = "Magic +20% for whole party\n\nAll party Buffs +2 turns"
		set_trinket_holder()
	if trinket_id == "Angel Egg":
		$TrinketInventory.show()
		$TrinketInventory.frame = 35
		$TrinketInventory.position = Vector2(91.5, -118)
		$TrinketInfo.text = "Magic & Defense +20%\n\nHolder will always withstand one fatal hit, but the trinket's effects disappear after"
		set_trinket_holder()
	if trinket_id == "Regal Brooch":
		$TrinketInventory.show()
		$TrinketInventory.frame = 37
		$TrinketInventory.position = Vector2(91.5, -121.5)
		$TrinketInfo.text = "Defense +100%, but applies Targeted for the whole battle\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Butterfly Charm":
		$TrinketInventory.show()
		$TrinketInventory.frame = 38
		$TrinketInventory.position = Vector2(91.5, -121)
		$TrinketInfo.text = "Recover 20% max HP each turn & prevents Stun\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Froggie Charm":
		$TrinketInventory.show()
		$TrinketInventory.frame = 39
		$TrinketInventory.position = Vector2(86.5, -117.5)
		$TrinketInfo.text = "Recover 10% max SP each turn & prevents Poison\n\nWhammy! chance +5"
		set_trinket_holder()
	if trinket_id == "Cutie Charm":
		$TrinketInventory.show()
		$TrinketInventory.frame = 40
		$TrinketInventory.position = Vector2(87, -115)
		$TrinketInfo.text = "Recover 20% max HP & 10% SP each turn\n\nWhammy! chance +2"
		set_trinket_holder()
	if trinket_id == "Super Cape":
		$TrinketInventory.show()
		$TrinketInventory.frame = 41
		$TrinketInventory.position = Vector2(92, -116)
		$TrinketInfo.text = "Attack & Magic +20%\n\nType damage now does 2X dealing and receiving for whole party\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Mystic Catalyst":
		$TrinketInventory.show()
		$TrinketInventory.frame = 42
		$TrinketInventory.position = Vector2(90, -116.5)
		$TrinketInfo.text = "Magic +30%\n\nHolder uses 1/2 SP for magic"
		set_trinket_holder()
	if trinket_id == "Flower Crown":
		$TrinketInventory.show()
		$TrinketInventory.frame = 44
		$TrinketInventory.position = Vector2(91, -116)
		$TrinketInfo.text = "All stats +10% for whole party\n\nPrevents all statuses & SP loss on holder\n\nWhammy! chance +3"
		set_trinket_holder()
	if trinket_id == "Crux Reactor":
		$TrinketInventory.show()
		$TrinketInventory.frame = 43
		$TrinketInventory.position = Vector2(90, -116)
		$TrinketInfo.text = "Magic +50%, but holder uses 1.5X SP\n\nSame magic spell cannot be used twice in a row\n\nWhammy! chance +5"
		set_trinket_holder()

func _on_Members_main_retread():
	$TrinketsNode/TrinketsInventory.trinket_index = 0
	$TrinketsNode/TrinketsCursor.cursor_index = 0
	SceneManager.transitioning = false

func _on_TrinketsInventory_return_to_trinkets():
	reset()
