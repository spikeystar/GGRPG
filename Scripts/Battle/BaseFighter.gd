extends Node2D

export(int) var party_id
export(String) var fighter_name
export(int) var f_health
export(int) var f_attack
export(int) var f_attack_base  
export(int) var f_magic
export(int) var f_magic_base
export(int) var f_defense 
var trinket : String
var base_type = "neutral"
var current_type : String
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
export(PackedScene) var TEXT_SP: PackedScene = null
export(PackedScene) var TEXT_LOSS: PackedScene = null
var OG_position : Vector2
var BB_position : Vector2
var able = true
var defend = false
var turn_used = false
var health : int
var formation : int

var dead = false
var hide = false
var stun = false
var poison = false
var wimpy = false
var dizzy = false
var item_halt = false
var targeted = false
var anxious = false
var applied_type = false
var changing_type : String

var a_buff = false
var a_debuff = false
var m_buff = false
var m_debuff = false
var d_buff = false
var d_debuff = false

var stun_timer = 0
var poison_timer = 0
var wimpy_timer = 0
var dizzy_timer = 0
var targeted_timer = 0
var anxious_timer = 0
var type_timer = 0

var a_buff_timer = 0
var a_debuff_timer = 0
var m_buff_timer = 0
var m_debuff_timer = 0
var d_buff_timer = 0
var d_debuff_timer = 0

func _ready():
	set_stats()
	set_formation()
	set_trinket()
	
func focus():
	#if able:
	$Cursor.show()
	$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func get_name():
	return fighter_name
	
func set_stats():
	if fighter_name == "gary":
		party_id = PartyStats.gary_id
		health = PartyStats.gary_current_health
		f_health = PartyStats.gary_health
		f_attack = PartyStats.gary_attack
		f_magic = PartyStats.gary_magic
		f_defense = PartyStats.gary_defense
		trinket = PartyStats.gary_trinket
	if fighter_name == "jacques":
		party_id = PartyStats.jacques_id
		health = PartyStats.jacques_current_health
		f_health = PartyStats.jacques_health
		f_attack = PartyStats.jacques_attack
		f_magic = PartyStats.jacques_magic
		f_defense = PartyStats.jacques_defense
		trinket = PartyStats.jacques_trinket
	if fighter_name == "irina":
		party_id = PartyStats.irina_id
		health = PartyStats.irina_current_health
		f_health = PartyStats.irina_health
		f_attack = PartyStats.irina_attack
		f_magic = PartyStats.irina_magic
		f_defense = PartyStats.irina_defense
		trinket = PartyStats.irina_trinket
		
func set_formation():
	if PartyStats.party_members == 1:
		if party_id >= 2:
			self.queue_free()
	if PartyStats.party_members == 2:
		if party_id >= 3:
			self.queue_free()
	if PartyStats.party_members == 3:
		if party_id >= 4:
			self.queue_free()
	
func get_health():
	return health
	
func get_f_health():
	return f_health
	
func get_id():
	return party_id
	
func death_count():
	return dead
	
func get_status(id : String):
	if id == "stun":
		return stun
	if id == "poison":
		return poison
	if id == "anxious":
		return anxious
	if id == "targeted":
		return targeted
	if id == "wimpy":
		return wimpy
	if id == "dizzy":
		return dizzy
	if id == "type":
		return current_type
		
	if id == "a_buff":
		return a_buff
	if id == "a_debuff":
		return a_debuff
	if id == "m_buff":
		return m_buff
	if id == "m_debuff":
		return m_debuff
	if id == "d_buff":
		return d_buff
	if id == "d_debuff":
		return d_debuff
	
func idle():
	$AnimationPlayer.play("Fighter_BattleReady")
	
func turn():
	$AnimationPlayer.play("Fighter_Turn")
	
func defend():
	$AnimationPlayer.play("Fighter_Defend")
	$AnimationPlayer.playback_speed = 1
	defend = true
	able = false
	f_defense = f_defense + (f_defense * 0.2)
	
func item_used():
	able = false
	$AnimationPlayer.play("Fighter_Item")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Fighter_BattleReady")
	
func heal(HP_amount):
	if dead:
		yield(get_tree().create_timer(0.2), "timeout")
		$Effect.show()
		$EffectPlayer.play("Heal")
		yield(get_tree().create_timer(0.2), "timeout")
		var heal_text = text(TEXT_HEAL)
		if heal_text:
			heal_text.label.text = str(0)
	else:
		health = clamp(health + HP_amount, 0, f_health)
		yield(get_tree().create_timer(0.2), "timeout")
		$Effect.show()
		$EffectPlayer.play("Heal")
		yield(get_tree().create_timer(0.2), "timeout")
		var heal_text = text(TEXT_HEAL)
		if heal_text:
			heal_text.label.text = str(HP_amount)
		
