extends Label
var defend_active = false
var equipped = false
var holder_name : String = "-"

signal cursor_selected()
signal go_to_Item()

func _ready():
	#print("ok")
	pass

func cursor_select() ->void:
	emit_signal("cursor_selected")

func get_id():
	if text == "Unequip Trinket":
		return "-"
	else:
		return text
	
func get_holder_name():
	return holder_name
	
func get_trinket():
	return equipped
	
func trinket_scan():
	if text != PartyStats.gary_trinket and text != PartyStats.jacques_trinket and text != PartyStats.irina_trinket and text != PartyStats.suzy_trinket and text != PartyStats.damien_trinket:
		equipped = false
		holder_name = "-"
		
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
	
