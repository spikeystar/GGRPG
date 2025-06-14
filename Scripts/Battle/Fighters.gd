extends Node2D

onready var party_members : int
onready var tween = $Tween
var fighters : Array = []
var fighters2 : Array = []
var fighter_index : int = -1
var BB_active = false
var f_current 
var f_position : Vector2
var attack_chosen = false
var max_turns : int = 0
var ongoing = false
var fighter_0_able = true
var fighter_1_able = true
var fighter_2_able = true
var item_selecting = false
var selector_index : int
var target_index : int
#var fighter_turn_used = false
var fighters_active = false
var enemies_active = false
var enemy_item = false
var magic_selecting = false
var HP_amount : int
var SP_amount : int
var item_name : String
var health : int
var f_health : int

var heal = false
var SP = false
var combo_heal
var restore = false
var strange = false
var perfect = false
var all_heal = false
var all_restore = false
var remedy_b = false
var perfect_p = false
var revive = false
var party_id : int
var halt = false

var e_attack : int
var e_magic : int
var e_move_base : int = 0
var move_type : String
var move_spread : String
var move_kind : String
var fighter_name : String
var fighter_x : int

var stun = false
var poison = false
var wimpy = false
var dizzy = false
var item_halt = false
var targeted = false
var anxious = false
var apply_type = false
var changing_type : String
var enemy_type : String
var sp_loss = false

var a_debuff = false
var m_debuff = false
var d_debuff = false
var random_debuff = false
var multi_debuff = false


signal fighters_active
signal anim_finish
signal enemies_enabled
signal BB_move
signal item_chosen
signal ally_spell_chosen
signal fighter_damage_over
signal gary
signal jacques
signal irina
signal suzy
signal damien
signal game_over
var game_over = false

func _ready():
	#fighters = get_children()
	set_positions()
	fighters2 = fighters.duplicate()
	#show_cursors(fighter_index)
	for x in range (fighters.size()):
		fighter_index = x
		huds_update()
	yield(get_tree().create_timer(1), "timeout")
	fighters_active = true
	emit_signal("fighters_active")
	select_next_fighter(+1)

	
func f_array_size():
	var f_array_size: int = fighters.size()
	return f_array_size
	
