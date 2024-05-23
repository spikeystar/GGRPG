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

signal member_options
signal item_usage
signal trinket_equipped

func _ready():
	Cursors = $Cursors.get_children()
	
func select_next_member(index_offset):
	var last_member_index = member_index;
	var new_member_index = fposmod(last_member_index + index_offset, Cursors.size())
	Cursors[last_member_index].hide()
	Cursors[new_member_index].show()
	member_index = new_member_index

func _process(delta):
	PartyStats.party_id = (member_index + 1)
	if Input.is_action_just_pressed("ui_right") and party_selecting:
		select_next_member(+1)
		print(member_index)
		
	if Input.is_action_just_pressed("ui_left") and party_selecting:
		select_next_member(-1)
		print(member_index)

	if Input.is_action_just_pressed("ui_select") and party_selecting and able and not switching:
		emit_signal("member_options")
		party_selecting = false
		current_id = (member_index + 1)
		selector_name = get_name()
		PartyStats.switching_id = current_id
		print(member_index)
		
	if Input.is_action_just_pressed("ui_select") and party_selecting and able and switching:
		print("switch")
		switching = false
		member_name = get_name()
		if selector_name == "gary":
			PartyStats.gary_id = PartyStats.party_id
		if selector_name == "jacques":
			PartyStats.jacques_id = PartyStats.party_id
		if selector_name == "irina":
			PartyStats.irina_id = PartyStats.party_id
		if member_name == "gary":
			PartyStats.gary_id = current_id
		if member_name == "jacques":
			PartyStats.jacques_id = current_id
		if member_name == "irina":
			PartyStats.irina_id = current_id
		print(member_index)
		
		##########
		
	if Input.is_action_just_pressed("ui_right") and item_selecting:
		select_next_member(+1)
		
	if Input.is_action_just_pressed("ui_left") and item_selecting:
		select_next_member(-1)

	if Input.is_action_just_pressed("ui_select") and item_selecting and able:
		emit_signal("item_usage")
		item_selecting = false
		able = false
		
		##############
		
	if Input.is_action_just_pressed("ui_right") and trinket_selecting:
		select_next_member(+1)
		
	if Input.is_action_just_pressed("ui_left") and trinket_selecting:
		select_next_member(-1)

	if Input.is_action_just_pressed("ui_select") and trinket_selecting and able:
		emit_signal("trinket_equipped")
		trinket_selecting = false
		able = false
		
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
	

func _on_MenuCursor_party_selecting():
	party_selecting = true
	$Cursors.show()
	yield(get_tree().create_timer(0.2), "timeout")
	able = true
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
	Cursors[member_index].hide()
	member_index = 0
	$Cursors.show()
	Cursors[member_index].show()
	trinket_selecting = true
	yield(get_tree().create_timer(0.2), "timeout")
	able = true

