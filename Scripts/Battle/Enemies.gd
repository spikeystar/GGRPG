extends Node2D

onready var enemy_members : int
onready var party_id : int
onready var Fighters : Node2D
var enemies : Array = []
var enemy_index : int = -1
var BB_active = false
var enemy_selecting = false
var enemy_attacked = false
var e_position : Vector2
var is_attack = false
var attack_bonus = false

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal enemy_chosen
signal e_damage_finish
signal victory

func _ready():
	enemies = get_children()
	Fighters = get_tree().get_root().get_node("WorldRoot/Fighters")
	
func _on_WorldRoot_BB_active():
	BB_active = true
	
func _on_WorldRoot_attack_active():
	enemy_selecting = true
	
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
		
func hide_cursors():
		enemies[enemy_index].unfocus()
		
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
	var target_enemy = enemies[enemy_index]
	var type_check
	var damage : int
	var e_defense = target_enemy.get_e_defense()
	var f_attack = Fighters.get_f_attack()
	var f_attack_base = Fighters.get_f_attack_base()
	if is_attack and not attack_bonus:
		damage = max(0, (f_attack + f_attack_base) - e_defense)
		target_enemy.damage(damage)
		is_attack = false
	elif is_attack and attack_bonus:
		damage = max(0, (f_attack + f_attack_base) - e_defense) + 100
		target_enemy.damage(damage)
		print("success!")
		is_attack = false
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("e_damage_finish")
	target_enemy.unfocus()
	if target_enemy.is_dead():
		target_enemy.death()
		enemies.remove(enemy_index)
		enemy_index = clamp(enemy_index, 0, enemies.size() - 1)
		yield(get_tree().create_timer(1), "timeout")
	else:
		target_enemy.reset_animation()
	if enemies.size() == 0:
		emit_signal("victory")
	
func enemy_attack():
	enemies[enemy_index].attack()
	
