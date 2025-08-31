extends Sprite
onready var Cursors = []
var member_index = -1
var party_selecting = false
var able = false
var switching = false
var item_selecting = false
var trinket_selecting = false
var current_id : int
var member_name : String
var selector_name : String
var stats_active = false

var reverse = false

signal member_options
signal item_usage
signal trinket_equipped
signal main_retread
signal switched

signal gary
signal jacques
signal irina
signal suzy
signal damien

func _ready():
	Cursors = $Cursors.get_children()
	set_available()
	set_labels()
	
func select_next_member(index_offset):
	var last_member_index = member_index;
	var new_member_index = fposmod(last_member_index + index_offset, Cursors.size())
	Cursors[last_member_index].hide()
	Cursors[new_member_index].show()
	member_index = new_member_index
	
	if PartyStats.party_members > 1 and member_index < Cursors.size():
		SE.effect("Move Between")

func _process(delta):
	set_labels()
	PartyStats.party_id = (member_index + 1)
	if Input.is_action_just_pressed("ui_right") and party_selecting:
		select_next_member(+1)
		#reverse = false
		
		if PartyStats.party_members > 1:
			SE.effect("Move Between")
			reverse = false
		
	if Input.is_action_just_pressed("ui_left") and party_selecting and not member_index == 0:
		select_next_member(-1)
		print(member_index)
		
		if PartyStats.party_members > 1:
			SE.effect("Move Between")
			
		yield(get_tree().create_timer(0.1), "timeout")
		reverse = true
		
	if Input.is_action_just_pressed("ui_left") and party_selecting and member_index == 0:
		reverse = true
			
	if Input.is_action_just_pressed("ui_left") and party_selecting and member_index == 0 and not stats_active and reverse and not switching and not item_selecting and not trinket_selecting:
		SE.effect("Move Between")
		Cursors[member_index].hide()
		member_index = -1
		able = false
		party_selecting = false
		emit_signal("main_retread")
		
	if Input.is_action_just_pressed("ui_down") and party_selecting and PartyStats.party_members >= 4 and member_index == 0:
		SE.effect("Move Between")
		member_index = 3
		Cursors[0].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and party_selecting and PartyStats.party_members >= 4 and member_index == 1:
		SE.effect("Move Between")
		member_index = 3
		Cursors[1].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and party_selecting and PartyStats.party_members == 4 and member_index == 2:
		SE.effect("Move Between")
		member_index = 3
		Cursors[2].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_up") and party_selecting and member_index == 3 and PartyStats.party_members >= 4:
		SE.effect("Move Between")
		member_index = 0
		Cursors[3].hide()
		Cursors[0].show()
		
	if Input.is_action_just_pressed("ui_down") and party_selecting and PartyStats.party_members == 5 and member_index == 2:
		SE.effect("Move Between")
		member_index = 4
		Cursors[2].hide()
		Cursors[4].show()
		
	if Input.is_action_just_pressed("ui_up") and party_selecting and PartyStats.party_members == 5 and member_index == 4:
		SE.effect("Move Between")
		member_index = 1
		Cursors[4].hide()
		Cursors[1].show()

	if Input.is_action_just_pressed("ui_select") and party_selecting and able and not switching:
		SE.effect("Select")
		emit_signal("member_options")
		party_selecting = false
		current_id = (member_index + 1)
		selector_name = get_name()
		if selector_name == "Gary":
			emit_signal("gary")
		if selector_name == "Jacques":
			emit_signal("jacques")
		if selector_name == "Irina":
			emit_signal("irina")
		if selector_name == "Suzy":
			emit_signal("suzy")
		if selector_name == "Damien":
			emit_signal("damien")
		print(member_index)
		
	#if Input.is_action_just_pressed("ui_accept") and party_selecting and not stats_active:
		#SE.effect("Cancel")
		#$Cursors.hide()
		#Cursors[member_index].hide()
		#able = false
		#member_index = -1
		
	if Input.is_action_just_pressed("ui_accept") and item_selecting:
		SE.silence("Move Between")
		SE.effect("Cancel")
		Cursors[member_index].hide()
		member_index = -1
		$Cursors.hide()
		item_selecting = false
		able = false
		emit_signal("main_retread")
		
		
	if Input.is_action_just_pressed("ui_accept") and trinket_selecting:
		SE.silence("Move Between")
		SE.effect("Cancel")
		Cursors[member_index].hide()
		member_index = -1
		$Cursors.hide()
		$Trinkets.hide()
		$HP.show()
		trinket_selecting = false
		able = false
		emit_signal("main_retread")
		
		
	if Input.is_action_just_pressed("ui_select") and party_selecting and able and switching:
		SE.effect("Switch")
		emit_signal("switched")
		switching = false
		member_name = get_name()
		if selector_name == "Gary":
			PartyStats.gary_id = PartyStats.party_id
		if selector_name == "Jacques":
			PartyStats.jacques_id = PartyStats.party_id
		if selector_name == "Irina":
			PartyStats.irina_id = PartyStats.party_id
		if selector_name == "Suzy":
			PartyStats.suzy_id = PartyStats.party_id
		if selector_name == "Damien":
			PartyStats.damien_id = PartyStats.party_id
			
		if member_name == "Gary":
			PartyStats.gary_id = current_id
		if member_name == "Jacques":
			PartyStats.jacques_id = current_id
		if member_name == "Irina":
			PartyStats.irina_id = current_id
		if member_name == "Suzy":
			PartyStats.suzy_id = current_id
		if member_name == "Damien":
			PartyStats.damien_id = current_id
		
		##########
		
	if Input.is_action_just_pressed("ui_right") and item_selecting:
		select_next_member(+1)
		
	if Input.is_action_just_pressed("ui_left") and item_selecting:
		select_next_member(-1)

	if Input.is_action_just_pressed("ui_select") and item_selecting and able:
		SceneManager.transitioning = true
		SE.effect("Heal")
		selector_name = get_name()
		if selector_name == "Gary":
			emit_signal("gary")
		if selector_name == "Jacques":
			emit_signal("jacques")
		if selector_name == "Irina":
			emit_signal("irina")
		if selector_name == "Suzy":
			emit_signal("suzy")
		if selector_name == "Damien":
			emit_signal("damien")
		emit_signal("item_usage")
		item_selecting = false
		able = false
		
	if Input.is_action_just_pressed("ui_down") and item_selecting and PartyStats.party_members >= 4 and member_index == 0:
		SE.effect("Move Between")
		member_index = 3
		Cursors[0].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and item_selecting and PartyStats.party_members >= 4 and member_index == 1:
		SE.effect("Move Between")
		member_index = 3
		Cursors[1].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and item_selecting and PartyStats.party_members == 4 and member_index == 2:
		SE.effect("Move Between")
		member_index = 3
		Cursors[2].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_up") and item_selecting and member_index == 3 and PartyStats.party_members >= 4:
		SE.effect("Move Between")
		member_index = 0
		Cursors[3].hide()
		Cursors[0].show()
		
	if Input.is_action_just_pressed("ui_down") and item_selecting and PartyStats.party_members == 5 and member_index == 2:
		SE.effect("Move Between")
		member_index = 4
		Cursors[2].hide()
		Cursors[4].show()
		
	if Input.is_action_just_pressed("ui_up") and item_selecting and PartyStats.party_members == 5 and member_index == 4:
		SE.effect("Move Between")
		member_index = 1
		Cursors[4].hide()
		Cursors[1].show()
		
		##############
		
	if Input.is_action_just_pressed("ui_right") and trinket_selecting:
		select_next_member(+1)
		
	if Input.is_action_just_pressed("ui_left") and trinket_selecting:
		select_next_member(-1)

	if Input.is_action_just_pressed("ui_select") and trinket_selecting and able:
		SceneManager.transitioning = true
		SE.effect("Switch")
		selector_name = get_name()
		if selector_name == "Gary":
			emit_signal("gary")
		if selector_name == "Jacques":
			emit_signal("jacques")
		if selector_name == "Irina":
			emit_signal("irina")
		if selector_name == "Suzy":
			emit_signal("suzy")
		if selector_name == "Damien":
			emit_signal("damien")
		emit_signal("trinket_equipped")
		trinket_selecting = false
		able = false
		
	if Input.is_action_just_pressed("ui_down") and trinket_selecting and PartyStats.party_members >= 4 and member_index == 0:
		SE.effect("Move Between")
		member_index = 3
		Cursors[0].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and trinket_selecting and PartyStats.party_members >= 4 and member_index == 1:
		SE.effect("Move Between")
		member_index = 3
		Cursors[1].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_down") and trinket_selecting and PartyStats.party_members == 4 and member_index == 2:
		SE.effect("Move Between")
		member_index = 3
		Cursors[2].hide()
		Cursors[3].show()
		
	if Input.is_action_just_pressed("ui_up") and trinket_selecting and member_index == 3 and PartyStats.party_members >= 4:
		SE.effect("Move Between")
		member_index = 0
		Cursors[3].hide()
		Cursors[0].show()
		
	if Input.is_action_just_pressed("ui_down") and trinket_selecting and PartyStats.party_members == 5 and member_index == 2:
		SE.effect("Move Between")
		member_index = 4
		Cursors[2].hide()
		Cursors[4].show()
		
	if Input.is_action_just_pressed("ui_up") and trinket_selecting and PartyStats.party_members == 5 and member_index == 4:
		SE.effect("Move Between")
		member_index = 1
		Cursors[4].hide()
		Cursors[1].show()
		
		#################
		
