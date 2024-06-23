extends Node2D

onready var enemy_members : int
onready var party_id : int
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
var whammy_chance
var move_type : String = "neutral"
var fighter_type : String = "neutral"

var f_attack
var f_attack_base
var f_magic
var f_magic_base
var e_attack
var e_magic

var damage_over = false

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

var stun = false
var poison = false
var stun_chance : int
var poison_chance : int

var random_debuff
var multi_debuff
var a_debuff
var m_debuff
var d_debuff

signal Basic
signal Barrage

func _ready():
	enemies = $Field.get_children()
	
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
	enemy_index = -1 
	
func _on_WorldRoot_attack_inactive():
	enemy_selecting = false
	enemy_index = -1 
	
func select_next_enemy(index_offset):
	var last_enemy_index = enemy_index;
	var new_enemy_index = fposmod(last_enemy_index + index_offset, enemies.size())
	enemies[last_enemy_index].unfocus()
	enemies[new_enemy_index].focus()
	enemy_index = new_enemy_index
	
func enemy_info_update():
	$EnemyInfo/EnemyStatus.type = enemies[enemy_index].get_type()
	$EnemyInfo/EnemyName.enemy_name = get_name()
	$EnemyInfo/EnemyStatus.stun = get_status("stun")
	$EnemyInfo/EnemyStatus.poison = get_status("poison")
	$EnemyInfo/EnemyStatus.a_buff = enemies[enemy_index].get_status("a_buff")
	$EnemyInfo/EnemyStatus.a_debuff = enemies[enemy_index].get_status("a_debuff")
	$EnemyInfo/EnemyStatus.m_buff = enemies[enemy_index].get_status("m_buff")
	$EnemyInfo/EnemyStatus.m_debuff = enemies[enemy_index].get_status("m_debuff")
	$EnemyInfo/EnemyStatus.d_buff = enemies[enemy_index].get_status("d_buff")
	$EnemyInfo/EnemyStatus.d_debuff = enemies[enemy_index].get_status("d_debuff")

	
func _process(delta):
	if Input.is_action_just_pressed("ui_right") and enemy_selecting and BB_active:
		select_next_enemy(+1)
		enemy_info_update()
	
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") and enemy_selecting and BB_active:
		enemy_selecting = false
		enemy_info_update()
	
	if Input.is_action_just_pressed("ui_select") and enemy_selecting:
		emit_signal("enemy_chosen")
		enemy_selecting = false
		
	######## Item Selecting ########
	if Input.is_action_just_pressed("ui_right") and item_selecting:
		select_next_enemy(+1)
		enemy_info_update()
		#print(enemy_index)
		
	if Input.is_action_just_pressed("ui_left") and item_selecting:
		select_next_enemy(-1)
		enemy_info_update()
		#print(enemy_index)
	
	if Input.is_action_just_pressed("ui_select") and item_selecting:
		emit_signal("jinx_doll")
		hide_cursors()
		target_index = enemy_index
		item_selecting = false
		
	####### Magic Selecting #######
	if Input.is_action_just_pressed("ui_select") and initial:
		select_next_enemy(+1)
		enemy_info_update()
	
	if Input.is_action_just_pressed("ui_right") and magic_selecting:
		select_next_enemy(+1)
		enemy_info_update()
		
	if Input.is_action_just_pressed("ui_left") and magic_selecting:
		select_next_enemy(-1)
		enemy_info_update()
	
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
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var target_enemy = enemies[enemy_index]
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_total = f_attack + f_attack_base
	var whammy = false
	var whammy_hit = rng.randi_range(1, 100)
	if whammy_hit <= whammy_chance:
		whammy = true
	
	damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
	if attack_bonus:
		damage += (damage * 0.3)
	if whammy:
		damage += damage
		target_enemy.whammy = true
	target_enemy.damage(damage)
	is_attack = false
	
	#if is_attack and not attack_bonus:
		#damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
		#target_enemy.damage(damage)
		#is_attack = false
	#elif is_attack and attack_bonus:
		#damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense) + 100
		#target_enemy.damage(damage)
		#print("success!")
		#is_attack = false

	if poison:
		target_enemy.poison()
	yield(get_tree().create_timer(1.7), "timeout")
	target_enemy.unfocus()
	if target_enemy.is_dead():
		ongoing = true
		target_enemy.death()
		enemies.remove(enemy_index)
		enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		yield(get_tree().create_timer(0.5), "timeout")
		ongoing = false
	else:
		target_enemy.reset_animation()
	if enemies.size() == 0:
		emit_signal("victory")
	emit_signal("e_damage_finish")
		
