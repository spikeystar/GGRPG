extends Node2D

onready var enemy_members : int
onready var party_id : int
var enemies : Array = []
var enemy_index : int = (enemies.count(enemy_members)) - (enemies.count(enemy_members)) - 1
var enemy_maxindex : int = (enemies.count(enemy_members)) -1
var BB_active = false
var enemy_selecting = false
var enemy_attacked = false
var enemy_max = false

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_index_0
signal enemy_index_1
signal enemy_index_2
signal enemy_chosen
#signal fighters_active



func _ready():
	enemies = get_children()
	
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
		
#func _on_WorldRoot_BB_active():
		#BB_active = true
		#hide_cursors(enemy_index)
		

func _on_WorldRoot_attack_active():
	enemy_selecting = true
	
func set_max(enemy_index):
	if enemy_index == enemy_maxindex:
		enemy_max = true

func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_selecting:
		print(enemy_index)
		enemy_index += 1
		set_max(enemy_index)
		switch_focus(enemy_index, enemy_index-1)
		enemy_index_0(enemy_index)
		enemy_index_1(enemy_index)
		enemy_index_2(enemy_index)
		
	if enemy_index == enemy_maxindex:
		enemy_max = true
		
	if Input.is_action_just_pressed("ui_right") and enemy_max and enemy_selecting:
		enemy_index = (enemies.count(enemy_members)) - (enemies.count(enemy_members)) - 1
		enemy_max = false
		#switch_focus(enemy_index, enemy_index+2)
		#enemy_index_0(enemy_index)
		#enemy_index_1(enemy_index)
		#enemy_index_2(enemy_index)
	
	if Input.is_action_just_pressed("ui_select") and enemy_selecting:
		emit_signal("enemy_chosen")
	
func switch_focus(x, y):
	if not enemy_max:
		enemies[x].focus()
		enemies[y].unfocus()
	

	
func hide_cursors(x):
	enemies[x].unfocus()
	
func enemy_index_0(enemy_index):
	if enemy_index == 0:
		emit_signal("enemy_index_0")
		
func enemy_index_1(enemy_index):
	if enemy_index == 1:
		emit_signal("enemy_index_1")
		
func enemy_index_2(enemy_index):
	if enemy_index == 2:
		emit_signal("enemy_index_2")

func _on_WorldRoot_attack_chosen():
	hide_cursors(enemy_index)

func _on_WorldRoot_hide_enemy_cursor():
	hide_cursors(enemy_index)
