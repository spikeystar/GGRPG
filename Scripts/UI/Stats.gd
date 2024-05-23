extends Sprite

onready var Members = get_tree().get_root().get_node("PauseMenu/Members")

func _process(delta):
	var selector_name = Members.selector_name
	if selector_name == "Gary":
		$Name.text = "Gary"
		$Display.frame = 0
		$WeaponDisplay.frame = 0
		$Weapon_info.text = "Red Fender"
		$HP_info.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Attack_info.text = str(PartyStats.gary_attack)
		$Magic_info.text = str(PartyStats.gary_magic)
		$Defense_info.text = str(PartyStats.gary_defense)
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
		$Trinket_info.text = str(PartyStats.irina_trinket)
		