func magic_damage():
	BB_active = false
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var target_enemy = enemies[enemy_index]
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_total = f_magic + f_magic_base
	
	var enemy_type = target_enemy.get_status("type")
	var immune = false
	if enemy_type != "neutral" and enemy_type == move_type:
		immune = true
	
	var type_bonus : String = type_matchup()
	
	var whammy = false
	var whammy_hit = rng.randi_range(1, 100)
	if whammy_hit <= whammy_chance:
		whammy = true
		damage_type = "whammy"
	
	damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
	if fighter_type == move_type:
		damage += (damage * 0.2)
	if type_bonus == "adv":
		damage += (damage/2)
	if type_bonus == "dis":
		damage -= (damage/2)
	if type_bonus == "none":
		pass
	if whammy:
		damage += damage
	
	target_enemy.magic_damage(damage, damage_type)
	var dead = false
	if target_enemy.get_health() == 0:
		dead = true
	
	yield(get_tree().create_timer(1.7), "timeout")
	
	target_enemy.unfocus()
	if target_enemy.is_dead():
		ongoing = true
		target_enemy.death()
		enemies.remove(enemy_index)
		enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		yield(get_tree().create_timer(0.5), "timeout")
		ongoing = false
	else:
		target_enemy.reset_animation()
	if enemies.size() == 0:
		emit_signal("victory")
		
	if stun and not immune and not dead:
		target_enemy.stun()
	if poison and not immune and not dead:
		target_enemy.poison()
	if a_debuff and not immune and not dead:
		target_enemy.apply_debuff("attack")
	if m_debuff and not immune and not dead:
		target_enemy.apply_debuff("magic")
	if d_debuff and not immune and not dead:
		target_enemy.apply_debuff("defense")
	if random_debuff and not immune and not dead:
		target_enemy.random_debuff()
	if multi_debuff and not immune and not dead:
		target_enemy.multi_debuff()
		
		
	emit_signal("e_magic_damage_finish")
	stun = false
	poison = false
	a_debuff = false
	m_debuff = false
	d_debuff = false
	random_debuff = false
	multi_debuff = false
		
		
func all_magic_damage():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	BB_active = false
	ongoing = true
	randomize()
	var set_type = damage_type
	var f_total = f_magic + f_magic_base
	for x in range(enemies.size()):
		enemy_index = x
		var type_bonus : String = type_matchup()
		var whammy = false
		damage_type = set_type
		var whammy_hit = rng.randi_range(1, 100)
		if whammy_hit <= whammy_chance:
			whammy = true
			damage_type = "whammy"
		
		var e_defense = enemies[x].get_e_defense()
		var enemy_type = enemies[x].get_status("type")
		var immune = false
		if enemy_type != "neutral" and enemy_type == move_type:
			immune = true
		var damage : int
		damage = max(0, ((f_total) + int(f_total * (rand_range(0.05, 0.15)))) - e_defense)
		
		if fighter_type == move_type:
			damage += (damage * 0.2)
		if type_bonus == "adv":
			damage += (damage/2)
		if type_bonus == "dis":
			damage -= (damage/2)
		if type_bonus == "none":
			pass
		
		if whammy:
			damage += damage
		
		enemies[x].magic_damage(damage, damage_type)
		var dead = false
		if enemies[x].get_health() == 0:
			dead = true
		
		if stun and not immune and not dead:
			var apply = rng.randi_range(1, 100)
			if apply <= stun_chance:
				enemies[x].stun()
		if poison and not immune and not dead:
			var apply = rng.randi_range(1, 100)
			if apply <= poison_chance:
				enemies[x].poison()
		if a_debuff and not immune and not dead:
			enemies[x].apply_debuff("attack")
		if m_debuff and not immune and not dead:
			enemies[x].apply_debuff("magic")
		if d_debuff and not immune and not dead:
			enemies[x].apply_debuff("defense")
		if random_debuff and not immune and not dead:
			enemies[x].random_debuff()
		if multi_debuff and not immune and not dead:
			enemies[x].multi_random_debuff()

	yield(get_tree().create_timer(1.7), "timeout")
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
	if not SceneManager.victory:
		victory_check()
	#yield(get_tree().create_timer(0.4), "timeout")
	emit_signal("e_magic_damage_finish")
	stun = false
	poison = false
	a_debuff = false
	m_debuff = false
	d_debuff = false
	random_debuff = false
	multi_debuff = false
		
		
