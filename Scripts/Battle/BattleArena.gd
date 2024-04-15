extends Node

#export(tscn) var enemy = null

onready var player_instance = PlayerManager.player_instance
var window_open = false
var defend_show = false
var attack_show = false
var magic_show = false
var item_show = false
var defending = false
var BB_active = false
var item_halt = false

onready var party_members : int
onready var party_id : int
var fighters : Array = []

var party_formation_1 = false
var party_formation_2 = false
var party_formation_3 = false

signal index_reset()
signal index_resetzero()

func _ready():
	#set_health($HUDS/ProgressBar, Party.current_health, Party.max_health)
	$Cheribo_battle/AnimationPlayer.play("enemy_idle")
	$DefenseWindow.hide()
	$BattleButtons.hide()
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

func _set_position():
	fighters = $Fighters.get_children()
	if party_id == 1 and party_formation_3:
		$PartyFormation3/Fighter1.position
		
	if party_id == 2 and party_formation_3:
		$PartyFormation3/Fighter2.position
		
	if party_id == 3 and party_formation_3:
		$PartyFormation3/Fighter3.position

	
#func set_health(progress_bar, current_health, max_health):
	#progress_bar.value = current_health
	#progress_bar.max_value = max_health
	#progress_bar.get_node("Gary Health").text = "%d/%d" % [current_health, max_health]
	
#Window Display
func _input(event):
	if (Input.is_action_just_pressed("ui_select")) and not BB_active:
		BB_active = true
		$BattleButtons.show()
		$BattleButtons/AttackX.hide()
		$BattleButtons/MagicX.hide()
		$BattleButtons/ItemX.hide()
		$BattleButtons/AnimationPlayer.play("Initial")
		$Gary_Battle/AnimationPlayer.play("Fighter_Turn")
		
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
		#$WindowPlayer.play("enemyinfo_open")
		$WindowPlayer.play("cursor_idle")
		$MagicWindow.hide()
		$ItemWindow.hide()
		$DefenseWindow.hide()
		if attack_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_left")) and BB_active and not magic_show:
		magic_show = true
		item_halt = true
		attack_show = false
		defend_show = false
		item_show = false
		emit_signal("index_resetzero")
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
		$Gary_Battle/AnimationPlayer.play("Fighter_Defend")
		$BattleButtons/SpadeB.show()
		$BattleButtons.hide()
		defend_show = false
		BB_active = false
	
func _on_Flee_cursor_selected():
	if defend_show:
		$HUDS.hide()
		$DefenseWindow.hide()
		$BattleButtons.hide()
		$FleeDialogue.show()
		$WindowPlayer.play("flee_dia_open")
		$Gary_Battle/AnimationPlayer.play("Fighter_Flee")
		$FadeRect/AnimationPlayer.play("Flee")
		yield(get_tree().create_timer(2.3), "timeout")
		get_tree().quit()

