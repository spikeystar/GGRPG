extends Node2D

onready var party_members : int
onready var party_id : int
onready var tween = $Tween
onready var Enemies = get_tree().get_root().get_node("Enemies")
var fighters : Array = []
var fighter_index : int = -1
var BB_active = false
var f_current = Node2D
var f_position : Vector2

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal fighter_index_0
signal fighter_index_1
signal fighter_index_2
signal fighters_active

func _ready():
	fighters = get_children()
	
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
		hide_cursors(fighter_index)

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and fighter_index <2 and not BB_active:
		fighter_index += 1
		switch_focus(fighter_index, fighter_index-1)
		fighter_index_0(fighter_index)
		fighter_index_1(fighter_index)
		fighter_index_2(fighter_index)
		
	if Input.is_action_just_pressed("ui_left") and fighter_index >0 and not BB_active:
		fighter_index -= 1
		switch_focus(fighter_index, fighter_index+1)
		fighter_index_0(fighter_index)
		fighter_index_1(fighter_index)
		fighter_index_2(fighter_index)
	
	if Input.is_action_just_pressed("ui_select") and BB_active:
		fighters[fighter_index].turn()
		

	
func switch_focus(x, y):
	print(fighter_index)
	fighters[x].focus()
	fighters[y].unfocus()
	
func hide_cursors(x):
	fighters[x].unfocus()
	
func fighter_index_0(fighter_index):
	if fighter_index == 0:
		emit_signal("fighter_index_0")
		emit_signal("fighters_active")
		
func fighter_index_1(fighter_index):
	if fighter_index == 1:
		emit_signal("fighter_index_1")
		emit_signal("fighters_active")
		
func fighter_index_2(fighter_index):
	if fighter_index == 2:
		emit_signal("fighter_index_2")
		emit_signal("fighters_active")
		
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

func _on_WorldRoot_flee_chosen():
	fighters[0].flee()
	fighters[1].flee()
	fighters[2].flee()
	
func get_f_current():
	var f_current = fighters[fighter_index].get_node($Fighters)
	return f_current
	
func get_f_position():
	var f_position = fighters[fighter_index].get_position($Fighters).position
	return Vector2()
	#if fighter_index == 0:
		#current_f_position = Vector2(-240, 86)
	
func fighter_attack():
	fighters[fighter_index].attack()

#func _on_Enemies_enemy_chosen():
	#var f_position = get_f_position()
	#var e_position = Enemies.get_e_position()
	#tween.tween_property(f_position, "position", e_position + Vector2(10,-10), 1)
	#yield()
	#fighters[fighter_index].attack()
	#yield()
	#tween.tween_callback(f_position.queue_free)

#func _on_Enemies_enemy_chosen():
	#var f_position = get_f_position()
	#tween.interpolate_property(f_position, "position", Vector2(100, 100), 1)
	#tween.start()
	#yield()
	#fighters[fighter_index].attack()
	#yield()
	#tween.tween_callback(f_position.queue_free)
	#var tween = get_tree().create_tween()
	#tween.tween_property($WorldRoot/TC, "position", Vector2(65, -20), 1)
