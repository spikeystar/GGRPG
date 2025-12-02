extends Sprite

#onready var Members = get_tree().get_root().get_node("PauseMenu/Members")
#onready var Members = get_tree().get_root().get_node("PauseInstance/CanvasLayer/PauseMenu/Members")
var selector_name : String

func _process(delta):
	#var selector_name = Members.selector_name
	if selector_name == "Gary":
		$Name.text = "Gary"
		$Display.frame = 0
		$WeaponDisplay.frame = 0
		$Weapon_info.text = "Red Fender"
		
	#	$Weapon_info.text = PartyStats.gary_weapon
	#	if PartyStats.gary_weapon == "Red Fender":
	#		$WeaponDisplay.frame = 0
	#		$WeaponDisplay.position = Vector2(-109, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.gary_weapon == "Black Bass":
	#		$WeaponDisplay.frame = 3
	#		$WeaponDisplay.position = Vector2(-109, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.gary_weapon == "Flying V":
	#		$WeaponDisplay.frame = 4
	#		$WeaponDisplay.position = Vector2(-109, 90)
	#		$WeaponDisplay.scale = Vector2(0.92, 0.92)
	#	if PartyStats.gary_weapon == "Rickenbacker":
	#		$WeaponDisplay.frame = 5
	#		$WeaponDisplay.position = Vector2(-110, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#		$Weapon_info.text = "Ricken\nbacker"
			
			
		$HP_info.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Attack_info.text = str(PartyStats.gary_attack)
		$Magic_info.text = str(PartyStats.gary_magic)
		$Defense_info.text = str(PartyStats.gary_defense)
		if PartyStats.gary_trinket == "-":
			$Trinket_info.text = "_"
		else:
			$Trinket_info.text = str(PartyStats.gary_trinket)
	if selector_name == "Jacques":
		$Name.text = "Jacques"
		$Display.frame = 1
		$WeaponDisplay.frame = 1
		$Weapon_info.text = "Skateboard"
		
		
	#	$Weapon_info.text = PartyStats.jacques_weapon
	#	if PartyStats.jacques_weapon == "Skateboard":
	#		$WeaponDisplay.frame = 1
	#		$WeaponDisplay.position = Vector2(-109, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.jacques_weapon == "Surfboard":
	#		$WeaponDisplay.frame = 6
	#		$WeaponDisplay.position = Vector2(-110, 94)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.jacques_weapon == "Snowboard":
	#		$WeaponDisplay.frame = 7
	#		$WeaponDisplay.position = Vector2(-111, 93)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.jacques_weapon == "Santa Sleigh":
	#		$WeaponDisplay.frame = 8
	#		$WeaponDisplay.position = Vector2(-109, 92)
	#		$WeaponDisplay.scale = Vector2(1, 1)
			
			
		$HP_info.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Attack_info.text = str(PartyStats.jacques_attack)
		$Magic_info.text = str(PartyStats.jacques_magic)
		$Defense_info.text = str(PartyStats.jacques_defense)
		if PartyStats.jacques_trinket == "-":
			$Trinket_info.text = "_"
		else:
			$Trinket_info.text = str(PartyStats.jacques_trinket)
	if selector_name == "Irina":
		$Name.text = "Irina"
		$Display.frame = 2
		$WeaponDisplay.frame = 2
		$Weapon_info.text = "Star Wand"
		
	#	$Weapon_info.text = PartyStats.irina_weapon
	#	if PartyStats.irina_weapon == "Star Wand":
	#		$WeaponDisplay.frame = 2
	#		$WeaponDisplay.position = Vector2(-109, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.irina_weapon == "Silly Hammer":
	#		$WeaponDisplay.frame = 9
	#		$WeaponDisplay.position = Vector2(-111, 88)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.irina_weapon == "Pink Key":
	#		$WeaponDisplay.frame = 10
	#		$WeaponDisplay.position = Vector2(-111, 92)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.irina_weapon == "Fantasy Scepter":
	#		$WeaponDisplay.frame = 11
	#		$WeaponDisplay.position = Vector2(-111, 92)
	#		$WeaponDisplay.scale = Vector2(0.96, 0.96)
			
			
		$HP_info.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Attack_info.text = str(PartyStats.irina_attack)
		$Magic_info.text = str(PartyStats.irina_magic)
		$Defense_info.text = str(PartyStats.irina_defense)
		if PartyStats.irina_trinket == "-":
			$Trinket_info.text = "_"
		else:
			$Trinket_info.text = str(PartyStats.irina_trinket)
	if selector_name == "Suzy":
		$Name.text = "Suzy"
		$Display.frame = 3
		$WeaponDisplay.frame = 5
		$Weapon_info.text = "Candy Gun"
		
	#	$Weapon_info.text = PartyStats.suzy_weapon
	#	if PartyStats.suzy_weapon == "Candy Gun":
	#		$WeaponDisplay.frame = 12
	#		$WeaponDisplay.position = Vector2(-108, 90)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.suzy_weapon == "Fork & Knife":
	#		$WeaponDisplay.frame = 13
	#		$WeaponDisplay.position = Vector2(-107.5, 89)
	#		$WeaponDisplay.scale = Vector2(0.91, 0.91)
	#	if PartyStats.suzy_weapon == "Bubble Blaster":
	#		$WeaponDisplay.frame = 14
	#		$WeaponDisplay.position = Vector2(-108, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
		
		
		
		$HP_info.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Attack_info.text = str(PartyStats.suzy_attack)
		$Magic_info.text = str(PartyStats.suzy_magic)
		$Defense_info.text = str(PartyStats.suzy_defense)
		if PartyStats.suzy_trinket == "-":
			$Trinket_info.text = "_"
		else:
			$Trinket_info.text = str(PartyStats.suzy_trinket)
	if selector_name == "Damien":
		$Name.text = "Damien"
		$Display.frame = 4
		$Weapon_info.text = "Spellbook"
		
	#	$Weapon_info.text = PartyStats.damien_weapon
	#	if PartyStats.damien_weapon == "Spellbook":
	#		$WeaponDisplay.frame = 15
	#		$WeaponDisplay.position = Vector2(-108, 90)
	#		$WeaponDisplay.scale = Vector2(1, 1)
	#	if PartyStats.damien_weapon == "Tome of Ruin":
	#		$WeaponDisplay.frame = 16
	#		$WeaponDisplay.position = Vector2(-108, 91)
	#		$WeaponDisplay.scale = Vector2(1, 1)
		
		
		$HP_info.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Attack_info.text = str(PartyStats.damien_attack)
		$Magic_info.text = str(PartyStats.damien_magic)
		$Defense_info.text = str(PartyStats.damien_defense)
		if PartyStats.damien_trinket == "-":
			$Trinket_info.text = "_"
		else:
			$Trinket_info.text = str(PartyStats.damien_trinket)
		


func _on_Members_gary():
	selector_name = "Gary"

func _on_Members_damien():
	selector_name = "Damien"

func _on_Members_irina():
	selector_name = "Irina"

func _on_Members_suzy():
	selector_name = "Suzy"

func _on_Members_jacques():
	selector_name = "Jacques"
