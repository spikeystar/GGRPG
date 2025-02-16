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
export(PackedScene) var TEXT_STORED: PackedScene = null
export(PackedScene) var TEXT_POISON: PackedScene = null
var OG_position : Vector2
var BB_position : Vector2
var able = true
var defend = false
var turn_used = false
var health : int
var formation : int
var move_type : String

var dead = false
var hide = false
var stun = false
var poison = false
var wimpy = false
var dizzy = false
var targeted = false
var anxious = false
var applied_type = false
var changing_type : String
var whammy_chance = 3
var stored_damage = false
var stored_amount : int = 0

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

var hocus_potion
var hocus_potion_timer = 0

onready var Congeal = preload("res://Misc/Shader/Congeal_Shader.tres")


func _ready():
	SceneManager.targeted_applied = false
	set_stats()
	set_formation()
	set_trinket()
	
func focus():
	#if able:
	if not SceneManager.victory:
		$Cursor.show()
		$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func get_name():
	return fighter_name
	
func attack_shader(id : String):
	if id == "Congeal":
		$Sprite.material = Congeal
		
func reset_shader():
	$Sprite.material = ShaderMaterial.new()

	
	
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
	if id == "stored_damage":
		return stored_damage
		
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
		
	if id =="whammy_chance":
		return whammy_chance
	
func idle():
	$AnimationPlayer.play("Fighter_BattleReady")
	
func turn():
	$AnimationPlayer.play("Fighter_Turn")
	
func defend():
	SE.effect("Defend")
	$AnimationPlayer.play("Fighter_Defend")
	$AnimationPlayer.playback_speed = 1
	defend = true
	able = false
	f_defense = f_defense + (f_defense * 0.2)
	
func item_used():
	able = false
	SE.effect("Item Use")
	$AnimationPlayer.play("Fighter_Item")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Fighter_BattleReady")
	
func heal(HP_amount):
	if dead:
		yield(get_tree().create_timer(0.2), "timeout")
		SE.effect("Heal")
		$Effect.show()
		$EffectPlayer.play("Heal")
		yield(get_tree().create_timer(0.2), "timeout")
		var heal_text = text(TEXT_HEAL)
		if heal_text:
			heal_text.label.text = str(0)
	else:
		health = clamp(health + HP_amount, 0, f_health)
		yield(get_tree().create_timer(0.2), "timeout")
		SE.effect("Heal")
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
			SE.effect("Revive")
			$Effect.show()
			$EffectPlayer.play("Restore")
			dead = false
			hide = false
			turn_used = false
			status_restore()
			yield(get_tree().create_timer(0.2), "timeout")
			$AnimationPlayer.play_backwards("Fighter_Dead")
			yield(get_tree().create_timer(0.2), "timeout")
			$AnimationPlayer.play("Fighter_BattleReady")
		else:
			yield(get_tree().create_timer(0.2), "timeout")
			SE.effect("Revive")
			$Effect.show()
			$EffectPlayer.play("Restore")
	elif id == "Sweet Gift":
		health = int(f_health / 2)
		dead = false
		hide = false
		turn_used = false
		$Effect.show()
		$EffectPlayer.play("Heal")
		status_restore()
		yield(get_tree().create_timer(0.2), "timeout")
		$AnimationPlayer.play_backwards("Fighter_Dead")
		yield(get_tree().create_timer(0.2), "timeout")
		$AnimationPlayer.play("Fighter_BattleReady")

	elif id == "Blossom":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		$Effect.show()
		$EffectPlayer.play("Heal")
	elif id == "Ginger Tea":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		SE.effect("Revive")
		$Effect.show()
		$EffectPlayer.play("Restore")
	elif id == "Remedy Bouquet":
		yield(get_tree().create_timer(0.2), "timeout")
		status_restore()
		SE.effect("Revive")
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
	SE.effect("Revive")
	$Effect.show()
	$EffectPlayer.play("SP")
	yield(get_tree().create_timer(0.2), "timeout")
	var sp_text = text(TEXT_SP)
	if sp_text:
		sp_text.label.text = str(SP_amount)
	PartyStats.party_sp = clamp(PartyStats.party_sp + SP_amount, 0, PartyStats.party_max_sp)
	