func set_positions():
	if PartyStats.party_members == 1:
		if PartyStats.gary_id == 1:
			fighters.append($Gary_Battle)
			fighters[0].position = Vector2(-138, 136)
			
	if PartyStats.party_members == 2:
		if PartyStats.gary_id == 1:
			fighters.append($Gary_Battle)
			fighters[0].position = Vector2(-199, 112)
			
		if PartyStats.jacques_id == 1:
			fighters.append($Jacques_Battle)
			fighters[0].position = Vector2(-199, 112)
			
		if PartyStats.gary_id == 2:
			fighters.append($Gary_Battle)
			fighters[1].position = Vector2(-86, 168)
			
		if PartyStats.jacques_id == 2:
			fighters.append($Jacques_Battle)
			fighters[1].position = Vector2(-86, 168)
		
	
	if PartyStats.party_members == 3:
		if PartyStats.gary_id == 1:
			fighters.append($Gary_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.jacques_id == 1:
			fighters.append($Jacques_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.irina_id == 1:
			fighters.append($Irina_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.gary_id == 2:
			fighters.append($Gary_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.jacques_id == 2:
			fighters.append($Jacques_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.irina_id == 2:
			fighters.append($Irina_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.gary_id == 3:
			fighters.append($Gary_Battle)
			fighters[2].position = Vector2(-23, 194)
		
		if PartyStats.jacques_id == 3:
			fighters.append($Jacques_Battle)
			fighters[2].position = Vector2(-23, 194)
		
		if PartyStats.irina_id == 3:
			fighters.append($Irina_Battle)
			fighters[2].position = Vector2(-23, 194)
			
	if PartyStats.party_members >= 3:
		if PartyStats.gary_id == 1:
			fighters.append($Gary_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.jacques_id == 1:
			fighters.append($Jacques_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.irina_id == 1:
			fighters.append($Irina_Battle)
			fighters[0].position = Vector2(-240, 86)
			
		if PartyStats.suzy_id == 1:
			fighters.append($Suzy_Battle)
			fighters[0].position = Vector2(-240, 86)
			
		if PartyStats.damien_id == 1:
			fighters.append($Damien_Battle)
			fighters[0].position = Vector2(-240, 86)
		
		if PartyStats.gary_id == 2:
			fighters.append($Gary_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.jacques_id == 2:
			fighters.append($Jacques_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.irina_id == 2:
			fighters.append($Irina_Battle)
			fighters[1].position = Vector2(-135, 144)
			
		if PartyStats.suzy_id == 2:
			fighters.append($Suzy_Battle)
			fighters[1].position = Vector2(-135, 144)
			
		if PartyStats.damien_id == 2:
			fighters.append($Damien_Battle)
			fighters[1].position = Vector2(-135, 144)
		
		if PartyStats.gary_id == 3:
			fighters.append($Gary_Battle)
			fighters[2].position = Vector2(-23, 194)
		
		if PartyStats.jacques_id == 3:
			fighters.append($Jacques_Battle)
			fighters[2].position = Vector2(-23, 194)
		
		if PartyStats.irina_id == 3:
			fighters.append($Irina_Battle)
			fighters[2].position = Vector2(-23, 194)
			
		if PartyStats.suzy_id == 3:
			fighters.append($Suzy_Battle)
			fighters[2].position = Vector2(-23, 194)
			
		if PartyStats.damien_id == 3:
			fighters.append($Damien_Battle)
			fighters[2].position = Vector2(-23, 194)
			
		if PartyStats.gary_id == 4 or PartyStats.gary_id == 5:
			$Gary_Battle.queue_free()
			
		if PartyStats.jacques_id == 4 or PartyStats.jacques_id == 5:
			$Jacques_Battle.hide()
			
		if PartyStats.irina_id == 4 or PartyStats.irina_id == 5:
			$Irina_Battle.hide()
			
		if PartyStats.suzy_id == 4 or PartyStats.suzy_id == 5:
			$Suzy_Battle.hide()
			
		if PartyStats.damien_id == 4 or PartyStats.damien_id == 5:
			$Damien_Battle.hide()
		
		
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
	
func select_next_fighter2(index_offset):
	var last_fighter_index = fighter_index;
	var new_fighter_index : int
	new_fighter_index = fposmod(last_fighter_index + index_offset, fighters2.size())
	fighters2[last_fighter_index].unfocus()
	fighters2[new_fighter_index].focus()
	fighter_index = new_fighter_index

func _process(delta):
	#if SceneManager.victory:
		#for x in fighters2.size():
			#fighters2[x].unfocus()
	
	if Input.is_action_just_pressed("ui_right") and not BB_active and not attack_chosen and not ongoing and not item_selecting and not enemies_active and not enemy_item and not magic_selecting and not halt and fighters_active and not SceneManager.enemy_turn:
		#print(fighter_index)
		select_next_fighter(+1)
		if fighters.size() >1:
			SE.effect("Move Between")
		else:
			pass
			
		
		#fighters_active = true
		#emit_signal("fighters_active")
		
	if Input.is_action_just_pressed("ui_left") and not BB_active and not attack_chosen and not ongoing and fighters_active and not item_selecting and not enemies_active and not enemy_item and not magic_selecting and not halt:
		print(fighter_index)
		select_next_fighter(-1)
		if fighters.size() >1:
			SE.effect("Move Between")
		else:
			pass
	
	if Input.is_action_just_pressed("ui_select") and BB_active and not attack_chosen and not ongoing and fighters_active and not item_selecting and not enemies_active and not enemy_item and not magic_selecting and not halt:
		emit_signal("BB_move")
		fighters[fighter_index].turn()
		hide_all_cursors()
		fighters_active = false
		fighter_name = get_f_name()
		if fighter_name == "gary":
			$AttackTimer.fighter_name = "gary"
			emit_signal("gary")
		if fighter_name == "jacques":
			$AttackTimer.fighter_name = "jacques"
			emit_signal("jacques")
		if fighter_name == "irina":
			$AttackTimer.fighter_name = "irina"
			emit_signal("irina")
		if fighter_name == "suzy":
			$AttackTimer.fighter_name = "suzy"
			emit_signal("suzy")
		if fighter_name == "damien":
			$AttackTimer.fighter_name = "damien"
			emit_signal("damien")
		
		####### Item Selection ##########
		
	if Input.is_action_just_pressed("ui_right") and item_selecting and not attack_chosen and not magic_selecting and not halt:
		select_next_fighter2(+1)
		emit_signal("fighters_active")
		print(fighter_index)
		
		if fighters2.size() > 1:
			SE.effect("Move Between")
		
	if Input.is_action_just_pressed("ui_left") and item_selecting and not attack_chosen and not magic_selecting and not halt:
		select_next_fighter2(-1)
		print(fighter_index)
		
		if fighters2.size() > 1:
			SE.effect("Move Between")
	
	if Input.is_action_just_pressed("ui_select") and item_selecting and not attack_chosen and not magic_selecting and not halt:
		SE.effect("Select")
		emit_signal("item_chosen")
		hide_cursors2(fighter_index)
		target_index = fighter_index
		item_selecting = false
		
		######### Magic Selection ##########
		
	if Input.is_action_just_pressed("ui_right") and magic_selecting and not attack_chosen and not item_selecting and not halt:
		select_next_fighter2(+1)
		emit_signal("fighters_active")
		print(fighter_index)
		
		if fighters2.size() > 1:
			SE.effect("Move Between")
		
	if Input.is_action_just_pressed("ui_left") and magic_selecting and not attack_chosen and not item_selecting and not halt:
		select_next_fighter2(-1)
		print(fighter_index)
		
		if fighters2.size() > 1:
			SE.effect("Move Between")
	
	if Input.is_action_just_pressed("ui_select") and magic_selecting and not attack_chosen and not item_selecting and not halt:
		SE.effect("Select")
		emit_signal("ally_spell_chosen")
		hide_cursors2(fighter_index)
		target_index = fighter_index
		magic_selecting = false
		
		
func switch_focus(x, y):
	fighters[x].focus()
	fighters[y].unfocus()
	
func hide_cursors(x):
	fighters[x].unfocus()
	
func show_cursors(x):
	fighters[x].focus()
	
func show_cursors2(x):
	fighters2[x].focus()
	
func show_cursors_remote():
	fighters[fighter_index].focus()
	
func hide_cursors2(x):
	fighters2[x].unfocus()

func hide_all_cursors():
	for x in range (fighters2.size()):
		fighters2[x].unfocus()
	
func hide_cursors_remote():
	#fighters = get_children()
	for x in range (fighters2.size()):
		fighters2[x].unfocus()
		
func get_f_name():
	var f_name = fighters[fighter_index].get_name()
	return f_name
	
func get_status(id : String):
	if id == "whammy_chance":
		var whammy_chance = fighters[fighter_index].get_status("whammy_chance")
		return whammy_chance
	if id == "type":
		var type = fighters[fighter_index].get_status("type")
		return type

func get_health():
	var health = fighters[fighter_index].get_health()
	return health
	
func get_f_health():
	var f_health = fighters[fighter_index].get_f_health()
	return f_health
	
func get_health_heal():
	var health = fighters2[target_index].get_health()
	return health
	
func get_f_health_heal():
	var f_health = fighters2[target_index].get_f_health()
	return f_health
		
func get_party_id():
	var party_id = fighters[fighter_index].get_id()
	return party_id
	
func get_f_OG_position():
	var f_OG_position = fighters[fighter_index].get_OG_position()
	return f_OG_position
	
func get_BB_position():
	var BB_position = fighters[fighter_index].get_BB_position()
	return BB_position
	
func get_wimpy():
	var wimpy = fighters[fighter_index].get_status("wimpy")
	return wimpy
	
func get_dizzy():
	var dizzy = fighters[fighter_index].get_status("dizzy")
	return dizzy

func _on_WorldRoot_defend_chosen():
	fighters[fighter_index].defend()
	_on_WorldRoot_f_index_reset()
	BB_active = false

func _on_WorldRoot_flee_chosen():
	#fighters = get_children()
	#set_positions()
	for x in range (fighters2.size()):
		fighters2[x].flee()
	
func get_f_current():
	var f_self = fighters[fighter_index].get_self()
	return f_self
	
func get_f_position():
	var f_position: Vector2 = fighters[fighter_index].get_position()
	return f_position
	
func get_f_index():
	var f_index: int = fighter_index
	return f_index
	
func reset_status():
	stun = false
	poison = false
	wimpy = false
	dizzy = false
	targeted = false
	anxious = false
	a_debuff = false
	m_debuff = false
	d_debuff = false
	random_debuff = false
	multi_debuff = false
	apply_type = false
	changing_type = "neutral"
	sp_loss = false
	e_move_base = 0
	
func pick_fighter():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if move_spread == "single":
		var targeted = false
		var target_index
		for x in range (fighters.size()):
			targeted = fighters[x].get_status("targeted")
			if targeted:
				target_index = x
		if targeted:
			fighter_index = target_index
		else:
			fighter_index = rng.randi_range(0, fighters.size() - 1)
	
func damage():
	var immune = false
	#randomize()
	var damage : int
	#var rng = RandomNumberGenerator.new()
	#rng.randomize()
	#if move_spread == "single":
		#var targeted = false
		#var target_index
		#for x in range (fighters.size()):
		#	targeted = fighters[x].get_status("targeted")
		#	if targeted:
		#		target_index = x
		#if targeted:
		#	fighter_index = target_index
		#else:
		#	fighter_index = rng.randi_range(0, fighters.size() - 1)
	#else:
		#fighter_index = fighter_x
		
	#if move_spread == "spread":
		#for x in range (fighters.size()):
			#fighter_index = x
	#else:
		#pass
		
	var f_defense = fighters[fighter_index].get_f_defense()
	var fighter_type = fighters[fighter_index].get_status("type")
	if fighter_type != "neutral" and fighter_type == move_type:
		immune = true
	var type_bonus : String = type_matchup()
	
	if move_kind == "attack":
		var total = e_attack + e_move_base
		damage = max(0, ((total) + int(total * (rand_range(0.05, 0.15)))) - f_defense)
	elif move_kind == "magic":
		var total = e_magic + e_move_base
		damage = max(0, ((total) + int(total * (rand_range(0.05, 0.15)))) - f_defense)
		
	if enemy_type == move_type:
		damage += (damage * 0.1)
	if type_bonus == "adv":
		damage += (damage/2)
	if type_bonus == "dis":
		damage -= (damage/2)
	if type_bonus == "none":
		pass
		
	if damage == 0:
		immune = true
		
	fighters[fighter_index].damage(damage, move_type)
	var is_dead = false
	if fighters[fighter_index].get_health() == 0:
		is_dead = true
	
	if apply_type and not is_dead:
		fighters[fighter_index].apply_type(move_type)
	if stun and not immune and not is_dead:
		fighters[fighter_index].stun()
	if poison and not immune and not is_dead:
		fighters[fighter_index].poison()
	if targeted and not immune and not is_dead:
		fighters[fighter_index].targeted()
	if wimpy and not immune and not is_dead:
		fighters[fighter_index].wimpy()
	if dizzy and not immune and not is_dead:
		fighters[fighter_index].dizzy()
	if a_debuff and not immune and not is_dead:
		fighters[fighter_index].apply_debuff("attack")
	if m_debuff and not immune and not is_dead:
		fighters[fighter_index].apply_debuff("magic")
	if d_debuff and not immune and not is_dead:
		fighters[fighter_index].apply_debuff("defense")
	if random_debuff and not immune and not is_dead:
		fighters[fighter_index].random_debuff()
	if multi_debuff and not immune and not is_dead:
		fighters[fighter_index].multi_debuff()
	if anxious and not immune and not is_dead:
		fighters[fighter_index].anxious()
	if sp_loss and not immune:
		fighters[fighter_index].SP_loss(SP_amount)
	if move_spread == "single":
		yield(get_tree().create_timer(1.7), "timeout")
		damage_end()
	else:
		huds_update()
		reset_status()
	
func damage_end():
	huds_update()
	for x in range (fighters.size() -1, -1, -1):
		var dead = fighters[x].death_count()
		if dead:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
	reset_status()
	game_over_check()
	emit_signal("fighter_damage_over")
	
func type_matchup():
	var fighter_type = fighters[fighter_index].get_status("type")
	
	if move_type == "fire" and fighter_type == "fire":
		return "dis"
	if move_type == "water" and fighter_type == "water":
		return "dis"
	if move_type == "air" and fighter_type == "air":
		return "dis"
	if move_type == "earth" and fighter_type == "earth":
		return "dis"
		
	if move_type == "fire" and fighter_type == "water":
		return "adv"
	if move_type == "water" and fighter_type == "fire":
		return "adv"
	if move_type == "air" and fighter_type == "earth":
		return "adv"
	if move_type == "earth" and fighter_type == "air":
		return "adv"
		
	else:
		return "none"
	
func huds_update():
	fighter_name = fighters[fighter_index].get_name()
	health = get_health()
	f_health = get_f_health()
	$HUDS.stun = fighters[fighter_index].get_status("stun")
	$HUDS.poison = fighters[fighter_index].get_status("poison")
	$HUDS.anxious = fighters[fighter_index].get_status("anxious")
	$HUDS.wimpy = fighters[fighter_index].get_status("wimpy")
	$HUDS.dizzy = fighters[fighter_index].get_status("dizzy")
	$HUDS.targeted = fighters[fighter_index].get_status("targeted")
	$HUDS.a_buff = fighters[fighter_index].get_status("a_buff")
	$HUDS.a_debuff = fighters[fighter_index].get_status("a_debuff")
	$HUDS.m_buff = fighters[fighter_index].get_status("m_buff")
	$HUDS.m_debuff = fighters[fighter_index].get_status("m_debuff")
	$HUDS.d_buff = fighters[fighter_index].get_status("d_buff")
	$HUDS.d_debuff = fighters[fighter_index].get_status("d_debuff")
	$HUDS.current_type = fighters[fighter_index].get_status("type")
	
	$HUDS.health = health
	$HUDS.f_health = f_health
	if fighter_name == "gary":
		$HUDS.gary_update()
	if fighter_name == "jacques":
		$HUDS.jacques_update()
	if fighter_name == "irina":
		$HUDS.irina_update()
	if fighter_name == "suzy":
		$HUDS.suzy_update()
	if fighter_name == "damien":
		$HUDS.damien_update()
	
func huds_heal_update():
	fighter_name = fighters2[target_index].get_name()
	health = get_health_heal()
	f_health = get_f_health_heal()
	$HUDS.stun = fighters2[target_index].get_status("stun")
	$HUDS.poison = fighters2[target_index].get_status("poison")
	$HUDS.anxious = fighters2[target_index].get_status("anxious")
	$HUDS.wimpy = fighters2[target_index].get_status("wimpy")
	$HUDS.dizzy = fighters2[target_index].get_status("dizzy")
	$HUDS.targeted = fighters2[target_index].get_status("targeted")
	$HUDS.a_buff = fighters2[target_index].get_status("a_buff")
	$HUDS.a_debuff = fighters2[target_index].get_status("a_debuff")
	$HUDS.m_buff = fighters2[target_index].get_status("m_buff")
	$HUDS.m_debuff = fighters2[target_index].get_status("m_debuff")
	$HUDS.d_buff = fighters2[target_index].get_status("d_buff")
	$HUDS.d_debuff = fighters2[target_index].get_status("d_debuff")
	$HUDS.current_type = fighters2[target_index].get_status("type")
	$HUDS.health = health
	$HUDS.f_health = f_health
	if fighter_name == "gary":
		$HUDS.gary_update()
	if fighter_name == "jacques":
		$HUDS.jacques_update()
	if fighter_name == "irina":
		$HUDS.irina_update()
	if fighter_name == "suzy":
		$HUDS.suzy_update()
	if fighter_name == "damien":
		$HUDS.damien_update()
		
		
func all_heal_update():
	$HUDS.stun = fighters2[fighter_index].get_status("stun")
	$HUDS.poison = fighters2[fighter_index].get_status("poison")
	$HUDS.anxious = fighters2[fighter_index].get_status("anxious")
	$HUDS.wimpy = fighters2[fighter_index].get_status("wimpy")
	$HUDS.dizzy = fighters2[fighter_index].get_status("dizzy")
	$HUDS.targeted = fighters2[fighter_index].get_status("targeted")
	$HUDS.a_buff = fighters2[fighter_index].get_status("a_buff")
	$HUDS.a_debuff = fighters2[fighter_index].get_status("a_debuff")
	$HUDS.m_buff = fighters2[fighter_index].get_status("m_buff")
	$HUDS.m_debuff = fighters2[fighter_index].get_status("m_debuff")
	$HUDS.d_buff = fighters2[fighter_index].get_status("d_buff")
	$HUDS.d_debuff = fighters2[fighter_index].get_status("d_debuff")
	$HUDS.current_type = fighters2[fighter_index].get_status("type")
	
	if fighter_name == "gary":
		$HUDS.gary_update()
	if fighter_name == "jacques":
		$HUDS.jacques_update()
	if fighter_name == "irina":
		$HUDS.irina_update()
	if fighter_name == "suzy":
		$HUDS.suzy_update()
	if fighter_name == "damien":
		$HUDS.damien_update()
		
func fighter_attack():
	fighters[fighter_index].attack()
	emit_signal("anim_finish")
	BB_active = false

func sp_recovery():
	var amount = 2
	fighters[fighter_index].weapon_SP(amount)

func pre_attack():
	fighters[fighter_index].pre_attack()

func _on_Enemies_enemy_chosen():
	attack_chosen = true
	fighters[fighter_index].pre_attack()
	
func get_turn_value():
	if not item_selecting and fighters_active:
		var turn_value = fighters[fighter_index].get_turn_value()
		return turn_value
	
func _on_WorldRoot_f_turn_used():
	#var array_size = fighters2.size()
	fighters[fighter_index].turn_used()
	max_turns += 1

func f_turn_used():
	#var array_size = fighters2.size()
	fighters[selector_index].turn_used()
	max_turns += 1
	
func fighters_active_check():	
	var array_size = fighters2.size()
	
	print("max_turns")
	print(max_turns)
	print("size")
	print(fighters2.size())
	
#	for x in range (fighters2.size()):
	#	var dead = fighters2[x].death_count()
	#	if dead:
	#		array_size - 1
	#for x in range (fighters2.size()):
	#	var stun = fighters2[x].get_status("stun")
	#	if stun:
	#		array_size - 1
			
	#^Testing out from restor bugs
	########
			
	#for x in range (fighters2.size()):
		#var turn_used = fighters2[x].get_turn_value()
		#if turn_used:
			#array_size - 1
			
	#if max_turns == array_size:
	if max_turns == array_size:
		emit_signal ("enemies_enabled")
		enemies_active = true
	else:
		if not SceneManager.victory and not SceneManager.game_over:
			yield(get_tree().create_timer(0.8), "timeout")
			fighters_active = true
			emit_signal("fighters_active")
			select_next_fighter(+1)

func _on_WorldRoot_f_index_reset():
	fighters.remove(fighter_index)
	fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
	attack_chosen = false
	#ongoing = false
	#fighter_index = -1
	if fighters.size() <=0:
		set_positions()
		#fighters2 = fighters.duplicate()
		for x in range (fighters.size() -1, -1, -1):
			var dead = fighters[x].death_count()
			if dead:
				fighters.remove(x)
				fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
				max_turns += 1
	fighter_index = -1
		#fighters = get_children()

func get_f_attack():
	var f_attack = fighters[fighter_index].get_f_attack()
	return f_attack
	
func get_f_magic():
	var f_magic = fighters[fighter_index].get_f_magic()
	return f_magic
	
func get_f_magic_base():
	var f_magic_base = fighters[fighter_index].get_f_magic_base()
	return f_magic_base
	
func get_f_attack_base():
	var f_attack_base = fighters[fighter_index].get_f_attack_base()
	return f_attack_base
	
func get_f_defense():
	var f_defense = fighters[fighter_index].get_f_defense()
	return f_defense
	
func idle():
	fighters[fighter_index].idle()

func victory():
	#fighters = get_children()
	for x in range(fighters2.size()):
		fighters2[x].victory()
		
func game_over_check():
	var death_count = 0
	for x in range(fighters2.size()):
		var dead = fighters2[x].death_count()
		if dead:
			death_count += 1
	if death_count == fighters2.size() and not game_over:
		game_over = true
		SceneManager.game_over = true
		emit_signal("game_over")
		

func _on_WorldRoot_action_ongoing():
	ongoing = true

func _on_WorldRoot_action_ended():
	yield(get_tree().create_timer(0.3), "timeout")
	ongoing = false
	#fighter_index = -1

func _on_ItemInventory_heal_item_chosen():
	print(fighter_index)
	selector_index = fighter_index
	fighters[fighter_index].idle()
	yield(get_tree().create_timer(0.15), "timeout")
	item_selecting = true
	hide_all_cursors()
	fighter_index = -1
	(select_next_fighter2(+1))
	
func _on_ItemInventory_all_heal_item_chosen():
	hide_cursors(fighter_index)
	selector_index = fighter_index
	target_index = selector_index
	fighters[fighter_index].idle()
	emit_signal("item_chosen")

func get_selector_position():
	var f_position: Vector2 = fighters[selector_index].get_position()
	return f_position
	
func get_target_position():
	var f_position: Vector2 = fighters2[target_index].get_position()
	return f_position

func item_used():
	var turn_used = true
	var dead = false
	var stun = false
	f_turn_used()
	fighters[selector_index].item_used()
	yield(get_tree().create_timer(0.5), "timeout")
	if remedy_b:
		Remedy_Bouquet()
	if perfect_p:
		Perfect_Panacea()
	if heal:
		fighters2[target_index].heal(HP_amount)
		fighter_name = fighters2[target_index].get_name()
		#health = fighters2[target_index].get_health()
		#f_health = fighters2[target_index].get_f_health()
		huds_heal_update()
	if SP:
		fighters[selector_index].SP(SP_amount)
	if combo_heal:
		fighter_name = fighters2[target_index].get_name()
		fighters2[target_index].heal(HP_amount)
		fighters2[target_index].combo_heal(SP_amount)
		huds_heal_update()
	if all_heal:
		for x in range(fighters2.size()):
			fighters2[x].heal(HP_amount)
			fighter_name = fighters2[x].get_name()
			health = fighters2[x].get_health()
			f_health = fighters2[x].get_f_health()
			$HUDS.health = health
			$HUDS.f_health = f_health
			fighter_index = x
			all_heal_update()
			#fighters2[x].huds_update_heal()
	if restore:
		if revive:
			dead = fighters2[target_index].death_count()
#			stun = fighters2[target_index].get_status("stun")
#			if dead and stun:
#				max_turns -= 1
			if dead:
				#max_turns -=1
				fighters2[target_index].restore(item_name)
				yield(get_tree().create_timer(0.25), "timeout")
				huds_heal_update()
				for x in range (fighters2.size() -1, -1, -1):
					fighters.remove(x)
				set_positions()
				for x in range (fighters2.size() -1, -1, -1):
					turn_used = fighters2[x].get_turn_value()
					if turn_used:
						fighters.remove(x)
						fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
					else: 
						pass
				huds_heal_update()
			elif not dead:
				fighters2[target_index].restore(item_name)
				pass
		else:
			fighter_name = fighters2[target_index].get_name()
			stun = fighters2[target_index].get_status("stun")
			if stun:
				fighters2[target_index].restore(item_name)
				#huds_heal_update()
				yield(get_tree().create_timer(0.25), "timeout")
				stun_healing()
			else: 
				fighters2[target_index].restore(item_name)
				yield(get_tree().create_timer(0.25), "timeout")
				huds_heal_update()
	fighter_index = selector_index
	if not revive and not stun and not remedy_b and not perfect_p:
		_on_WorldRoot_f_index_reset()
	elif not dead and not stun and not remedy_b and not perfect_p:
		_on_WorldRoot_f_index_reset()
	#if heal:
		#_on_WorldRoot_f_index_reset()
	#if SP:
		#_on_WorldRoot_f_index_reset()
	#if strange:
		#_on_WorldRoot_f_index_reset()
	#if combo_heal:
		#_on_WorldRoot_f_index_reset()
	#if all_heal:
		#_on_WorldRoot_f_index_reset()
	elif stun:
		fighter_index = -1
	else:
		fighter_index = -1
	BB_active = false
	heal = false
	SP = false
	combo_heal = false
	restore = false
	revive = false
	strange = false
	perfect = false
	all_heal = false
	all_restore = false
	remedy_b = false
	perfect_p = false
	item_selecting = false
	#yield(get_tree().create_timer(0.3), "timeout")
	yield(get_tree().create_timer(1), "timeout")
	fighters_active_check()

func buff(id : String):
	fighters2[target_index].apply_buff(id)
	
func random_buff():
	fighters2[target_index].random_buff()

func _on_ItemInventory_battle_item_chosen():
	selector_index = fighter_index
	item_selecting = false
	enemy_item = true

func _on_ItemInventory_all_battle_item_chosen():
	selector_index = fighter_index
	item_selecting = false
	enemy_item = true

func battle_item_used():
	f_turn_used()
	fighters[selector_index].item_used()
	yield(get_tree().create_timer(0.5), "timeout")
	fighter_index = selector_index
	_on_WorldRoot_f_index_reset()
	BB_active = false
	item_selecting = false
	enemy_item = false

func _on_SpellList_single_ally_spell():
	selector_index = fighter_index
	fighters[fighter_index].idle()
	yield(get_tree().create_timer(0.2), "timeout")
	magic_selecting = true
	hide_all_cursors()
	fighter_index = -1
	(select_next_fighter2(+1))
	
func _on_SpellList_all_ally_spell():
	selector_index = fighter_index
	fighters[fighter_index].idle()
	magic_selecting = false
	emit_signal("ally_spell_chosen")
	
func _on_Enemies_fighters_active():
	#max_turns = 0
	yield(get_tree().create_timer(0.3), "timeout")
	for x in range (fighters.size() -1, -1, -1):
		var dead = fighters[x].death_count()
		if dead:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
	yield(get_tree().create_timer(0.3), "timeout")
	game_over_check()
	
	var poison_check = false
	for x in range (fighters.size()):
		var is_poisoned = fighters[x].get_status("poison")
		if is_poisoned and not poison_check:
			poison_check = true
			yield(get_tree().create_timer(1), "timeout")
	for y in range (fighters.size()):
		var poisoned = fighters[y].get_status("poison")
		if poisoned:
			fighters[y].poison_damage()
			fighter_index = y
			huds_update()
			
			#for z in range (fighters.size() -1, -1, -1):
				#var dead = fighters[z].death_count()
				#if dead:
				#	fighters.remove(z)
				#	fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
			#yield(get_tree().create_timer(0.3), "timeout")
			#game_over_check()
			
	var sd_check = false
	for a in range (fighters.size()):
		var is_sd = fighters[a].get_status("stored_damage")
		if is_sd and not sd_check:
			sd_check = true
			yield(get_tree().create_timer(1), "timeout")
	for z in range (fighters.size()):
		var stored_damage = fighters[z].get_status("stored_damage")
		if stored_damage:
			fighters[z].stored_damage()
			fighter_index = z
			huds_update()
	
	max_turns = 0
	for x in range (fighters2.size()):
		fighters2[x].turn_restored()
	for x in range (fighters.size()):
		fighter_index = x
		huds_update()
			
			
	for x in range (fighters.size() -1, -1, -1):
		var dead = fighters[x].death_count()
		if dead:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
			#max_turns += 1
			
	for x in range (fighters.size() -1, -1, -1):
		var stun = fighters[x].get_status("stun")
		if stun:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
			max_turns += 1
			
	enemies_active = false
	fighter_index = -1
	
	if max_turns == fighters2.size():
		emit_signal ("enemies_enabled")
		enemies_active = true
		
	
	yield(get_tree().create_timer(0.8), "timeout")
	
	game_over_check()
	
	SceneManager.enemy_turn = false
	
	#fighter_index = -1
	if not SceneManager.victory and not SceneManager.game_over:
		select_next_fighter(+1)
		fighters_active = true
		emit_signal("fighters_active")
		
		
func revive_healing():
	var dead = fighters2[target_index].death_count()
	if dead:
		#max_turns -= 1
		fighter_name = fighters2[target_index].get_name()
		fighters2[target_index].restore(item_name)
		health = fighters2[target_index].get_health()
		f_health = fighters2[target_index].get_f_health()
		yield(get_tree().create_timer(0.25), "timeout")
		huds_heal_update()
		for x in range (fighters2.size() -1, -1, -1):
			fighters.remove(x)
		set_positions()
		for x in range (fighters.size() -1, -1, -1):
			var turn_used = fighters[x].get_turn_value()
			if turn_used:
				fighters.remove(x)
				fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
			else: 
				pass
		#huds_update()
	else:
		pass
		
func stun_healing():
	max_turns -= 1
	huds_heal_update()
	for x in range (fighters2.size() -1, -1, -1):
			fighters.remove(x)
	set_positions()
	for x in range (fighters.size() -1, -1, -1):
		var dead = fighters[x].death_count()
		if dead:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
		else:
			pass
	for x in range (fighters.size() -1, -1, -1):
		var turn_used = fighters[x].get_turn_value()
		if turn_used:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)
		else: 
			pass
	
	##### Spell Animations #####
func battle_ready():
	fighters[fighter_index].idle()
	
func spell_1():
	fighters[fighter_index].spell_1()
	
func spell_2():
	fighters[fighter_index].spell_2()
	
	##### Ally Spells ######
func Sweet_gift():
	f_turn_used()
	item_name = "Sweet Gift"
	var dead = fighters2[target_index].death_count()
	if not dead:
		var stun = fighters2[target_index].get_status("stun")
		fighters2[target_index].heal(50)
		fighters2[target_index].status_restore()
		random_buff()
		health = fighters2[target_index].get_health()
		f_health = fighters2[target_index].get_f_health()
		#huds_heal_update()
		yield(get_tree().create_timer(0.5), "timeout")
		huds_heal_update()
		fighter_index = selector_index
		if stun:
			stun_healing()
			yield(get_tree().create_timer(0.5), "timeout")
			fighter_index = -1
		else:
			_on_WorldRoot_f_index_reset()
	if dead:
		revive_healing()
		yield(get_tree().create_timer(0.5), "timeout")
		fighter_index = -1
	fighters_active_check()
	BB_active = false
	
func Blossom():	
	f_turn_used()
	fighter_index = selector_index
	for x in range(fighters2.size()):
		fighters2[x].heal(100)
		target_index = x
		item_name = "Blossom"
		var stun = fighters2[x].get_status("stun")
		fighters2[x].status_restore()
		if stun:
			stun_healing()
			yield(get_tree().create_timer(0.5), "timeout")
			fighter_index = -1
		else:
			huds_heal_update()
			yield(get_tree().create_timer(0.5), "timeout")
			_on_WorldRoot_f_index_reset()
	#yield(get_tree().create_timer(0.5), "timeout")
	#fighter_index = selector_index
	#_on_WorldRoot_f_index_reset()
	BB_active = false

func Remedy_Bouquet():
	for x in range (fighters2.size()):
		fighter_name = fighters2[x].get_name()
		stun = fighters2[x].get_status("stun")
		if stun:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			stun_healing()
		else: 
			fighters2[x].restore(item_name)
			target_index = x
			huds_heal_update()
	fighter_index = selector_index
	if not stun:
		_on_WorldRoot_f_index_reset()
	elif stun:
		fighter_index = -1
	
func Perfect_Panacea():
	for x in range (fighters2.size()):
		fighter_name = fighters2[x].get_name()
		var dead = fighters2[x].death_count()
		var stun = fighters2[x].get_status("stun")
		if dead:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			revive_resetting()
		if stun and not dead: 
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			stun_healing()
		else:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			fighter_index = selector_index
			_on_WorldRoot_f_index_reset()
			
func Miracle_Bell():	
	f_turn_used()
	item_name = "Miracle Bell"
	for x in range (fighters2.size()):
		fighter_name = fighters2[x].get_name()
		var dead = fighters2[x].death_count()
		var stun = fighters2[x].get_status("stun")
		if dead:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			revive_resetting()
		if stun and not dead: 
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			stun_healing()
		else:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			fighter_index = selector_index
			_on_WorldRoot_f_index_reset()
	BB_active = false
	
func Elucidate():	
	f_turn_used()
	item_name = "Elucidate"
	for x in range (fighters2.size()):
		fighter_name = fighters2[x].get_name()
		var dead = fighters2[x].death_count()
		if dead:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			revive_resetting()
		else:
			fighters2[x].restore(item_name)
			yield(get_tree().create_timer(0.25), "timeout")
			target_index = x
			huds_heal_update()
			fighter_index = selector_index
			_on_WorldRoot_f_index_reset()
	BB_active = false
		
func Mystery_Treat():
	f_turn_used()
	item_name = "Mystery Treat"
	var dead = fighters2[target_index].death_count()
	if not dead:
		var stun = fighters2[target_index].get_status("stun")
		fighters2[target_index].heal(150)
		fighters2[target_index].status_restore()
		health = fighters2[target_index].get_health()
		f_health = fighters2[target_index].get_f_health()
		huds_heal_update()
		yield(get_tree().create_timer(0.5), "timeout")
		fighter_index = selector_index
		if stun:
			stun_healing()
			yield(get_tree().create_timer(0.5), "timeout")
			fighter_index = -1
		else:
			_on_WorldRoot_f_index_reset()
	if dead:
		revive_healing()
		yield(get_tree().create_timer(0.5), "timeout")
		fighter_index = -1
	BB_active = false
	
func Alchemy():
	f_turn_used()
	item_name = "Alchemy"
	fighter_name = fighters2[target_index].get_name()
	var dead = fighters2[target_index].death_count()
	if dead:
		fighters2[target_index].restore(item_name)
		yield(get_tree().create_timer(0.25), "timeout")
		huds_heal_update()
		revive_resetting()
	else:
		fighters2[target_index].restore(item_name)
		yield(get_tree().create_timer(0.25), "timeout")
		huds_heal_update()
		fighter_index = selector_index
		_on_WorldRoot_f_index_reset()
	BB_active = false
		
func revive_resetting():
	for x in range (fighters2.size() -1, -1, -1):
		fighters.remove(x)
	set_positions()
	for x in range (fighters.size() -1, -1, -1):
		var turn_used = fighters[x].get_turn_value()
		if turn_used:
			fighters.remove(x)
			fighter_index = clamp(fighter_index, 0, fighters.size() - 1)

##############
func _on_WorldRoot_update_party():
	for x in range(fighters2.size()):
		fighter_name = fighters2[x].get_name()
		health = fighters2[x].get_health()
		if health == 0:
			health = 1
		if fighter_name == "gary":
			PartyStats.gary_current_health = health
		if fighter_name == "jacques":
			PartyStats.jacques_current_health = health
		if fighter_name == "irina":
			PartyStats.irina_current_health = health
		if fighter_name == "suzy":
			PartyStats.suzy_current_health = health
		if fighter_name == "damien":
			PartyStats.damien_current_health = health


func _on_Enemies_victory():
	yield(get_tree().create_timer(0.4), "timeout")
	hide_all_cursors()
