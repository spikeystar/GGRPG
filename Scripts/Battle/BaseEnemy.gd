extends Node2D

export(String) var ID = ""
export(int) var e_health
export(int) var e_attack 
export(int) var e_magic
export(int) var e_defense 
export(String) var initial_type = ""
export(bool) var boss = false
var current_type = ""
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
var health : int
var death_tagged = false
var move_type : String

var poison = false
var stun = false
var applied_type = false
var changing_type : String
var whammy

var a_buff = false
var a_debuff = false
var m_buff = false
var m_debuff = false
var d_buff = false
var d_debuff = false

var stun_timer = 0
var poison_timer = 0
var type_timer = 0

var a_buff_timer = 0
var a_debuff_timer = 0
var m_buff_timer = 0
var m_debuff_timer = 0
var d_buff_timer = 0
var d_debuff_timer = 0

var damage_type : String

export(String) var move1 = ""
export(String) var move2 = ""
export(String) var move3 = ""
onready var move_list : Array = [move1, move2, move3]
var check_name : String

signal enemy_dead

func _ready():
	reset_animation()
	unfocus()
	health = e_health
	current_type = initial_type
	for x in range(move_list.size() -1, -1, -1):
		check_name = move_list[x]
		if check_name == "":
			move_list.remove(x)
			x = clamp(x, 0, move_list.size() - 1)
		
func get_name():
	return ID
	
func get_status(parameter: String):
	if parameter == "poison":
		return poison
	if parameter == "stun":
		return stun
	if parameter == "a_buff":
		return a_buff
	if parameter == "a_debuff":
		return a_debuff
	if parameter == "m_buff":
		return m_buff
	if parameter == "m_debuff":
		return m_debuff
	if parameter == "d_buff":
		return d_buff
	if parameter == "d_debuff":
		return d_debuff
	
func get_type():
	return initial_type
	
func get_stats(parameter: String):
	if parameter == "e_attack":
		return e_attack
	if parameter == "e_magic":
		return e_magic
	if parameter == "e_defense":
		return e_defense
	
func get_e_defense():
	return e_defense
	
func buff():
	yield(get_tree().create_timer(1.7), "timeout")
	$AnimationPlayer.playback_speed = 0.7
	$AnimationPlayer.play("buff")
	
func debuff():
	yield(get_tree().create_timer(1.7), "timeout")
	$AnimationPlayer.playback_speed = 0.7
	$AnimationPlayer.play("debuff")
	
func reset_animation():	
	$AnimationPlayer.play("enemy_idle")
	$AnimationPlayer.playback_speed = 0.5

func focus():
	$Cursor.show()
	$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func attack():
	$AnimationPlayer.play("enemy_attack")
	$AnimationPlayer.playback_speed = 0.8
	
func heal(amount : int):
	var heal_text = text(TEXT_HEAL)
	if heal_text:
		heal_text.label.text = str(amount)
	health = clamp(health + amount, 0, e_health)

	
func damage(amount: int):
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	if amount <= 0:
		return
	$DamageStar.show()
	$AnimationPlayer.play("enemy_damage")
	$AnimationPlayer.playback_speed = 0.7
	if whammy:
		$DamagePlayer.play("whammy")
	else:
		$DamagePlayer.play("neutral")
	$AnimationPlayer.playback_speed = 0.5
	health = max(0, health - amount)
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("enemy_idle")
	whammy = false
	
func magic_damage(amount: int, damage_type: String):
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	if amount <= 0:
		return
	$DamageStar.show()
	$AnimationPlayer.play("enemy_damage")
	$AnimationPlayer.playback_speed = 0.7
	type_damage(damage_type)
	$AnimationPlayer.playback_speed = 0.5
	health = max(0, health - amount)
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("enemy_idle")
	
func poison_damage():
	var amount = e_health / 10
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	health = max(0, health - amount)
	#yield(get_tree().create_timer(2), "timeout")
	#$AnimationPlayer.play("enemy_idle")
		
func get_health():
	return health
	
func is_dead():
	return health == 0
	
func get_death_tag():
	return death_tagged
	
func type_damage(damage_type):
	if damage_type == "neutral":
		$DamagePlayer.play("neutral")
	if damage_type == "fire":
		$DamagePlayer.play("fire")
	if damage_type == "water":
		$DamagePlayer.play("water")
	if damage_type == "air":
		$DamagePlayer.play("air")
	if damage_type == "earth":
		$DamagePlayer.play("earth")
	if damage_type == "whammy":
		$DamagePlayer.play("whammy")
		
	
func death():
		$AnimationPlayer.play("enemy_death")
		$AnimationPlayer.playback_speed = 0.8
		yield(get_tree().create_timer(0.1), "timeout")
		$Poof.show()
		$PoofPlayer.play("poof")

func get_position(enemy_position: Vector2 = position):
	return enemy_position
	
func text(TEXT: PackedScene, text_position: Vector2 = global_position):
	if TEXT:
		var text = TEXT.instance()
		get_tree().current_scene.add_child(text)
		text.position = text_position + Vector2(4, -44)
		return text

func stun():
	if not stun:
		stun = true
		stun_timer = 1
	else:
		pass
		
func poison():
	if not poison:
		poison = true
		poison_timer = 3
		e_defense -= (e_defense * 0.1)
	else:
		pass

