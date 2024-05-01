extends Node2D

onready var enemy_members : int
onready var party_id : int
var enemies : Array = []
var enemy_index : int = 0 # Currently selected enemy index
var BB_active = false
var enemy_selecting = false
var enemy_attacked = false
var e_position : Vector2
var is_attack = false
export(int) var default_f_attack
export(int) var default_f_attack_base

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_chosen
signal e_damage_finish
#signal fighters_active

func _ready():
	enemies = get_children()

func _on_WorldRoot_BB_active():
	BB_active = true
	
func _on_WorldRoot_attack_active():
	enemy_selecting = true

func select_next_enemy(index_offset):
	var last_enemy_index = enemy_index;
	var new_enemy_index = fposmod(last_enemy_index + index_offset, enemies.size())
	print(str("Selecting:", new_enemy_index))
	
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
	
func hide_cursors():
		enemies[enemy_index].unfocus()
		
func get_e_position():
	return enemies[enemy_index].get_position()

func _on_WorldRoot_attack_chosen():
	hide_cursors()
	is_attack = true

func _on_WorldRoot_hide_enemy_cursor():
	hide_cursors()
	
func enemy_damage():
	BB_active = false
	
	var target_enemy = enemies[enemy_index]
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_attack = _on_Fighters_f_attack(default_f_attack)
	var f_attack_base = _on_Fighters_f_attack_base(default_f_attack_base)
	
	if is_attack:
		damage = max(0, (f_attack + f_attack_base) - e_defense)
		print(str("Damaging enemy[", enemy_index, "] by ", damage))
		target_enemy.damage(damage)
		is_attack = false
		
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("e_damage_finish")
	
	# Resetting animation or running the death animation (with delay)
	target_enemy.unfocus()
	if target_enemy.is_dead():
		target_enemy.death()
		enemies.remove(enemy_index)
		enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		yield(get_tree().create_timer(1), "timeout")
	else:
		target_enemy.reset_animation()
	
func enemy_attack():
	enemies[enemy_index].attack()
	

func _on_Fighters_f_attack(f_attack: int):
	return f_attack

func _on_Fighters_f_attack_base(f_attack_base: int):
	return f_attack_base
