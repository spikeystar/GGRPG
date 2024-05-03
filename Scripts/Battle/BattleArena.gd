extends Node

#export(tscn) var enemy = null

onready var player_instance = PlayerManager.player_instance
export(int) var EXP_base
export(int) var marbles_base
var window_open = false
var defend_show = false
var attack_show = false
var magic_show = false
var item_show = false
var defending = false
var BB_active = false
var item_halt = false
var fighter_selection = false
var fighter0_active = false
var fighter1_active = false
var fighter2_active = false
var fighters_over = false
var tween
var attack_ended = true
var f_turns : int = 0
var fighters_enabled = true
var enemies_enabled = false
var ongoing = false

onready var party_members : int
onready var party_id : int

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal index_reset()
signal index_resetzero()
signal BB_active()
signal defend_chosen()
signal flee_chosen()
signal attack_active()
signal attack_inactive()
signal attack_chosen()
signal magic_active()
signal hide_enemy_cursor()
signal f_turn_used()
signal f_index_reset()
signal start_attack_timer()
signal item_active()
signal item_inactive()
signal defend_active()
signal defend_inactive()
signal action_ongoing()
signal action_ended()

func _ready():
	#set_health($HUDS/ProgressBar, Party.current_health, Party.max_health)
	$DefenseWindow.hide()
	$BattleButtons.hide()
	$BattleButtons.global_position = Vector2(0,0)
	$ItemWindow.hide()
	$MagicWindow.hide()
	$BattleDialogue.hide()
	$EnemyInfo.hide()
	$EnemyMove.hide()
	$FleeDialogue.hide()
	player_instance.queue_free()
	
	if party_members == 1:
		party_formation_1 = true

	if party_members == 2:
		party_formation_2 = true

	if party_members == 3:
		party_formation_3 = true

#func _set_position():

	
#func set_health(progress_bar, current_health, max_health):
	#progress_bar.value = current_health
	#progress_bar.max_value = max_health
	#progress_bar.get_node("Gary Health").text = "%d/%d" % [current_health, max_health]
	
#Window Display
func hide_cursors():
	if BB_active:
		emit_signal("BB_active")
		
func _on_Fighters_fighters_active():
		fighter_selection = true
		
func _on_Fighters_BB_move():
	var BB_position = $Fighters.get_BB_position()
	$BattleButtons.global_position = BB_position
		
#func _on_Fighters_fighter_index_0():
	#$BattleButtons.global_position = $BBLocation3/Location0.global_position
	#fighter0_active = true
	
#func _on_Fighters_fighter_index_1():
	#$BattleButtons.global_position = $BBLocation3/Location1.global_position
	
#func _on_Fighters_fighter_index_2():
	#$BattleButtons.global_position = $BBLocation3/Location2.global_position


func _input(event):
	var fighter_turn_used = $Fighters.get_turn_value()
	if (Input.is_action_just_pressed("ui_select")) and not BB_active and fighter_selection and attack_ended and not fighter_turn_used:
		BB_active = true
		$BattleButtons.show()
		$BattleButtons/AttackX.hide()
		$BattleButtons/MagicX.hide()
		$BattleButtons/ItemX.hide()
		$BattleButtons/AnimationPlayer.play("Initial")
		emit_signal("BB_active")
		
	if (Input.is_action_just_pressed("ui_down")) and BB_active and not defend_show and not magic_show and not item_show:
		defend_show = true
		attack_show = false
		magic_show = false
		item_show = false
		item_halt = true
		$BattleButtons/SpadeB.hide()
		$BattleButtons/DiamondB.show()
		$BattleButtons/CloverB.show()
		$BattleButtons/StarB.show()
		$DefenseWindow.show()
		$WindowPlayer.play("defense_open")
		$EnemyInfo.hide()
		emit_signal("hide_enemy_cursor")
		emit_signal("index_reset")
		emit_signal("attack_inactive")
		emit_signal("defend_active")
		if defend_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_down")) and BB_active and magic_show or item_show:
		defend_show = false
		emit_signal("defend_inactive")
		$BattleButtons/SpadeB.show()
		$DefenseWindow.hide()
		
	if (Input.is_action_just_pressed("ui_up")) and BB_active and magic_show or defend_show:
		item_show = false
		item_halt = true
		$BattleButtons/CloverB.show()
		$ItemWindow.hide()
		
	if (Input.is_action_just_pressed("ui_right")) and BB_active and not attack_show and not ongoing:
		attack_show = true
		magic_show = false
		defend_show = false
		item_show = false
		item_halt = false
		$BattleButtons/DiamondB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/CloverB.show()
		$BattleButtons/StarB.show()
		$EnemyInfo.show()
		$WindowPlayer.play("enemyinfo_open")
		$MagicWindow.hide()
		$ItemWindow.hide()
		$DefenseWindow.hide()
		emit_signal("attack_active")
		emit_signal("item_inactive")
		if attack_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_select")) and BB_active and attack_show and not fighter_turn_used:
		$BattleButtons/DiamondB.show()
		$BattleButtons.hide()
		$EnemyInfo.hide()
		BB_active = false
		attack_show = false
		window_open = false
		attack_ended = false
		emit_signal("attack_chosen")
			
	if (Input.is_action_just_pressed("ui_left")) and BB_active and not magic_show:
		magic_show = true
		item_halt = true
		attack_show = false
		defend_show = false
		item_show = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		$BattleButtons/StarB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/CloverB.show()
		$BattleButtons/DiamondB.show()
		$MagicWindow.show()
		$WindowPlayer.play("magic_open")
		$EnemyInfo.hide()
		$DefenseWindow.hide()
		if magic_show and not window_open:
			window_open = true
		
	if (Input.is_action_just_pressed("ui_up")) and BB_active and not item_show and not item_halt:
		item_show = true
		attack_show = false
		defend_show = false
		magic_show = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
		emit_signal("item_active")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		$BattleButtons/CloverB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/StarB.show()
		$BattleButtons/DiamondB.show()
		$ItemWindow.show()
		$WindowPlayer.play("item_open")
		$EnemyInfo.hide()
		$DefenseWindow.hide()
		$MagicWindow.hide()
		if item_show and not window_open:
			window_open = true

	#if (Input.is_action_just_pressed("ui_push")) and BB_active:

