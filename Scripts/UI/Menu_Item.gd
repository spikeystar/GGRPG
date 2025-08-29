extends Label
var defend_active = false
var equipped = false
var holder_name : String = "-"

signal cursor_selected()
#signal go_to_Item()

func _ready():
	if text == PartyStats.gary_trinket:
		holder_name = "Gary"
		equipped = true
	if text == PartyStats.jacques_trinket:
		holder_name = "Jacques"
		equipped = true
	if text == PartyStats.irina_trinket:
		holder_name = "Irina"
		equipped = true
	if text == PartyStats.suzy_trinket:
		holder_name = "Suzy"
		equipped = true
	if text == PartyStats.damien_trinket:
		holder_name = "Damien"
		equipped = true
	if text != PartyStats.gary_trinket and text != PartyStats.jacques_trinket and text != PartyStats.irina_trinket and text != PartyStats.suzy_trinket and text != PartyStats.damien_trinket:
		holder_name = "-"
		equipped = false
	pass
	

func cursor_select() ->void:
	emit_signal("cursor_selected")

func get_id():
	if text == "Unequip Trinket" or text == "-":
		return "-"
		print("hello")
	else:
		return text
	
func get_holder_name():
	return holder_name
	
func get_trinket():
	if text == PartyStats.gary_trinket or text == PartyStats.jacques_trinket or text == PartyStats.irina_trinket or text == PartyStats.suzy_trinket or text == PartyStats.damien_trinket:
		equipped = true
	if text != PartyStats.gary_trinket and text != PartyStats.jacques_trinket and text != PartyStats.irina_trinket and text != PartyStats.suzy_trinket and text != PartyStats.damien_trinket:
		equipped = false
	return equipped
	
func trinket_scan():
	if text != PartyStats.gary_trinket and text != PartyStats.jacques_trinket and text != PartyStats.irina_trinket and text != PartyStats.suzy_trinket and text != PartyStats.damien_trinket:
		equipped = false
		holder_name = "-"
		
func trinket_check():
	if text == PartyStats.gary_trinket or text == PartyStats.jacques_trinket or text == PartyStats.irina_trinket or text == PartyStats.suzy_trinket or text == PartyStats.damien_trinket:
		equipped = true
		
func trinket_equip():
	equipped = true
	holder_name = PartyStats.holder_name
	
func trinket_unequip():
	equipped = false
	holder_name = "-"
	
func trinket_relocate():
	if holder_name == "Gary":
		PartyStats.gary_trinket = "-"
	if holder_name == "Jacques":
		PartyStats.jacques_trinket = "-"
	if holder_name == "Irina":
		PartyStats.irina_trinket = "-"
	if holder_name == "Suzy":
		PartyStats.suzy_trinket = "-"
	if holder_name == "Damien":
		PartyStats.damien_trinket = "-"
	

#func _on_WorldRoot_defend_active():
	#defend_active = true
	