func countdown():
	if stun:
		stun_timer -= 1
		if stun_timer == 0:
			stun = false
			
	if poison:
		poison_timer -= 1
		if poison_timer == 0:
			poison = false
			e_defense += (e_defense * 0.1)
	
	if applied_type:
		type_timer -= 1
		if type_timer == 0:
			applied_type = false
			current_type = initial_type
			
	if a_buff:
		a_buff_timer -= 1
		if a_buff_timer == 0:
			a_buff = false
			e_attack -= (e_attack * 0.2)
	if a_debuff:
		a_debuff_timer -= 1
		if a_debuff_timer == 0:
			a_debuff = false	
			e_attack += (e_attack * 0.2)
	if m_buff:
		m_buff_timer -= 1
		if m_buff_timer == 0:
			m_buff = false
			e_magic -= (e_magic * 0.2)
	if m_debuff:
		m_debuff_timer -= 1
		if m_debuff_timer == 0:
			m_debuff = false	
			e_magic += (e_magic * 0.2)		
	if d_buff:
		d_buff_timer -= 1
		if d_buff_timer == 0:
			d_buff = false
			e_defense -= (e_defense * 0.2)
	if d_debuff:
		d_debuff_timer -= 1
		if d_debuff_timer == 0:
			d_debuff = false	
			e_defense += (e_defense * 0.2)		
			
func enemy_restore():
	if poison:
		poison = false
		e_defense += (e_defense * 0.1)
	current_type = initial_type
	
func apply_type(id : String):
	if not applied_type and not id == current_type:
		applied_type = true
		current_type = id
		type_timer = 3
	else:
		return
	
func apply_buff(id : String):
	if id == "attack" and not a_buff and not a_debuff:
		a_buff = true
		a_buff_timer = 4
		e_attack += (e_attack * 0.2)
		buff()
	elif id == "attack" and a_debuff:
		a_debuff = false
		a_debuff_timer = 0
		e_attack += (e_attack * 0.2)
		buff()
		
	if id == "magic" and not m_buff and not m_debuff:
		m_buff = true
		m_buff_timer = 4
		e_magic += (e_magic * 0.2)
		buff()
	elif id == "magic" and m_debuff:
		m_debuff = false
		m_debuff_timer = 0
		e_magic += (e_magic * 0.2)
		buff()
		
		
	if id == "defense" and not d_buff and not d_debuff:
		d_buff = true
		d_buff_timer = 4
		e_defense += (e_defense * 0.2)
		buff()
	elif id == "defense" and d_debuff:
		d_debuff = false
		d_debuff_timer = 0
		e_defense += (e_defense * 0.2)
		buff()	
		
		
func apply_debuff(id : String):
	if id == "attack" and not a_debuff and not a_buff:
		a_debuff = true
		a_debuff_timer = 3
		e_attack -= (e_attack * 0.2)
		debuff()
	if id == "attack" and a_buff:
		a_buff = false
		a_buff_timer = 0
		e_attack -= (e_attack * 0.2)
		debuff()
		
		
	if id == "magic" and not m_debuff and not m_buff:
		m_debuff = true
		m_debuff_timer = 3
		e_magic -= (e_magic * 0.2)
		debuff()
	if id == "magic" and m_buff:
		m_buff = false
		m_buff_timer = 0
		e_magic -= (e_magic * 0.2)
		debuff()
		
		
	if id == "defense" and not d_debuff and not d_buff:
		d_debuff = true
		d_debuff_timer = 4
		e_defense -= (e_defense * 0.2)
		debuff()
	if id == "defense" and d_buff:
		d_buff = false
		d_buff_timer = 0
		e_defense -= (e_defense * 0.2)
		debuff()


func random_buff():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(1, 3)
	if index == 1:
		apply_buff("attack")
	if index == 2:
		apply_buff("magic")
	if index == 3:
		apply_buff("defense")
		
func random_debuff():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(1, 3)
	if index == 1:
		apply_debuff("attack")
	if index == 2:
		apply_debuff("magic")
	if index == 3:
		apply_debuff("defense")

func multi_random_buff():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(1, 3)
	var last_index = index
	if index == 1:
		apply_buff("attack")
	if index == 2:
		apply_buff("magic")
	if index == 3:
		apply_buff("defense")
		
	var chance = rng.randi_range(1, 100)
	if chance <= 50:
		while index == last_index:
			index = rng.randi_range(1, 3)
		if index == 1:
			apply_buff("attack")
		if index == 2:
			apply_buff("magic")
		if index == 3:
			apply_buff("defense")
	
	chance = rng.randi_range(1, 100)
	if chance <= 25:
		var previous_index = last_index
		last_index = index
		while index == last_index or index == previous_index:
			index = rng.randi_range(1, 3)
		if index == 1:
			apply_buff("attack")
		if index == 2:
			apply_buff("magic")
		if index == 3:
			apply_buff("defense")
			
func multi_random_debuff():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(1, 3)
	var last_index = index
	if index == 1:
		apply_debuff("attack")
	if index == 2:
		apply_debuff("magic")
	if index == 3:
		apply_debuff("defense")
		
	var chance = rng.randi_range(1, 100)
	if chance <= 50:
		while index == last_index:
			index = rng.randi_range(1, 3)
		if index == 1:
			apply_debuff("attack")
		if index == 2:
			apply_debuff("magic")
		if index == 3:
			apply_debuff("defense")
	
	chance = rng.randi_range(1, 100)
	if chance <= 25:
		var previous_index = last_index
		last_index = index
		while index == last_index or index == previous_index:
			index = rng.randi_range(1, 3)
		if index == 1:
			apply_debuff("attack")
		if index == 2:
			apply_debuff("magic")
		if index == 3:
			apply_debuff("defense")
