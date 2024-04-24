extends Node

#export(tscn) var enemy = null

onready var player_instance = PlayerManager.player_instance
onready var tween = $Tween
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
signal attack_chosen()
signal magic_active()
signal hide_enemy_cursor()


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
		
func _on_Fighters_fighter_index_0():
	$BattleButtons.global_position = $BBLocation3/Location0.global_position
	fighter0_active = true
	
func _on_Fighters_fighter_index_1():
	$BattleButtons.global_position = $BBLocation3/Location1.global_position
	
func _on_Fighters_fighter_index_2():
	$BattleButtons.global_position = $BBLocation3/Location2.global_position

func _input(event):
	if (Input.is_action_just_pressed("ui_select")) and not BB_active and fighter_selection:
		BB_active = true
		$BattleButtons.show()
		$BattleButtons/AttackX.hide()
		$BattleButtons/MagicX.hide()
		$BattleButtons/ItemX.hide()
		$BattleButtons/AnimationPlayer.play("Initial")
		emit_signal("BB_active")
		#$Fighters/Gary_Battle/AnimationPlayer.play("Fighter_Turn")
		#$Fighters/Jacques_Battle/AnimationPlayer.play("Fighter_Turn")
		#$Fighters/Irina_Battle/AnimationPlayer.play("Fighter_Turn")
		
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
		if defend_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_down")) and BB_active and magic_show or item_show:
		defend_show = false
		$BattleButtons/SpadeB.show()
		$DefenseWindow.hide()
		
	if (Input.is_action_just_pressed("ui_up")) and BB_active and magic_show or defend_show:
		item_show = false
		item_halt = true
		$BattleButtons/CloverB.show()
		$ItemWindow.hide()
		
	if (Input.is_action_just_pressed("ui_right")) and BB_active and not attack_show:
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
		if attack_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_select")) and BB_active and attack_show:
		$BattleButtons/DiamondB.show()
		$BattleButtons.hide()
		$EnemyInfo.hide()
		BB_active = false
		attack_show = false
		window_open = false
		emit_signal("attack_chosen")
			
	if (Input.is_action_just_pressed("ui_left")) and BB_active and not magic_show:
		magic_show = true
		item_halt = true
		attack_show = false
		defend_show = false
		item_show = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
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
	if defend_show:
		$DefenseWindow.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons.hide()
		emit_signal("defend_chosen")
		defend_show = false
		BB_active = false
	
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
	var tween = get_tree().create_tween()
	var fighter_node = $Fighters.get_f_current()
	var enemy_position = $Enemies.get_e_position()
	tween.tween_property(fighter_node, "position", fighter_node.position, enemy_position, 0.3, Tween.TRANS_LINEAR)
	tween.start()
	$Fighters.fighter_attack()
	
	
	
	#tween.tween_property($Fighters.f_current, "position", $Enemies.e_position, 0.3)
	#$Fighters.fighter_attack()
	#$Enemies.enemy_damage()
	
	
	#var f_position : Vector2 = $Fighters.current_f_position
	#var e_position : Vector2 = $Enemies.current_e_position
	#$Tween.tween_callback(f_position.queue_free)
