extends Node2D

onready var enemy_members : int
onready var party_id : int
onready var Fighters : Node2D
var enemies : Array = []
var enemies2 : Array = []
var enemy_index : int = -1
var BB_active = false
var enemy_selecting = false
var enemy_attacked = false
var e_position : Vector2
var is_attack = false
var attack_bonus = false
var ongoing = false
var item_selecting = false
var target_index : int
var item_damage : int

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_chosen
signal item_chosen
signal e_damage_finish
signal victory
signal attack_f_index_reset
signal jinx_doll
signal e_item_finished

func _ready():
	enemies = get_children()
	Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")
	
func _on_WorldRoot_BB_active():
	BB_active = true
	
func _on_WorldRoot_attack_active():
	enemy_selecting = true
	
func _on_WorldRoot_attack_inactive():
	enemy_selecting = false
	enemy_index = -1 
	
func select_next_enemy(index_offset):
	var last_enemy_index = enemy_index;
	var new_enemy_index = fposmod(last_enemy_index + index_offset, enemies.size())
	enemies[last_enemy_index].unfocus()
	enemies[new_enemy_index].focus()
	enemy_index = new_enemy_index
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_selecting and BB_active:
		select_next_enemy(+1)
	
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") and enemy_selecting and BB_active:
		enemy_selecting = false
	
	if Input.is_action_just_pressed("ui_select") and enemy_selecting:
		emit_signal("enemy_chosen")
		enemy_selecting = false
		
	######## Item Selecting ########
	if Input.is_action_just_pressed("ui_right") and item_selecting:
		select_next_enemy(+1)
		#print(enemy_index)
		
	if Input.is_action_just_pressed("ui_left") and item_selecting:
		select_next_enemy(-1)
		#print(enemy_index)
	
	if Input.is_action_just_pressed("ui_select") and item_selecting:
		emit_signal("jinx_doll")
		hide_cursors()
		target_index = enemy_index
		item_selecting = false
		
func hide_cursors():
		enemies[enemy_index].unfocus()
		
func show_cursors():
		enemies[enemy_index].focus()
		
func focus():
	enemies[enemy_index].focus()
		
func get_e_position():
	return enemies[enemy_index].get_position()

func _on_WorldRoot_attack_chosen():
	hide_cursors()
	is_attack = true
	attack_bonus = false

func _on_WorldRoot_hide_enemy_cursor():
	hide_cursors()
	
func _on_AttackTimer_attack_bonus():
	attack_bonus = true
	
func enemy_damage():
	BB_active = false
	randomize()
	var target_enemy = enemies[enemy_index]
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_attack = Fighters.get_f_attack()
	var f_attack_base = Fighters.get_f_attack_base()
	var f_total = f_attack + f_attack_base
	if is_attack and not attack_bonus:
		damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
		target_enemy.damage(damage)
		is_attack = false
	elif is_attack and attack_bonus:
		damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense) + 100
		target_enemy.damage(damage)
		print("success!")
		is_attack = false
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("e_damage_finish")
	target_enemy.unfocus()
	if target_enemy.is_dead():
		ongoing = true
		target_enemy.death()
		enemies.remove(enemy_index)
		enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		yield(get_tree().create_timer(1), "timeout")
		ongoing = false
	else:
		target_enemy.reset_animation()
	if enemies.size() == 0:
		emit_signal("victory")
		
func victory_check():
	#var target_enemy = enemies[enemy_index]
	#if target_enemy.is_dead():
		#target_enemy.death()
		#enemies.remove(enemy_index)
		#enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		#yield(get_tree().create_timer(1), "timeout")
	#else:
		#target_enemy.reset_animation()
	if enemies.size() == 0:
		emit_signal("victory")
		
func item_damage():
	BB_active = false
	ongoing = true
	var damage = item_damage
	var death_count = 0
	#var target_enemy = enemies[enemy_index]
	for x in range(enemies.size()):
		enemies[x].damage(damage)
	yield(get_tree().create_timer(1.5), "timeout")
	for x in range(enemies.size()):
		if enemies[x].is_dead():
			enemies[x].death()
			enemies[x].death_tagged = true
	for x in range(enemies.size() -1, -1, -1):
			var death_tagged = enemies[x].get_death_tag()
			if death_tagged == true:
				enemies.remove(x)
	enemy_index = clamp(enemy_index, 0, enemies.size())
	yield(get_tree().create_timer(0.8), "timeout")
	victory_check()
	yield(get_tree().create_timer(0.4), "timeout")
	emit_signal("e_item_finished")
	
func jinx_doll():
	pass

func enemy_attack():
	enemies[enemy_index].attack()
	
func _on_WorldRoot_action_ongoing():
	ongoing = true

func _on_WorldRoot_action_ended():
	ongoing = false

func _on_ItemInventory_battle_item_chosen():
	show_cursors()
	select_next_enemy(+1)
	yield(get_tree().create_timer(0.2), "timeout")
	item_selecting = true

func battle_item_used():
	yield(get_tree().create_timer(1.5), "timeout")
	item_damage()

func _on_ItemInventory_all_battle_item_chosen():
	hide_cursors()
	emit_signal("item_chosen")
	
	
