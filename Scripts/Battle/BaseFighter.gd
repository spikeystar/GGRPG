extends Node2D

export(int) var party_id
export(String) var fighter_name
export(int) var f_health
export(int) var f_attack
export(int) var f_attack_base  
export(int) var f_magic
export(int) var f_defense 
export(String) var f_type
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
export(PackedScene) var TEXT_SP: PackedScene = null
export(PackedScene) var TEXT_LOSS: PackedScene = null
var OG_position : Vector2
var BB_position : Vector2
var able = true
var turn_used = false

func focus():
	#if able:
	$Cursor.show()
	$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func get_name():
	return fighter_name
	
func get_id():
	return party_id
	
func idle():
	$AnimationPlayer.play("Fighter_BattleReady")
	
func turn():
	$AnimationPlayer.play("Fighter_Turn")
	
func defend():
	$AnimationPlayer.play("Fighter_Defend")
	able = false
	
func item_used():
	able = false
	$AnimationPlayer.play("Fighter_Item")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Fighter_BattleReady")
	
func heal():
	yield(get_tree().create_timer(0.2), "timeout")
	$Effect.show()
	$EffectPlayer.play("Heal")
	
func restore():
	yield(get_tree().create_timer(0.2), "timeout")
	$Effect.show()
	$EffectPlayer.play("Restore")
	
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
		text.global_position = text_position + Vector2(0, -60)
		
func get_position(fighter_position: Vector2 = global_position):
	return fighter_position
	
func get_OG_position():
	if party_id == 0:
		OG_position = Vector2(-240, 86)
	elif party_id == 1:
			OG_position = Vector2(-135, 144)
	elif party_id == 2:
			OG_position = Vector2(-23, 194)
	return OG_position
	
func get_BB_position():
	if party_id == 0:
		BB_position = Vector2(-240, 48)
	elif party_id == 1:
			BB_position = Vector2(-135, 106)
	elif party_id == 2:
			BB_position = Vector2(-23, 156)
	return BB_position
	
func get_f_attack():
	return f_attack
	
func get_f_attack_base():
	return f_attack_base

func get_f_magic():
	return f_magic
	
func get_f_defense():
	return f_defense

func get_self(fighter_self: Node2D = self):
	return fighter_self
	
func turn_used():
	turn_used = true
	
func turn_restored():
	turn_used = false
	able = true
	
func get_turn_value():
	return turn_used
	
func victory():
	$AnimationPlayer.play("Fighter_Victory")