func get_name():
	if member_index == 0:
		member_name = $Name1.text
	if member_index == 1:
		member_name = $Name2.text
	if member_index == 2:
		member_name = $Name3.text
	if member_index == 3:
		member_name = $Name4.text
	if member_index == 4:
		member_name = $Name5.text
	return member_name
	
func _on_MenuCursor_party_selecting():
	party_selecting = true
	$Cursors.show()
	yield(get_tree().create_timer(0.2), "timeout")
	able = true
	reverse = true
	#Cursors[].show()

func _on_MenuCursor_retread():
	$Cursors.hide()
	Cursors[member_index].hide()
	party_selecting = false
	able = false
	member_index = -1
	switching = false
	
func _on_MenuCursor_mini_retread():
	$Cursors.show()
	Cursors[member_index].show()
	party_selecting = true
	able = false
	yield(get_tree().create_timer(0.1), "timeout")
	able = true
	switching = false
	
func _on_MemberOptionsCursor_party_selecting():
	party_selecting = true
	$Cursors.show()
	yield(get_tree().create_timer(0.2), "timeout")
	able = true

func _on_MemberOptionsCursor_switch_selecting():
	party_selecting = true
	$Cursors.show()
	yield(get_tree().create_timer(0.2), "timeout")
	able = true
	switching = true