func weapon_SP(SP_amount: int):
	if not anxious:
		var sp_text = text(TEXT_SP)
		if sp_text:
			sp_text.label.text = str(SP_amount)
		PartyStats.party_sp = clamp(PartyStats.party_sp + SP_amount, 0, PartyStats.party_max_sp)
	
func anxious_SP(SP_amount: int):
	var sp_text = text(TEXT_LOSS)
	SP_amount = int(PartyStats.party_max_sp / 16)
	if sp_text:
		sp_text.label.text = str(SP_amount)
	PartyStats.party_sp = clamp(PartyStats.party_sp - SP_amount, 0, PartyStats.party_max_sp)
	
func SP_loss(SP_amount: int):
	yield(get_tree().create_timer(2), "timeout")
	var sp_text = text(TEXT_LOSS)
	if sp_text:
		sp_text.label.text = str(SP_amount)
	PartyStats.party_sp = clamp(PartyStats.party_sp - SP_amount, 0, PartyStats.party_max_sp)
		
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
		lose_buffs()
		turn_used = true
		hide = true
		SE.effect("Player Death")
		$AnimationPlayer.play("Fighter_Dead")
	else:
		$AnimationPlayer.play("Fighter_BattleReady")
		
func poison_damage():
	var amount = int(f_health / 10)
	var damage_text = text(TEXT_POISON)
	if damage_text:
		damage_text.label.text = str(amount)
	health = max(0, health - amount)
	if health == 0:
		dead = true
		lose_buffs()
		turn_used = true
		hide = true
		SE.effect("Player Death")
		$AnimationPlayer.play("Fighter_Dead")
		
func stored_damage():
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.playback_speed = 0.65
	$AnimationPlayer.play("Fighter_Damage")
	var damage_text = text(TEXT_STORED)
	if damage_text:
		damage_text.label.text = str(stored_amount)
	health = max(0, health - stored_amount)
	if health == 0:
		dead = true
		lose_buffs()
		turn_used = true
		hide = true
		yield(get_tree().create_timer(0.8), "timeout")
		SE.effect("Player Death")
		$AnimationPlayer.playback_speed = 0.5
		$AnimationPlayer.play("Fighter_Dead")
	else:
		yield(get_tree().create_timer(0.8), "timeout")
		$AnimationPlayer.playback_speed = 0.5
		$AnimationPlayer.play("Fighter_BattleReady")
	stored_damage = false
	stored_amount = 0

		
func lose_buffs():
	if a_buff:
		a_buff = false
		a_buff_timer = 0
		f_attack -= (f_attack * 0.2)
		whammy_chance -= 1
	if m_buff:
		m_buff = false
		m_buff_timer = 0
		f_magic -= (f_magic * 0.2)
		whammy_chance -= 1
	if d_buff:
		d_buff = false
		d_buff_timer = 0
		f_defense -= (f_defense * 0.2)
		whammy_chance -= 1

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
	yield(get_tree().create_timer(1.4), "timeout")
	SE.effect("Buff")
	$AnimationPlayer.playback_speed = 0.7
	$AnimationPlayer.play("Fighter_Buff")
	
func debuff():
	yield(get_tree().create_timer(1.7), "timeout")
	SE.effect("Debuff")
	$AnimationPlayer.playback_speed = 0.7
	$AnimationPlayer.play("Fighter_Debuff")
	
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
	if stun:
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
		whammy_chance += 5
	elif trinket == "Gold Chain":
		f_attack = f_defense + (f_defense*0.2)
		whammy_chance += 5
	elif trinket == "Gold Earring":
		f_attack = f_magic + (f_magic*0.2)
		whammy_chance += 5
		
##########
func status_restore():
	if stun:
		stun = false
		stun_timer = 0
		turn_used = false
	if poison:
		poison = false
		poison_timer = 0
		f_defense += (f_defense * 0.1)
	if targeted:
		targeted = false
		targeted_timer = 0
		SceneManager.targeted_applied = false
	if applied_type:
		applied_type = false
		type_timer = 0
		current_type = "neutral"
	wimpy = false
	wimpy_timer = 0
	dizzy = false
	dizzy_timer = 0
	anxious = false
	anxious_timer = 0
	if a_debuff:
		a_debuff = false
		a_debuff_timer = 0
		f_attack += (f_attack * 0.2)
		whammy_chance += 1
	if m_debuff:
		m_debuff = false
		m_debuff_timer = 0
		f_magic += (f_magic * 0.2)
		whammy_chance += 1
	if d_debuff:
		d_debuff = false
		d_debuff_timer = 0
		f_defense += (f_defense * 0.2)
		whammy_chance += 1
		