func restore(id : String):
	if id == "Bounty Herb":
		if dead:
			health = int(f_health / 2)
			$AnimationPlayer.play_backwards("Fighter_Dead")
			$AnimationPlayer.play("Fighter_BattleReady")
			dead = false
			hide = false
			turn_used = false
			status_restore()
			yield(get_tree().create_timer(0.2), "timeout")
			$Effect.show()
			$EffectPlayer.play("Restore")
		else:
			yield(get_tree().create_timer(0.2), "timeout")
			$Effect.show()
			$EffectPlayer.play("Restore")
	elif id == "Sweet Gift":
		health = int(f_health / 2)
		$AnimationPlayer.play_backwards("Fighter_Dead")
		$AnimationPlayer.play("Fighter_BattleReady")
		dead = false
		hide = false
		turn_used = false
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Heal")
	elif id == "Blossom":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Heal")
	elif id == "Ginger Tea":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Restore")
	elif id == "Remedy Bouquet":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Restore")
	elif id == "Perfect Panacea":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		#GIVE ALL BUFFS
		if dead:
			health = f_health
			$AnimationPlayer.play_backwards("Fighter_Dead")
			$AnimationPlayer.play("Fighter_BattleReady")
			dead = false
			hide = false
			turn_used = false
		else:
			pass
		$Effect.show()
		$EffectPlayer.play("Perfect")
	elif id == "Miracle Bell":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		if dead:
			health = f_health
			$AnimationPlayer.play_backwards("Fighter_Dead")
			$AnimationPlayer.play("Fighter_BattleReady")
			dead = false
			hide = false
			turn_used = false
		else:
			pass
		$Effect.show()
		$EffectPlayer.play("Heal")
	elif id == "Elucidate":
		yield(get_tree().create_timer(0.2), "timeout")
		if dead:
			health = f_health
			$AnimationPlayer.play_backwards("Fighter_Dead")
			$AnimationPlayer.play("Fighter_BattleReady")
			dead = false
			hide = false
			turn_used = false
		else:
			pass
		$Effect.show()
		$EffectPlayer.play("SP")
	elif id == "Mystery Treat":
		health = int(f_health / 2)
		$AnimationPlayer.play_backwards("Fighter_Dead")
		$AnimationPlayer.play("Fighter_BattleReady")
		dead = false
		hide = false
		turn_used = false
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Strange")
	elif id == "Alchemy":
		yield(get_tree().create_timer(0.2), "timeout")
		if dead:
			health = f_health
			$AnimationPlayer.play_backwards("Fighter_Dead")
			$AnimationPlayer.play("Fighter_BattleReady")
			dead = false
			hide = false
			turn_used = false
		else:
			pass
		$Effect.show()
		$EffectPlayer.play("SP")
		
func SP(SP_amount: int):
	yield(get_tree().create_timer(0.2), "timeout")
	$Effect.show()
	$EffectPlayer.play("SP")
	yield(get_tree().create_timer(0.2), "timeout")
	var sp_text = text(TEXT_SP)
	if sp_text:
		sp_text.label.text = str(SP_amount)
	PartyStats.party_sp = clamp(PartyStats.party_sp + SP_amount, 0, PartyStats.party_max_sp)
	
func weapon_SP(SP_amount: int):
	var sp_text = text(TEXT_SP)
	if sp_text:
		sp_text.label.text = str(SP_amount)
	PartyStats.party_sp = clamp(PartyStats.party_sp + SP_amount, 0, PartyStats.party_max_sp)
		
func combo_heal(SP_amount : int):
	yield(get_tree().create_timer(0.2), "timeout")
	yield(get_tree().create_timer(0.2), "timeout")
	var sp_text = text(TEXT_SP)
	if sp_text:
		sp_text.label.text = str(SP_amount)

func damage(amount: int, damage_type: String):
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	if amount <= 0:
		return
	$DamageStar.show()
	$AnimationPlayer.play("Fighter_Damage")
	$AnimationPlayer.playback_speed = 0.7
	type_damage(damage_type)
	$AnimationPlayer.playback_speed = 0.5
	health = max(0, health - amount)
	yield(get_tree().create_timer(1.6), "timeout")
	if health == 0:
		dead = true
		turn_used = true
		hide = true
		$AnimationPlayer.play("Fighter_Dead")
	else:
		$AnimationPlayer.play("Fighter_BattleReady")
		
func poison_damage():
	var amount = int(f_health / 8)
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	health = max(0, health - amount)
	if health == 0:
		dead = true
		turn_used = true
		hide = true
		$AnimationPlayer.play("Fighter_Dead")

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

	
func buff():
	yield(get_tree().create_timer(1.7), "timeout")
	$AnimationPlayer.playback_speed = 0.7
	$AnimationPlayer.play("Fighter_Buff")
	
func flee():
	$AnimationPlayer.play("Fighter_Flee")
	$AnimationPlayer.playback_speed = 1
	
