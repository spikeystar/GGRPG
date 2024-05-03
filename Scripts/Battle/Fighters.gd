extends Node2D

onready var party_members : int
onready var party_id : int
onready var tween = $Tween
onready var Enemies = get_tree().get_root().get_node("Enemies")
var fighters : Array = []
var fighter_index : int = -1
var BB_active = false
var f_current 
var f_position : Vector2
var attack_chosen = false
var max_f_turns : int = 0
var ongoing = false
var fighter_0_able = true
var fighter_1_able = true
var fighter_2_able = true

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal fighters_active
signal anim_finish
signal enemies_enabled
signal BB_move

func _ready():
	fighters = get_children()
	
func f_array_size():
	var f_array_size: int = fighters.size()
	return f_array_size
	
#func set_positions(party_id, fighter_index):
	#if Party.party_id == 0:
		#fighter_index = 0
	#	fighters[0].global_position = Vector2(-240, 86)
		
	#if Party.party_id == 1:
		#fighter_index = 1
		#fighters[1].position = Vector2(-135, 144)
		
	#if Party.party_id == 2:
		#fighter_index = 2
		#fighters[2].position = Vector2(-23, 194)
		
func _on_WorldRoot_BB_active():
		BB_active = true
		attack_chosen = false
		hide_cursors(fighter_index)
		
func select_next_fighter(index_offset):
	var last_fighter_index = fighter_index;
	var new_fighter_index = fposmod(last_fighter_index + index_offset, fighters.size())
	fighters[last_fighter_index].unfocus()
	fighters[new_fighter_index].focus()
	fighter_index = new_fighter_index

func _process(delta):
	var fighter_turn_used = fighters[fighter_index].get_turn_value()
	if Input.is_action_just_pressed("ui_right") and not BB_active and not attack_chosen and not ongoing:
		#fighter_index += 1
		#switch_focus(fighter_index, fighter_index-1)
		print(fighter_index)
		select_next_fighter(+1)
		emit_signal("fighters_active")
		
	if Input.is_action_just_pressed("ui_left") and not BB_active and not attack_chosen and not ongoing:
		#fighter_index -= 1
		#switch_focus(fighter_index, fighter_index+1)
		print(fighter_index)
		select_next_fighter(-1)
	
	if Input.is_action_just_pressed("ui_select") and BB_active and not attack_chosen and not fighter_turn_used and not ongoing:
		emit_signal("BB_move")
		fighters[fighter_index].turn()
		
func switch_focus(x, y):
	#print(fighter_index)
	fighters[x].focus()
	fighters[y].unfocus()
	
func hide_cursors(x):
	fighters[x].unfocus()
		
func get_f_name():
	var f_name = fighters[fighter_index].get_name()
	return f_name
	
func get_f_OG_position():
	var f_OG_position = fighters[fighter_index].get_OG_position()
	return f_OG_position
	
func get_BB_position():
	var BB_position = fighters[fighter_index].get_BB_position()
	return BB_position
	
#func _set_position():
	
	#if party_id == 1 and party_formation_3:
		#$PartyFormation3/Fighter1.position
		
	#if party_id == 2 and party_formation_3:
		#$PartyFormation3/Fighter2.position
		
	#if party_id == 3 and party_formation_3:
		#$PartyFormation3/Fighter3.position

#if party_members == 1:
		#party_formation_1 = true

	#if party_members == 2:
		#party_formation_2 = true

	#if party_members == 3:
		#party_formation_3 = true

func _on_WorldRoot_defend_chosen():
	fighters[fighter_index].defend()
	_on_WorldRoot_f_index_reset()
	BB_active = false

func _on_WorldRoot_flee_chosen():
	fighters = get_children()
	fighters[0].flee()
	fighters[1].flee()
	fighters[2].flee()
	
func get_f_current():
	var f_self = fighters[fighter_index].get_self()
	return f_self
	
func get_f_position():
	var f_position: Vector2 = fighters[fighter_index].get_position()
	return f_position
	
func get_f_index():
	var f_index: int = fighter_index
	return f_index
		
func fighter_attack():
	fighters[fighter_index].attack()
	emit_signal("anim_finish")
	BB_active = false

func pre_attack():
	fighters[fighter_index].pre_attack()
	
func item_used():
	fighters[fighter_index].item_used()
	_on_WorldRoot_f_index_reset()
	BB_active = false

func _on_Enemies_enemy_chosen():
	attack_chosen = true
	fighters[fighter_index].pre_attack()
	
func get_turn_value():
	var turn_value = fighters[fighter_index].get_turn_value()
	return turn_value
	
func max_f_turns():
	var array_size = fighters.size()
	if max_f_turns == array_size:
		emit_signal ("enemies_enabled")
	
func _on_WorldRoot_f_turn_used():
	fighters[fighter_index].turn_used()
	max_f_turns += 1

func _on_WorldRoot_f_index_reset():
	fighters.remove(fighter_index)
	fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
	attack_chosen = false
	ongoing = false
	fighter_index = -1
	if fighters.size() <=0:
		fighters = get_children()
	
func get_f_attack():
	var f_attack = fighters[fighter_index].get_f_attack()
	return f_attack
	
func get_f_attack_base():
	var f_attack_base = fighters[fighter_index].get_f_attack_base()
	return f_attack_base
	
func get_f_defense():
	var f_defense = fighters[fighter_index].get_f_defense()
	return f_defense

func victory():
	fighters = get_children()
	fighters[0].victory()
	fighters[1].victory()
	fighters[2].victory()


func _on_WorldRoot_action_ongoing():
	ongoing = true

func _on_WorldRoot_action_ended():
	ongoing = false