func status_countdown():
	if stun:
		stun_timer -= 1
		if stun_timer == 0:
			stun = false
			turn_used = false
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
			f_defense += (f_defense * 0.1)
	if targeted:
		targeted_timer -= 1
		if targeted_timer == 0:
			targeted = false	
			SceneManager.targeted_applied = false
	if applied_type:
		type_timer -= 1
		if type_timer == 0:
			current_type = "neutral"
			
	if a_buff:
		a_buff_timer -= 1
		if a_buff_timer == 0:
			a_buff = false
			f_attack -= (f_attack * 0.2)
			whammy_chance -= 1
	if a_debuff:
		a_debuff_timer -= 1
		if a_debuff_timer == 0:
			a_debuff = false	
			f_attack += (f_attack * 0.2)
			whammy_chance += 1
	if m_buff:
		m_buff_timer -= 1
		if m_buff_timer == 0:
			m_buff = false
			f_magic -= (f_magic * 0.2)
			whammy_chance -= 1
	if m_debuff:
		m_debuff_timer -= 1
		if m_debuff_timer == 0:
			m_debuff = false	
			f_magic += (f_magic * 0.2)
			whammy_chance += 1		
	if d_buff:
		d_buff_timer -= 1
		if d_buff_timer == 0:
			d_buff = false
			f_defense -= (f_defense * 0.2)
			whammy_chance -= 1
	if d_debuff:
		d_debuff_timer -= 1
		if d_debuff_timer == 0:
			d_debuff = false	
			f_defense += (f_defense * 0.2)
			whammy_chance += 1	
	
	if hocus_potion:
		hocus_potion_timer -= 1
		if hocus_potion_timer == 0:
			hocus_potion = false
			
	if anxious:
		anxious_timer -= 1
		if anxious_timer == 0:
			anxious = false
		yield(get_tree().create_timer(0.7), "timeout")
		anxious_SP(1)

func stun():
	if not stun and not hocus_potion:
		stun = true
		turn_used = true
		stun_timer = 2
	else:
		return

func poison():
	if not poison and not hocus_potion:
		poison = true
		poison_timer = 3
		f_defense -= (f_defense * 0.1)
	else:
		return
		
func envenomate():
	if not poison and not hocus_potion:
		poison = true
		poison_timer = 3
		f_defense -= (f_defense * 0.1)
	if poison:
		apply_debuff("attack")
		apply_debuff("magic")
		apply_debuff("defense")
	else:
		return
		
func anxious():
	if not anxious and not hocus_potion:
		anxious = true
		anxious_timer = 3
	else:
		return
		
func targeted():
	if not targeted and not SceneManager.targeted_applied and not hocus_potion:
		targeted = true
		SceneManager.targeted_applied = true
		targeted_timer = 3
	else:
		return
	
func wimpy():
	if not wimpy and not dizzy and not hocus_potion:
		wimpy = true
		wimpy_timer = 4
	else:
		return
		
func dizzy():
	if not dizzy and not wimpy and not hocus_potion:
		dizzy = true
		dizzy_timer = 4
	else:
		return
		
func apply_type(id : String):
	if not applied_type and not hocus_potion and not id == current_type:
		applied_type = true
		current_type = id
		type_timer = 3
	else:
		return
		
