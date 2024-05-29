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
		$WeaponDisplay.frame = 9
		$Weapon_info.text = "Spellbook"
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