func type_matchup():
	var enemy_type = enemies[enemy_index].get_status("type")
	
	if move_type == "fire" and enemy_type == "fire":
		return "dis"
	if move_type == "water" and enemy_type == "water":
		return "dis"
	if move_type == "air" and enemy_type == "air":
		return "dis"
	if move_type == "earth" and enemy_type == "earth":
		return "dis"
		
	if move_type == "fire" and enemy_type == "water":
		return "adv"
	if move_type == "water" and enemy_type == "fire":
		return "adv"
	if move_type == "air" and enemy_type == "earth":
		return "adv"
	if move_type == "earth" and enemy_type == "air":
		return "adv"
		
	else:
		return "none"
		
		
func victory_check():
	if enemies.size() == 0:
		emit_signal("victory")
		
func item_damage():
	BB_active = false
	ongoing = true
	var damage = item_damage
	for x in range(enemies.size()):
		enemy_index = x
		var type_bonus : String = type_matchup()
		if type_bonus == "adv":
			damage += (damage/2)
		if type_bonus == "dis":
			damage -= (damage/2)
		if type_bonus == "none":
			pass
		
		enemies[x].damage(damage)
		if move_type != "neutral":
			enemies[x].apply_type(move_type)
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
	if not SceneManager.victory:
		victory_check()
	yield(get_tree().create_timer(0.4), "timeout")
	emit_signal("e_item_finished")
	
func jinx_doll():
	pass
	emit_signal("e_item_finished")
	multi_debuff = false

	
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
	#yield(get_tree().create_timer(0.5), "timeout")
	enemies_active = true

	for x in range (enemies.size()):
		var poisoned = enemies[x].get_status("poison")
		if poisoned:
			enemies[x].poison_damage()
	yield(get_tree().create_timer(0.3), "timeout")
	for x in range(enemies.size()):
		if enemies[x].is_dead():
			enemies[x].death()
			enemies[x].death_tagged = true
	for x in range(enemies.size() -1, -1, -1):
			var death_tagged = enemies[x].get_death_tag()
			if death_tagged == true:
				enemies.remove(x)
				enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
	yield(get_tree().create_timer(1), "timeout")
	if not SceneManager.victory:
		victory_check()
	#yield(get_tree().create_timer(0.2), "timeout")
	
	if enemies_active:
		
		for x in range(enemies.size()):
			var stun = enemies[x].get_status("stun")
			if not stun and enemies_active:
				yield(get_tree().create_timer(0.7), "timeout")
				var move_list : Array = enemies[x].move_list
				randomize()
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				move_index = rng.randi_range(0, move_list.size() - 1)
				move_name = move_list[move_index]
				enemy_turns += 1
				enemies[x].attack()
				yield(get_tree().create_timer(0.3), "timeout")
				if move_name == "Basic":
					yield(get_tree().create_timer(0.3), "timeout")
					pass
				else:
					$EnemyMove.move_name = move_name
					emit_signal("update_move_window")
					yield($EnemyMove, "move_window_done")
				e_attack = enemies[x].get_stats("e_attack")
				e_magic = enemies[x].get_stats("e_magic")
				if move_name == "Basic":
					emit_signal("Basic")
					yield(get_tree().create_timer(2), "timeout")
				if move_name == "Barrage":
					emit_signal("Barrage")
					yield(get_tree().create_timer(2), "timeout")
				enemies[x].reset_animation()
			elif stun:
				enemy_turns += 1
			enemies_active_check()
		
func enemies_active_check():
	if enemy_turns == (enemies.size()):
		enemies_active = false
		yield(get_tree().create_timer(0.2), "timeout")
		emit_signal("fighters_active")
		enemy_countdown()
		enemy_turns = 0
			
	
func enemy_countdown():
	for x in range (enemies.size()):
		enemies[x].countdown()

func _on_Fighters_game_over():
	enemies_active = false