func _on_ItemInventoryBox_heal_item_chosen():
	Cursors[member_index].hide()
	member_index = 0
	$Cursors.show()
	Cursors[member_index].show()
	item_selecting = true
	yield(get_tree().create_timer(0.2), "timeout")
	able = true

func _on_TrinketsInventory_trinket_chosen():
	$Cursors.hide()
	Cursors[member_index].hide()
	member_index = 0
	$Cursors.show()
	Cursors[member_index].show()
	trinket_selecting = true
	yield(get_tree().create_timer(0.2), "timeout")
	able = true

func set_available():
	if PartyStats.party_members == 1:
		$Hidden2.show()
		$Hidden3.show()
		$Hidden4.show()
		$Hidden5.show()
		$Name1.show()
		$Name2.hide()
		$Name3.hide()
		$Name4.hide()
		$Name5.hide()
		$Display1.show()
		$Display2.hide()
		$Display3.hide()
		$Display4.hide()
		$Display5.hide()
		$HP/HP1.show()
		$HP/HP2.hide()
		$HP/HP3.hide()
		$HP/HP4.hide()
		$HP/HP5.hide()
		$Trinkets/Trinket1.show()
		$Trinkets/Trinket2.hide()
		$Trinkets/Trinket3.hide()
		$Trinkets/Trinket4.hide()
		$Trinkets/Trinket5.hide()
		Cursors.remove(4)
		Cursors.remove(3)
		Cursors.remove(2)
		Cursors.remove(1)
	if PartyStats.party_members == 2:
		$Hidden2.hide()
		$Hidden3.show()
		$Hidden4.show()
		$Hidden5.show()
		$Name1.show()
		$Name2.show()
		$Name3.hide()
		$Name4.hide()
		$Name5.hide()
		$Display1.show()
		$Display2.show()
		$Display3.hide()
		$Display4.hide()
		$Display5.hide()
		$HP/HP1.show()
		$HP/HP2.show()
		$HP/HP3.hide()
		$HP/HP4.hide()
		$HP/HP5.hide()
		$Trinkets/Trinket1.show()
		$Trinkets/Trinket2.show()
		$Trinkets/Trinket3.hide()
		$Trinkets/Trinket4.hide()
		$Trinkets/Trinket5.hide()
		Cursors.remove(4)
		Cursors.remove(3)
		Cursors.remove(2)
	if PartyStats.party_members == 3:
		$Hidden2.hide()
		$Hidden3.hide()
		$Hidden4.show()
		$Hidden5.show()
		$Name1.show()
		$Name2.show()
		$Name3.show()
		$Name4.hide()
		$Name5.hide()
		$Display1.show()
		$Display2.show()
		$Display3.show()
		$Display4.hide()
		$Display5.hide()
		$HP/HP1.show()
		$HP/HP2.show()
		$HP/HP3.show()
		$HP/HP4.hide()
		$HP/HP5.hide()
		$Trinkets/Trinket1.show()
		$Trinkets/Trinket2.show()
		$Trinkets/Trinket3.show()
		$Trinkets/Trinket4.hide()
		$Trinkets/Trinket5.hide()
		Cursors.remove(4)
		Cursors.remove(3)
	if PartyStats.party_members == 4:
		$Hidden2.hide()
		$Hidden3.hide()
		$Hidden4.hide()
		$Hidden5.show()
		$Name1.show()
		$Name2.show()
		$Name3.show()
		$Name4.show()
		$Name5.hide()
		$Display1.show()
		$Display2.show()
		$Display3.show()
		$Display4.show()
		$Display5.hide()
		$HP/HP1.show()
		$HP/HP2.show()
		$HP/HP3.show()
		$HP/HP4.show()
		$HP/HP5.hide()
		$Trinkets/Trinket1.show()
		$Trinkets/Trinket2.show()
		$Trinkets/Trinket3.show()
		$Trinkets/Trinket4.show()
		$Trinkets/Trinket5.hide()
		Cursors.remove(4)
	if PartyStats.party_members == 5:
		$Hidden2.hide()
		$Hidden3.hide()
		$Hidden4.hide()
		$Hidden5.hide()
		$Name1.show()
		$Name2.show()
		$Name3.show()
		$Name4.show()
		$Name5.show()
		$Display1.show()
		$Display2.show()
		$Display3.show()
		$Display4.show()
		$Display5.show()
		$HP/HP1.show()
		$HP/HP2.show()
		$HP/HP3.show()
		$HP/HP4.show()
		$HP/HP5.show()
		$Trinkets/Trinket1.show()
		$Trinkets/Trinket2.show()
		$Trinkets/Trinket3.show()
		$Trinkets/Trinket4.show()
		$Trinkets/Trinket5.show()