func _on_ItemInventory_go_to_Defend():
	defend_show = true
	attack_show = false
	magic_show = false
	item_show = false
	item_halt = true
	$BattleButtons/SpadeB.hide()
	$BattleButtons/DiamondB.show()
	$BattleButtons/CloverB.show()
	$BattleButtons/StarB.show()
	$DefenseWindow.show()
	$WindowPlayer.play("defense_open")
	$EnemyInfo.hide()
	emit_signal("hide_enemy_cursor")
	emit_signal("index_reset")
	emit_signal("attack_inactive")
	emit_signal("defend_active")
	if defend_show and not window_open:
		window_open = true

func _on_Menu_Cursor_go_to_Item():
		item_show = true
		attack_show = false
		defend_show = false
		magic_show = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
		emit_signal("item_active")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		$BattleButtons/CloverB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/StarB.show()
		$BattleButtons/DiamondB.show()
		$ItemWindow.show()
		$WindowPlayer.play("item_open")
		$EnemyInfo.hide()
		$DefenseWindow.hide()
		$MagicWindow.hide()
		if item_show and not window_open:
			window_open = true

#Defend Actions
func _on_Defend_cursor_selected():
	emit_signal("action_ongoing")
	if defend_show:
		$DefenseWindow.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons.hide()
		emit_signal("f_turn_used")
		emit_signal("defend_chosen")
		defend_show = false
		item_halt = false
		BB_active = false
		fighter_selection = false
		attack_ended = true
		yield(get_tree().create_timer(1), "timeout")
		emit_signal("action_ended")
	#if f_turns == f_array_size:
		#fighters_enabled = false
		#enemies_enabled = true
	
func _on_Flee_cursor_selected():
	if defend_show:
		$HUDS.hide()
		$DefenseWindow.hide()
		$BattleButtons.hide()
		$FleeDialogue.show()
		defend_show = false
		BB_active = false
		emit_signal("flee_chosen")
		$WindowPlayer.play("flee_dia_open")
		$FadeRect/AnimationPlayer.play("Flee")
		yield(get_tree().create_timer(2.3), "timeout")
		get_tree().quit()
	
func _on_Enemies_enemy_chosen():
	emit_signal("f_turn_used")
	tween = create_tween()
	var fighter_node = $Fighters.get_f_current()
	var enemy_position = $Enemies.get_e_position() + Vector2(-55, -8)
	tween.tween_property(fighter_node, "position", enemy_position, 0.5)
	yield(tween, "finished")
	emit_signal("start_attack_timer")
	$Fighters.fighter_attack()
	fighter_selection = false
	
func _on_Fighters_anim_finish():
	var f_name = $Fighters.get_f_name()
	if f_name == "irina":
		yield(get_tree().create_timer(1.5), "timeout")
		$Enemies.enemy_damage()
	else:
		yield(get_tree().create_timer(2.5), "timeout")
		$Enemies.enemy_damage()
	
func _on_Enemies_e_damage_finish():
	#var f_array_size = $Fighters.f_array_size()
	var fighter_node = $Fighters.get_f_current()
	var fighter_index = $Fighters.get_f_index()
	var fighter_position = $Fighters.get_position()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	tween = create_tween()
	tween.tween_property(fighter_node, "position", fighter_OG_position, 0.5)
	yield(tween, "finished")
	attack_ended = true
	#if f_turns == f_array_size:
		#fighters_enabled = false
		#enemies_enabled = true
	emit_signal("f_index_reset")

func _on_WorldRoot_f_turn_used():
	f_turns += 1
	
func _on_Enemies_victory():
	yield(get_tree().create_timer(0.3), "timeout")
	$HUDS.hide()
	$VictoryWindow.show()
	$WindowPlayer.play("victory_open")
	$Fighters.victory()

func _on_ItemInventory_item_chosen():
	ongoing = true
	emit_signal("action_ongoing")
	emit_signal("f_turn_used")
	var fighter_position = $Fighters.get_f_position() + Vector2(40, -40)
	var item_id = $ItemWindow.get_item_id()
	$ItemUsage.position = fighter_position
	yield(get_tree().create_timer(0.3), "timeout")
	$Fighters.item_used()
	if item_id == "Yummy Cake":
		$ItemUsage/Item.frame = 0
	if item_id == "Pretty Gem":
		$ItemUsage/Item.frame = 1
	#if item_show:
	$ItemWindow.hide()
	$BattleButtons/CloverB.show()
	$BattleButtons.hide()
	item_show = false
	item_halt = false
	BB_active = false
	fighter_selection = false
	attack_ended = true
	$ItemUsage.show()
	$ItemUsage/ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.2), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/PoofPlayer.play("Poof")
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("action_ended")
	ongoing = false
