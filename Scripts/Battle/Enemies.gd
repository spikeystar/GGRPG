extends Node2D

onready var enemy_members : int
onready var party_id : int
onready var Fighters : Node2D
onready var EnemyMove = get_tree().get_root().get_node("WorldRoot/EnemyMove")
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
var magic_selecting = false
var initial = false
var damage_type : String
var enemies_active = false
var enemy_turns = 0
var attack_over = false
var move_index : int
var move_name : String

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_chosen
signal item_chosen
signal e_damage_finish
signal e_magic_damage_finish
signal victory
signal attack_f_index_reset
signal jinx_doll
signal e_item_finished
signal single_enemy_spell
signal all_enemy_spell
signal fighters_active
signal update_move_window

func _ready():
	enemies = get_children()
	Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")
	
func get_name():
	var enemy_name = enemies[enemy_index].get_name()
	return enemy_name
	
func get_status(parameter: String):
	var poison = enemies[enemy_index].get_status("poison")
	var stun = enemies[enemy_index].get_status("stun")
	if parameter == "poison":
		return poison
	if parameter == "stun":
		return stun
	
func get_type():
	var type: String = enemies[enemy_index].get_type()
	return type
	
	
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
		
	####### Magic Selecting #######
	if Input.is_action_just_pressed("ui_select") and initial:
		select_next_enemy(+1)
	
	if Input.is_action_just_pressed("ui_right") and magic_selecting:
		select_next_enemy(+1)
		
	if Input.is_action_just_pressed("ui_left") and magic_selecting:
		select_next_enemy(-1)
	
	if Input.is_action_just_pressed("ui_select") and magic_selecting:
		emit_signal("single_enemy_spell")
		hide_cursors()
		target_index = enemy_index
		magic_selecting = false
	
		
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
		
func magic_damage():
	BB_active = false
	randomize()
	var target_enemy = enemies[enemy_index]
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_magic = Fighters.get_f_magic()
	var f_magic_base = Fighters.get_f_magic_base()
	var f_total = f_magic + f_magic_base
	damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
	target_enemy.magic_damage(damage, damage_type)
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("e_magic_damage_finish")
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
		
		
func all_magic_damage():
	BB_active = false
	ongoing = true
	randomize()
	var f_magic = Fighters.get_f_magic()
	var f_magic_base = Fighters.get_f_magic_base()
	var f_total = f_magic + f_magic_base
	for x in range(enemies.size()):
		var e_defense = enemies[x].get_e_defense()
		var damage : int
		damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
		enemies[x].magic_damage(damage, damage_type)
	yield(get_tree().create_timer(1.5), "timeout")
	for x in range(enemies.size()):
		if enemies[x].is_dead():
			enemies[x].death()
			enemies[x].death_tagged = true
	for x in range(enemies.size() -1, -1, -1):
			var death_tagged = enemies[x].get_death_tag()
			if death_tagged == true:
				enemies.remove(x)
	enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
	yield(get_tree().create_timer(0.8), "timeout")
	victory_check()
	yield(get_tree().create_timer(0.4), "timeout")
	emit_signal("e_magic_damage_finish")
		
		
func victory_check():
	if enemies.size() == 0:
		emit_signal("victory")
		
func item_damage():
	BB_active = false
	ongoing = true
	var damage = item_damage
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
	show_cursors()
	emit_signal("item_chosen")
	
func _on_SpellList_single_enemy_spell():
	enemy_index = -1
	initial = true
	yield(get_tree().create_timer(0.2), "timeout")
	magic_selecting = true
	initial = false

func _on_SpellList_all_enemy_spell():
	emit_signal("all_enemy_spell")

func _on_Fighters_enemies_enabled():
	yield(get_tree().create_timer(0.5), "timeout")
	enemies_active = true
	
	if enemies_active:
		for x in range(enemies.size()):
			var move_list : Array = enemies[x].move_list
			randomize()
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			move_index = rng.randi_range(0, move_list.size() - 1)
			move_name = move_list[move_index]
			enemy_turns += 1
			enemies[x].attack()
			yield(get_tree().create_timer(0.3), "timeout")
			emit_signal("update_move_window")
			yield(EnemyMove, "move_window_done")
			Fighters.e_attack = enemies[x].get_stats("e_attack")
			Fighters.e_magic = enemies[x].get_stats("e_magic")
			if move_name == "Basic":
				Basic()
			if move_name == "Barrage":
				Barrage()
			yield(Fighters, "fighter_damage_over")
			enemies[x].reset_animation()
			enemies_active_check()
		
func enemies_active_check():
	if enemy_turns == (enemies.size()):
		enemies_active = false
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("fighters_active")
		enemy_turns = 0
		
	
###### Enemy Attacks #######
func Basic():
	Fighters.move_kind = "attack"
	Fighters.move_type = "neutral"
	Fighters.move_spread = "single"
	Fighters.e_move_base = 1
	Fighters.damage()


func Barrage():
	Fighters.move_kind = "attack"
	Fighters.move_type = "neutral"
	Fighters.move_spread = "all"
	Fighters.e_move_base = 10
	#Fighters.status_afflcited()
	for x in range(Fighters.fighters2.size()):
		Fighters.fighter_x = x
		Fighters.damage()
		

