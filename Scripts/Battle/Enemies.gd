extends Node2D

onready var enemy_members : int
onready var party_id : int
var enemies : Array = []
var enemy_index : int = -1
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
	var enemy_amount = enemies.size()
	if enemy_index == enemy_amount - 1:
		enemy_max = true

func _process(delta):
	var enemy_amount = enemies.size()
	
	if enemy_index == enemy_amount - 1:
		enemy_max = true
		
	if Input.is_action_just_pressed("ui_right") and (enemy_index +1) < enemy_amount and enemy_selecting:
		print(enemy_index)
		print(enemy_amount)
		enemy_index += 1
		switch_focus(enemy_index, enemy_index-1)
		#if enemy_index == enemy_amount - 1:
		#	enemy_max = true
		#set_max(enemy_index)
		
	if Input.is_action_just_pressed("ui_right") and enemy_index == (enemy_amount - 1):
		enemy_index = -1
		
	if Input.is_action_just_pressed("ui_right") and enemy_amount == 1 and is_instance_valid(enemies[enemy_index]):
		focus_only(enemy_index)
		
	if Input.is_action_just_pressed("ui_right") and enemy_max and enemy_selecting:
		enemy_index = -1
		
		enemy_max = false
		
	if enemy_amount == 1:
			enemy_index = -1
			
		
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") and enemy_selecting:
		enemy_selecting = false
	
	if Input.is_action_just_pressed("ui_select") and enemy_selecting:
		emit_signal("enemy_chosen")
		enemy_selecting = false
		
func switch_focus(x, y):
	var enemy_amount = enemies.size()
	if enemy_index < enemy_amount and is_instance_valid(enemies[x]) and is_instance_valid(enemies[y]):
		enemies[x].focus()
		enemies[y].unfocus()
		
	#if enemy_amount == 1:
		#show_all(enemy_index)
		
	#if enemy_amount == enemies.size() and is_instance_valid(enemies[x]) and !is_instance_valid(enemies[y]):
		#enemies[x].focus()
	#if !is_instance_valid(enemies[x]) or !is_instance_valid(enemies[y]):
		#pass
		
	#if !is_instance_valid(enemies[y]):
		#enemies[x].focus()
		
	#if !is_instance_valid(enemies[x]):
		#enemies[y].unfocus()
	
func hide_cursors(x):
		enemies[x].unfocus()
		
func focus_only(x):
	if is_instance_valid(enemies[x]):
		enemies[x].focus()
	
	#if enemy_index == 2:
		#emit_signal("enemy_index_2")
		
func get_e_position():
	var e_position: Vector2 = enemies[enemy_index].get_position()
	return e_position
	#var e_position = enemies[enemy_index].get_node($Enemies).position
	#return e_position
	#if enemy_index == 0:
		#e_position = Vector2(190, 44)
		#return Vector2(190, 44)

func _on_WorldRoot_attack_chosen():
	hide_cursors(enemy_index)

func _on_WorldRoot_hide_enemy_cursor():
	hide_cursors(enemy_index)
	
func enemy_damage():
	var enemy_amount : int
	var e_health: int = enemies[enemy_index].health_check()
	#print(e_health)
	enemies[enemy_index].damage()
	yield(get_tree().create_timer(2), "timeout")
	if e_health <= 0:
		enemies[enemy_index].death()
		yield(get_tree().create_timer(1), "timeout")
		enemies.remove(enemy_index)
		enemy_amount = enemies.size()
		enemies.resize(enemies.size())
	else:
		enemies[enemy_index]._ready()
	
func enemy_attack():
	enemies[enemy_index].attack()
	
#func clean(enemies: Array) -> Array:
	#for item in enemies:
		#if is_instance_valid(enemies[enemy_index]):
			#enemies.append(enemy_index)
	#return enemies

