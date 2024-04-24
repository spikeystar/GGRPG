extends Node2D

onready var enemy_members : int
onready var party_id : int
var enemies : Array = []
var enemy_index : int =  - 1
var BB_active = false
var enemy_selecting = false
var enemy_attacked = false
var enemy_max = false
var e_position : Vector2

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_chosen
#signal fighters_active

func _ready():
	enemies = get_children()
	
func _on_WorldRoot_attack_active():
	enemy_selecting = true
	
func set_max(enemy_index):
	if enemy_index == 2:
		enemy_max = true

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_index < 2 and enemy_selecting:
		print(enemy_index)
		enemy_index += 1
		switch_focus(enemy_index, enemy_index-1)
		set_max(enemy_index)
		
	if enemy_index == 2:
		enemy_max = true
		
	if Input.is_action_just_pressed("ui_right") and enemy_max and enemy_selecting:
		enemy_index = -1
		enemy_max = false
	
	if Input.is_action_just_pressed("ui_select") and enemy_selecting:
		emit_signal("enemy_chosen")
		enemy_selecting = false
		
func switch_focus(x, y):
	enemies[x].focus()
	enemies[y].unfocus()
	
func hide_cursors(x):
	enemies[x].unfocus()
	
	if enemy_index == 2:
		emit_signal("enemy_index_2")
		
func get_e_position():
	var e_position = enemies[enemy_index].get_node($Enemies).position
	return e_position
	#if enemy_index == 0:
		#current_e_position = Vector2(190, 44)

func _on_WorldRoot_attack_chosen():
	hide_cursors(enemy_index)

func _on_WorldRoot_hide_enemy_cursor():
	hide_cursors(enemy_index)
	
func enemy_damage():
	enemies[enemy_index].damage()