func apply_buff(id : String):
	if id == "attack" and not a_buff and not a_debuff:
		a_buff = true
		a_buff_timer = 4
		f_attack += (f_attack * 0.2)
		whammy_chance += 1
		buff()
	elif id == "attack" and a_debuff:
		a_debuff = false
		a_buff_timer = 3 - a_debuff_timer
		a_debuff_timer = 0
		if a_buff_timer > 0:
			a_buff = true
			f_attack += (f_attack * 0.2)
			whammy_chance += 1
		f_attack += (f_attack * 0.2)
		whammy_chance += 1
		buff()
		
	if id == "magic" and not m_buff and not m_debuff:
		m_buff = true
		m_buff_timer = 4
		f_magic += (f_magic * 0.2)
		whammy_chance += 1
		buff()
	elif id == "magic" and m_debuff:
		m_debuff = false
		m_buff_timer = 3 - m_debuff_timer
		m_debuff_timer = 0
		if m_buff_timer > 0:
			m_buff = true
			f_magic += (f_magic * 0.2)
			whammy_chance += 1
		f_magic += (f_magic * 0.2)
		whammy_chance += 1
		buff()
		
		
	if id == "defense" and not d_buff and not d_debuff:
		d_buff = true
		d_buff_timer = 3
		f_defense += (f_defense * 0.2)
		whammy_chance += 1
		buff()
	elif id == "defense" and d_debuff:
		d_debuff = false
		d_buff_timer = 3 - d_debuff_timer
		d_debuff_timer = 0
		if d_buff_timer > 0:
			d_buff = true
			f_defense += (f_defense * 0.2)
			whammy_chance += 1
		f_defense += (f_defense * 0.2)
		whammy_chance += 1
		buff()	
		
func apply_debuff(id : String):
	if id == "attack" and not a_debuff and not a_buff and not hocus_potion:
		a_debuff = true
		a_debuff_timer = 4
		f_attack -= (f_attack * 0.2)
		whammy_chance -= 1
		debuff()
	if id == "attack" and a_buff and not hocus_potion:
		a_buff = false
		a_debuff_timer = 3 - a_buff_timer
		a_buff_timer = 0
		if a_debuff_timer > 0:
			a_debuff = true
			f_attack -= (f_attack * 0.2)
			whammy_chance -= 1
		f_attack -= (f_attack * 0.2)
		whammy_chance -= 1
		debuff()
		
		
	if id == "magic" and not m_debuff and not m_buff and not hocus_potion:
		m_debuff = true
		m_debuff_timer = 4
		f_magic -= (f_magic * 0.2)
		whammy_chance -= 1
		debuff()
	if id == "magic" and m_buff and not hocus_potion:
		m_buff = false
		m_debuff_timer = 3 - m_buff_timer
		m_buff_timer = 0
		if m_debuff_timer > 0:
			m_debuff = true
			f_magic -= (f_magic * 0.2)
			whammy_chance -= 1
		f_magic -= (f_magic * 0.2)
		whammy_chance -= 1
		debuff()
		
		
	if id == "defense" and not d_debuff and not d_buff and not hocus_potion:
		d_debuff = true
		d_debuff_timer = 4
		f_defense -= (f_defense * 0.2)
		whammy_chance -= 1
		debuff()
	if id == "defense" and d_buff and not hocus_potion:
		d_buff = false
		d_debuff_timer = 3 - d_buff_timer
		d_buff_timer = 0
		if d_debuff_timer > 0:
			d_debuff = true
			f_defense -= (f_defense * 0.2)
			whammy_chance -= 1
		f_defense -= (f_defense * 0.2)
		whammy_chance -= 1
		debuff()

func random_buff():
	randomize()
	var index
	var choices = ["attack", "magic", "defense"]
	if a_buff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "attack":
				choices.remove(x)
	if m_buff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "magic":
				choices.remove(x)
	if d_buff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "defense":
				choices.remove(x)
	choices.shuffle()
	index = choices[0]
	print(index)
	
	if index == "attack" and not a_buff:
		apply_buff("attack")
	if index == "magic" and not m_buff:
		apply_buff("magic")
	if index == "defense" and not d_buff:
		apply_buff("defense")
		
func random_debuff():
	if hocus_potion:
		return
	randomize()
	var index
	var choices = ["attack", "magic", "defense"]
	if a_debuff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "attack":
				choices.remove(x)
	if m_debuff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "magic":
				choices.remove(x)
	if d_debuff:
		for x in range(choices.size() -1, -1, -1):
			if choices[x] == "defense":
				choices.remove(x)
	choices.shuffle()
	index = choices[0]
	
	if index == "attack" and not a_debuff:
		apply_debuff("attack")
	if index == "magic" and not m_debuff:
		apply_debuff("magic")
	if index == "defense" and not d_debuff:
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
	if hocus_potion:
		return
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