func pre_attack():
	$AnimationPlayer.play("Fighter_Pre_Attack")
	able = false

func attack():
	$AnimationPlayer.play("Fighter_Attack")
	$AnimationPlayer.playback_speed = 0.6
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("Fighter_BattleReady")
	
func text(TEXT: PackedScene, text_position: Vector2 = global_position):
	if TEXT:
		var text = TEXT.instance()
		get_tree().current_scene.add_child(text)
		text.position = text_position + Vector2(0, -60)
		return text
		
func get_position(fighter_position: Vector2 = position):
	return fighter_position
	
func get_OG_position():
	if PartyStats.party_members == 1:
		if party_id == 1:
			OG_position = Vector2(-138, 136)
			return OG_position
			
	if PartyStats.party_members == 2:
		if party_id == 1:
			OG_position = Vector2(-199, 112)
		elif party_id == 2:
			OG_position = Vector2(-86, 168)
		return OG_position
	
	if PartyStats.party_members == 3:
		if party_id == 1:
			OG_position = Vector2(-240, 86)
		elif party_id == 2:
			OG_position = Vector2(-135, 144)
		elif party_id == 3:
			OG_position = Vector2(-23, 194)
		return OG_position
	
func get_BB_position():
	if PartyStats.party_members == 1:
		if party_id == 1:
			BB_position = Vector2(-138, 98)
			return BB_position
			
	if PartyStats.party_members == 2:
		if party_id == 1:
			BB_position = Vector2(-199, 74)
		elif party_id == 2:
			BB_position = Vector2(-86, 130)
		return BB_position
	
	if PartyStats.party_members == 3:
		if party_id == 1:
			BB_position = Vector2(-240, 48)
		elif party_id == 2:
			BB_position = Vector2(-135, 106)
		elif party_id == 3:
			BB_position = Vector2(-23, 156)
		return BB_position
	
func get_f_attack():
	return f_attack
	
func get_f_attack_base():
	return f_attack_base

func get_f_magic():
	return f_magic
	
func get_f_magic_base():
	return f_magic_base
	
func get_f_defense():
	return f_defense

func get_self(fighter_self: Node2D = self):
	return fighter_self
	
func turn_used():
	turn_used = true
	
func turn_restored():
	if dead:
		turn_used = true
		if defend:
			f_defense -= (f_defense * 0.2)
			defend = false
	elif stun:
		turn_used = true
		status_countdown()
		if defend:
			f_defense -= (f_defense * 0.2)
			defend = false
	else:
		turn_used = false
		able = true
		status_countdown()
		if defend:
			f_defense -= (f_defense * 0.2)
			defend = false
	
func get_turn_value():
	return turn_used
	
func victory():
	$AnimationPlayer.play("Fighter_Victory")
	
func spell_1():
	$AnimationPlayer.play("Spell_1")
	
func spell_2():
	$AnimationPlayer.play("Spell_2")
	
func set_trinket():
	if trinket == "Gold Bracelet":
		f_attack = f_attack + (f_attack*0.2)
	elif trinket == "Gold Chain":
		f_attack = f_defense + (f_defense*0.2)
	elif trinket == "Gold Earring":
		f_attack = f_magic + (f_magic*0.2)
		
##########
func status_restore():
	if stun:
		stun = false
		turn_used = false
	var poison = false
	var wimpy = false
	var dizzy = false
	var targeted = false
	var anxious = false
	current_type = "neutral"

func status_countdown():
	if stun:
		stun_timer -= 1
		if stun_timer == 0:
			stun = false
	if wimpy:
		wimpy_timer -= 1
		if wimpy_timer == 0:
			wimpy = false
	if dizzy:
		dizzy_timer -= 1
		if dizzy_timer == 0:
			dizzy = false
	if poison:
		poison_timer -= 1
		if poison_timer == 0:
			poison = false
	if anxious:
		anxious_timer -= 1
		if anxious_timer == 0:
			anxious = false
	if targeted:
		targeted_timer -= 1
		if targeted_timer == 0:
			targeted = false	
	if applied_type:
		type_timer -= 1
		if type_timer == 0:
			current_type = "neutral"
			
	if a_buff:
		a_buff_timer -= 1
		if a_buff_timer == 0:
			a_buff = false
	if a_debuff:
		a_debuff_timer -= 1
		if a_debuff_timer == 0:
			a_debuff = false	
	if m_buff:
		m_buff_timer -= 1
		if m_buff_timer == 0:
			m_buff = false
	if m_debuff:
		m_debuff_timer -= 1
		if m_debuff_timer == 0:
			m_debuff = false			
	if d_buff:
		d_buff_timer -= 1
		if d_buff_timer == 0:
			d_buff = false
	if d_debuff:
		d_debuff_timer -= 1
		if d_debuff_timer == 0:
			d_debuff = false			

func stun():
	if not stun:
		stun = true
		turn_used = true
		stun_timer = 2
	else:
		return

	
