extends VBoxContainer
onready var spell_list : Array = []
var spell_index : int
var spell_id : String
var spell_type : String
var magic_active = false
var spell_selected = false
var fighter_name : String
var spell_cost : int

signal go_to_Defend()
signal spell_chosen()
signal ally_spell_chosen()
signal single_enemy_spell()
signal all_enemy_spell()
signal single_ally_spell()
signal all_ally_spell()

func _ready():
	pass
	
func add_slot(spell_index):
	var spell_slot = spell_list[spell_index]
	self.add_child(spell_slot)
	
func _process(delta):
	#spell_index = clamp(spell_index, 0, spell_list.size() - 1)
	var list_max = (spell_list.size() -1)
	if Input.is_action_just_pressed("ui_down") and magic_active and spell_index < list_max and not spell_selected:
		SE.effect("Move Between")
		spell_index += 1
		get_id()
	if Input.is_action_just_pressed("ui_up") and magic_active and spell_index > 0 and not spell_selected:
		SE.effect("Move Between")
		spell_index -= 1
		get_id()
		
func _input(event):
	var list_max = (spell_list.size() -1)
	spell_type = get_spell_type()
	if Input.is_action_just_pressed("ui_down") and magic_active and spell_index == list_max and not spell_selected:
		SE.effect("Move Between")
		magic_active = false
		emit_signal("go_to_Defend")
		
	if Input.is_action_just_pressed("ui_select") and magic_active and spell_type == "single_enemy_spell" and not spell_selected and PartyStats.party_sp >= spell_cost:
		SE.effect("Select")
		PartyStats.party_sp -= spell_cost
		emit_signal("spell_chosen")
		emit_signal("single_enemy_spell")
		
	if Input.is_action_just_pressed("ui_select") and magic_active and spell_type == "all_enemy_spell" and not spell_selected and PartyStats.party_sp >= spell_cost:
		SE.effect("Select")
		PartyStats.party_sp -= spell_cost
		emit_signal("spell_chosen")
		emit_signal("all_enemy_spell")
		
	if Input.is_action_just_pressed("ui_select") and magic_active and spell_type == "single_ally_spell" and not spell_selected and PartyStats.party_sp >= spell_cost:
		SE.effect("Select")
		PartyStats.party_sp -= spell_cost
		emit_signal("ally_spell_chosen")
		emit_signal("single_ally_spell")
		
	if Input.is_action_just_pressed("ui_select") and magic_active and spell_type == "all_ally_spell" and not spell_selected and PartyStats.party_sp >= spell_cost:
		SE.effect("Select")
		PartyStats.party_sp -= spell_cost
		emit_signal("ally_spell_chosen")
		emit_signal("all_ally_spell")
		
	if Input.is_action_just_pressed("ui_select") and not spell_selected and magic_active and PartyStats.party_sp < spell_cost:
		SE.effect("Unable")
		return
		
func get_id():
	if magic_active:
		spell_id = spell_list[spell_index].get_id()
		return spell_id

func get_spell_type():
	get_id()
	if spell_id == "Earthslide" or spell_id == "Icicle" or spell_id == "Precious Beam":
		spell_type = "single_enemy_spell"
	if spell_id == "Thunderstorm" or spell_id == "Prism Snow":
		spell_type = "all_enemy_spell"
	if spell_id == "Sweet Gift":
		spell_type = "single_ally_spell"
	if spell_id == "Blossom":
		spell_type = "all_ally_spell"
	return spell_type

func _on_WorldRoot_magic_active():
	magic_active = true
	spell_selected = false
	
	for x in self.get_children():
		self.remove_child(x)
	spell_list = []
	
	if fighter_name == "gary":
		for x in range (Party.Gary_Spells.size()):
			spell_list.append(Party.Gary_Spells[x].duplicate())
	if fighter_name == "jacques":
		for x in range (Party.Jacques_Spells.size()):
			spell_list.append(Party.Jacques_Spells[x].duplicate())
	if fighter_name == "irina":
		for x in range (Party.Irina_Spells.size()):
			spell_list.append(Party.Irina_Spells[x].duplicate())
		
	for spell_index in spell_list.size():
		add_slot(spell_index)
		
	#spell_index = clamp(spell_index, 0, spell_list.size() - 1)
	spell_index = 0

func _on_WorldRoot_magic_inactive():
	magic_active = false
	
func _on_SpellList_spell_chosen():
	spell_selected = true

func _on_SpellList_ally_spell_chosen():
	spell_selected = true

func _on_Fighters_gary():
	fighter_name = "gary"

func _on_Fighters_jacques():
	fighter_name = "jacques"

func _on_Fighters_irina():
	fighter_name = "irina"

func _on_Fighters_suzy():
	fighter_name = "suzy"

func _on_Fighters_damien():
	fighter_name = "damien"
