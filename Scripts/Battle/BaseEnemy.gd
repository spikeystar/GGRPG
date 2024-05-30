extends Node2D

export(String) var ID = ""
export(int) var e_health
export(int) var e_attack 
export(int) var e_magic
export(int) var e_defense 
export(String) var initial_type = ""
var current_type = ""
var applied_type = false
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
var health : int
var death_tagged = false
var poison = false
var stun = false

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
	
func damage(amount: int):
	var damage_text = text(TEXT_DAMAGE)
	if damage_text:
		damage_text.label.text = str(amount)
	if amount <= 0:
		return
	$DamageStar.show()
	$AnimationPlayer.play("enemy_damage")
	$AnimationPlayer.playback_speed = 0.7
	$DamagePlayer.play("neutral")
	$AnimationPlayer.playback_speed = 0.5
	health = max(0, health - amount)
	yield(get_tree().create_timer(2), "timeout")
	$AnimationPlayer.play("enemy_idle")
	
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