func set_labels():
	if PartyStats.gary_id == 1:
		$Name1.text = "Gary"
		$Display1.frame = 0
		$HP/HP1.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Trinkets/Trinket1.text = PartyStats.gary_trinket
	if PartyStats.gary_id == 2:
		$Name2.text = "Gary"
		$Display2.frame = 0
		$HP/HP2.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Trinkets/Trinket2.text = PartyStats.gary_trinket
	if PartyStats.gary_id == 3:
		$Name3.text = "Gary"
		$Display3.frame = 0
		$HP/HP3.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Trinkets/Trinket3.text = PartyStats.gary_trinket
	if PartyStats.gary_id == 4:
		$Name4.text = "Gary"
		$Display4.frame = 0
		$HP/HP4.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Trinkets/Trinket4.text = PartyStats.gary_trinket
	if PartyStats.gary_id == 5:
		$Name5.text = "Gary"
		$Display5.frame = 0
		$HP/HP5.text = str(PartyStats.gary_current_health) + "/" + str(PartyStats.gary_health)
		$Trinkets/Trinket5.text = PartyStats.gary_trinket
	if PartyStats.jacques_id == 1:
		$Name1.text = "Jacques"
		$Display1.frame = 1
		$HP/HP1.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Trinkets/Trinket1.text = PartyStats.jacques_trinket
	if PartyStats.jacques_id == 2:
		$Name2.text = "Jacques"
		$Display2.frame = 1
		$HP/HP2.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Trinkets/Trinket2.text = PartyStats.jacques_trinket
	if PartyStats.jacques_id == 3:
		$Name3.text = "Jacques"
		$Display3.frame = 1
		$HP/HP3.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Trinkets/Trinket3.text = PartyStats.jacques_trinket
	if PartyStats.jacques_id == 4:
		$Name4.text = "Jacques"
		$Display4.frame = 1
		$HP/HP4.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Trinkets/Trinket4.text = PartyStats.jacques_trinket
	if PartyStats.jacques_id == 5:
		$Name5.text = "Jacques"
		$Display5.frame = 1
		$HP/HP5.text = str(PartyStats.jacques_current_health) + "/" + str(PartyStats.jacques_health)
		$Trinkets/Trinket5.text = PartyStats.jacques_trinket
	if PartyStats.irina_id == 1:
		$Name1.text = "Irina"
		$Display1.frame = 2
		$HP/HP1.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Trinkets/Trinket1.text = PartyStats.irina_trinket
	if PartyStats.irina_id == 2:
		$Name2.text = "Irina"
		$Display2.frame = 2
		$HP/HP2.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Trinkets/Trinket2.text = PartyStats.irina_trinket
	if PartyStats.irina_id == 3:
		$Name3.text = "Irina"
		$Display3.frame = 2
		$HP/HP3.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Trinkets/Trinket3.text = PartyStats.irina_trinket
	if PartyStats.irina_id == 4:
		$Name4.text = "Irina"
		$Display4.frame = 2
		$HP/HP4.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Trinkets/Trinket4.text = PartyStats.irina_trinket
	if PartyStats.irina_id == 5:
		$Name5.text = "Irina"
		$Display5.frame = 2
		$HP/HP5.text = str(PartyStats.irina_current_health) + "/" + str(PartyStats.irina_health)
		$Trinkets/Trinket5.text = PartyStats.irina_trinket
	if PartyStats.suzy_id == 1:
		$Name1.text = "Suzy"
		$Display1.frame = 3
		$HP/HP1.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Trinkets/Trinket1.text = PartyStats.suzy_trinket
	if PartyStats.suzy_id == 2:
		$Name2.text = "Suzy"
		$Display2.frame = 3
		$HP/HP2.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Trinkets/Trinket2.text = PartyStats.suzy_trinket
	if PartyStats.suzy_id == 3:
		$Name3.text = "Suzy"
		$Display3.frame = 3
		$HP/HP3.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Trinkets/Trinket3.text = PartyStats.suzy_trinket
	if PartyStats.suzy_id == 4:
		$Name4.text = "Suzy"
		$Display4.frame = 3
		$HP/HP4.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Trinkets/Trinket4.text = PartyStats.suzy_trinket
	if PartyStats.suzy_id == 5:
		$Name5.text = "Suzy"
		$Display5.frame = 3
		$HP/HP5.text = str(PartyStats.suzy_current_health) + "/" + str(PartyStats.suzy_health)
		$Trinkets/Trinket5.text = PartyStats.suzy_trinket
	if PartyStats.damien_id == 1:
		$Name1.text = "Damien"
		$Display1.frame = 4
		$HP/HP1.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Trinkets/Trinket1.text = PartyStats.damien_trinket
	if PartyStats.damien_id == 2:
		$Name2.text = "Damien"
		$Display2.frame = 4
		$HP/HP2.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Trinkets/Trinket2.text = PartyStats.damien_trinket
	if PartyStats.damien_id == 3:
		$Name3.text = "Damien"
		$Display3.frame = 4
		$HP/HP3.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Trinkets/Trinket3.text = PartyStats.damien_trinket
	if PartyStats.damien_id == 4:
		$Name4.text = "Damien"
		$Display4.frame = 4
		$HP/HP4.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Trinkets/Trinket4.text = PartyStats.damien_trinket
	if PartyStats.damien_id == 5:
		$Name5.text = "Damien"
		$Display5.frame = 4
		$HP/HP5.text = str(PartyStats.damien_current_health) + "/" + str(PartyStats.damien_health)
		$Trinkets/Trinket5.text = PartyStats.damien_trinket
		

func _on_ItemInventoryBox_return_to_item():
	yield(get_tree().create_timer(0.2), "timeout")
	member_index = -1
	$Cursors.hide()
	for x in Cursors.size():
		Cursors[x].hide()
	SceneManager.transitioning = false

func _on_TrinketsInventory_return_to_trinkets():
	yield(get_tree().create_timer(0.2), "timeout")
	Cursors[member_index].hide()
	member_index = -1
	$Cursors.hide()
	for x in Cursors.size():
		Cursors[x].hide()

func _on_MemberOptionsCursor_show_stats():
	stats_active = true

func _on_MemberOptionsCursor_retread():
	stats_active = false
