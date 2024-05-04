extends VBoxContainer
onready var spell_list : Array = []
var spell_index : int
var magic_active = false

signal go_to_Defend()
signal spell_chosen()
signal single_spell()
signal all_spell()

func _ready():
	spell_list = get_children()
	
func _process(delta):
	spell_index = clamp(spell_index, 0, spell_list.size() - 1)
	var list_max = (spell_list.size() -1)
	if Input.is_action_just_pressed("ui_down") and magic_active and spell_index < list_max:
		spell_index += 1
	if Input.is_action_just_pressed("ui_up") and magic_active and spell_index > 0:
		spell_index -= 1
		
func _input(event):
	var list_max = (spell_list.size() -1)
	if Input.is_action_just_pressed("ui_down") and magic_active and spell_index == list_max:
		emit_signal("go_to_Defend")
		magic_active = false
	if Input.is_action_just_pressed("ui_select") and magic_active:
		emit_signal("spell_chosen")
		magic_active = false
		
func get_id():
	pass
	#var item_id : String = inventory[item_index].get_id()
	#return item_id

func _on_WorldRoot_magic_active():
	magic_active = true
	spell_index = 0

func _on_WorldRoot_magic_inactive():
	magic_active = false
	spell_index = 0
