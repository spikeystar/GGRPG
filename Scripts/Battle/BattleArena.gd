extends Node

#export(tscn) var enemy = null
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")

#onready var player_instance = PlayerManager.player_instance
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
var enemy_selecting = false
var victory_ended = false
var wimpy = false
var dizzy = false

onready var party_members : int
onready var party_id : int

signal index_reset()
signal index_resetzero()
signal BB_active()
signal defend_chosen()
signal flee_chosen()
signal attack_active()
signal attack_inactive()
signal attack_chosen()
signal magic_active()
signal magic_inactive()
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
signal item_removed()
signal update_party

func _ready():
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.ease_in()
	$DefenseWindow.hide()
	$BattleButtons.hide()
	$BattleButtons.position = Vector2(0,0)
	$ItemWindow.hide()
	$MagicWindow.hide()
	$BattleDialogue.hide()
	$Enemies/EnemyInfo.hide()
	$Enemies/EnemyMove.hide()
	$FleeDialogue.hide()
	#player_instance.queue_free()

	
#Window Display
func hide_cursors():
	if BB_active:
		emit_signal("BB_active")
		
func _on_Fighters_fighters_active():
		fighter_selection = true
		
func _on_Fighters_BB_move():
	var BB_position = $Fighters.get_BB_position()
	$BattleButtons.position = BB_position
		

func _input(event):
	var fighter_turn_used = $Fighters.get_turn_value()
	if (Input.is_action_just_pressed("ui_select")) and not BB_active and fighter_selection and attack_ended and not fighter_turn_used and not ongoing and not enemy_selecting:
		BB_active = true
		$BattleButtons.show()
		$BattleButtons/AttackX.hide()
		$BattleButtons/MagicX.hide()
		$BattleButtons/ItemX.hide()
		$BattleButtons/AnimationPlayer.play("Initial")
		emit_signal("BB_active")
		
	if (Input.is_action_just_pressed("ui_down")) and BB_active and not defend_show and not magic_show and not item_show and not enemy_selecting:
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
		$Enemies/EnemyInfo.hide()
		emit_signal("hide_enemy_cursor")
		emit_signal("index_reset")
		emit_signal("item_inactive")
		emit_signal("attack_inactive")
		emit_signal("magic_inactive")
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
		
	if (Input.is_action_just_pressed("ui_right")) and BB_active and not attack_show and not ongoing and not wimpy:
		attack_show = true
		magic_show = false
		defend_show = false
		item_show = false
		item_halt = false
		$BattleButtons/DiamondB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/CloverB.show()
		$BattleButtons/StarB.show()
		$Enemies/EnemyInfo.show()
		$WindowPlayer.play("enemyinfo_open")
		$MagicWindow.hide()
		$ItemWindow.hide()
		$DefenseWindow.hide()
		emit_signal("index_resetzero")
		emit_signal("attack_active")
		emit_signal("item_inactive")
		emit_signal("magic_inactive")
		if attack_show and not window_open:
			window_open = true
			
	if (Input.is_action_just_pressed("ui_select")) and BB_active and attack_show and not fighter_turn_used and not ongoing:
		$BattleButtons/DiamondB.show()
		$BattleButtons.hide()
		$Enemies/EnemyInfo.hide()
		BB_active = false
		attack_show = false
		window_open = false
		attack_ended = false
		emit_signal("attack_chosen")
			
	if (Input.is_action_just_pressed("ui_left")) and BB_active and not magic_show and not dizzy:
		magic_show = true
		item_halt = true
		attack_show = false
		defend_show = false
		item_show = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
		emit_signal("magic_active")
		emit_signal("item_inactive")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		$BattleButtons/StarB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/CloverB.show()
		$BattleButtons/DiamondB.show()
		$MagicWindow.show()
		$WindowPlayer.play("magic_open")
		$Enemies/EnemyInfo.hide()
		$ItemWindow.hide()
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
		emit_signal("magic_inactive")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		$BattleButtons/CloverB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/StarB.show()
		$BattleButtons/DiamondB.show()
		$ItemWindow.show()
		$WindowPlayer.play("item_open")
		$Enemies/EnemyInfo.hide()
		$DefenseWindow.hide()
		$MagicWindow.hide()
		if item_show and not window_open:
			window_open = true

	if Input.is_action_just_pressed("ui_select") and victory_ended:
		var transition = TransitionPlayer.instance()
		get_tree().get_root().add_child(transition)
		transition.ease_out()
		BattleMusic.fade_out()
		yield(get_tree().create_timer(1), "timeout")
		transition.queue_free()
		BattleMusic.switch_songs()
		get_tree().paused = false
		Global.battle_ended = true

##### RETURN BUTTON ########

	if (Input.is_action_just_pressed("ui_accept")) and BB_active and not ongoing:
		$Fighters.idle()
		$BattleButtons/CloverB.show()
		$BattleButtons/SpadeB.show()
		$BattleButtons/StarB.show()
		$BattleButtons/DiamondB.show()
		$BattleButtons.hide()
		$ItemWindow.hide()
		$Enemies/EnemyInfo.hide()
		$DefenseWindow.hide()
		$MagicWindow.hide()
		$Fighters.BB_active = false
		$Enemies.BB_active = false
		$Fighters.fighter_index = -1
		$Fighters.select_next_fighter(+1)
		BB_active = false
		item_show = false
		attack_show = false
		defend_show = false
		magic_show = false
		window_open = false
		attack_ended = true
		enemy_selecting = false
		ongoing = false
		fighter_selection = false
		emit_signal("index_resetzero")
		emit_signal("hide_enemy_cursor")
		emit_signal("item_inactive")
		emit_signal("magic_inactive")
		emit_signal("attack_inactive")
		emit_signal("defend_inactive")
		
		
##### RETURN BUTTON END ########
	
func _on_SpellList_go_to_Defend():
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
	$MagicWindow.hide()
	$Enemies/EnemyInfo.hide()
	emit_signal("hide_enemy_cursor")
	emit_signal("index_reset")
	emit_signal("attack_inactive")
	emit_signal("defend_active")
	if defend_show and not window_open:
		window_open = true

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
	$Enemies/EnemyInfo.hide()
	emit_signal("hide_enemy_cursor")
	emit_signal("index_reset")
	emit_signal("attack_inactive")
	emit_signal("magic_inactive")
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
		emit_signal("magic_inactive")
		$BattleButtons/CloverB.hide()
		$BattleButtons/SpadeB.show()
		$BattleButtons/StarB.show()
		$BattleButtons/DiamondB.show()
		$ItemWindow.show()
		$WindowPlayer.play("item_open")
		$Enemies/EnemyInfo.hide()
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
		emit_signal("defend_inactive")
		defend_show = false
		item_halt = false
		BB_active = false
		fighter_selection = false
		attack_ended = true
		yield(get_tree().create_timer(0.7), "timeout")
		emit_signal("action_ended")
		$Fighters.fighters_active_check()
	#if f_turns == f_array_size:
		#fighters_enabled = false
		#enemies_enabled = true
	
func _on_Flee_cursor_selected():
	if defend_show:
		$Fighters/HUDS.hide()
		$DefenseWindow.hide()
		$BattleButtons.hide()
		$FleeDialogue.show()
		defend_show = false
		BB_active = false
		emit_signal("flee_chosen")
		emit_signal("defend_inactive")
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
		$Enemies.f_attack = $Fighters.get_f_attack()
		$Enemies.f_attack_base = $Fighters.get_f_attack_base()
		$Enemies.enemy_damage()
	else:
		yield(get_tree().create_timer(2.5), "timeout")
		$Enemies.f_attack = $Fighters.get_f_attack()
		$Enemies.f_attack_base = $Fighters.get_f_attack_base()
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
	$Fighters.sp_recovery()
	yield(get_tree().create_timer(0.5), "timeout")
	attack_ended = true
	#yield(get_tree().create_timer(0.2), "timeout")
	$Fighters.ongoing = false
	#if f_turns == f_array_size:
		#fighters_enabled = false
		#enemies_enabled = true
	emit_signal("f_index_reset")
	$Fighters.fighters_active_check()

func _on_WorldRoot_f_turn_used():
	f_turns += 1
	
func _on_Enemies_victory():
	yield(get_tree().create_timer(1.2), "timeout")
	BattleMusic.switch_songs()
	BattleMusic.id = "Victory"
	BattleMusic.music()
	yield(get_tree().create_timer(0.2), "timeout")
	ongoing = true
	$Fighters.ongoing = true
	$Fighters.halt = true
	$Fighters/HUDS.hide()
	$VictoryWindow.show()
	$WindowPlayer.play("victory_open")
	$Fighters.hide_cursors_remote()
	$Fighters.victory()
	victory_ended = true
	emit_signal("update_party")

##### Item Usage #####

func _on_ItemInventory_item_chosen():
	ongoing = true
	emit_signal("action_ongoing")
	#emit_signal("f_turn_used")
	$ItemWindow.hide()
	$BattleButtons/CloverB.show()
	$BattleButtons.hide()
	item_show = false
	item_halt = false
	BB_active = false
	
func _on_ItemInventory_battle_item_chosen():
	ongoing = true
	enemy_selecting = true
	$Fighters.idle()
	emit_signal("action_ongoing")
	$ItemWindow.hide()
	$BattleButtons.hide()
	item_show = false
	item_halt = false
	BB_active = false
	attack_show = true
	magic_show = false
	defend_show = false
	$BattleButtons/SpadeB.show()
	$BattleButtons/CloverB.show()
	$BattleButtons/StarB.show()
	$Enemies/EnemyInfo.show()
	$WindowPlayer.play("enemyinfo_open")
	$MagicWindow.hide()
	$ItemWindow.hide()
	$DefenseWindow.hide()
	#emit_signal("index_resetzero")
	emit_signal("item_inactive")
	emit_signal("magic_inactive")
	if attack_show and not window_open:
		window_open = true
		
func _on_ItemInventory_all_battle_item_chosen():
	ongoing = true
	$Fighters.ongoing = true
	$Fighters.halt = true
	$Fighters.idle()
	emit_signal("action_ongoing")
	$ItemWindow.hide()
	$BattleButtons.hide()
	item_show = false
	item_halt = false
	BB_active = false
	attack_show = true
	magic_show = false
	defend_show = false
	$BattleButtons/SpadeB.show()
	$BattleButtons/CloverB.show()
	$BattleButtons/StarB.show()
	$MagicWindow.hide()
	$ItemWindow.hide()
	$DefenseWindow.hide()
	#emit_signal("index_resetzero")
	emit_signal("item_inactive")
	emit_signal("magic_inactive")
	if attack_show and not window_open:
		window_open = true
	
func item_animation():
	$ItemUsage.show()
	$ItemUsage/ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.2), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/PoofPlayer.play("Poof")
	yield(get_tree().create_timer(1), "timeout")
	
func _on_Fighters_item_chosen():
	var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var item_id = $ItemWindow/ItemWindowPanel/ItemInventory.item_id
	$ItemUsage.position = selector_position
	yield(get_tree().create_timer(0.3), "timeout")
	if item_id == "Yummy Cake":
		$ItemUsage/Item.frame = 0
		$Fighters.heal = true
		$Fighters.HP_amount = 50
	if item_id == "Pretty Gem":
		$ItemUsage/Item.frame = 1
		$Fighters.SP = true
		$Fighters.SP_amount = 20
	if item_id == "Picnic Pie":
		$ItemUsage/Item.frame = 2
		$Fighters.all_heal = true
		$Fighters.HP_amount = 100
	if item_id == "Sugar Pill":
		$ItemUsage/Item.frame = 3
		$Fighters.heal = true
		$Fighters.HP_amount = 30
		$Fighters.buff()
	if item_id == "Ginger Tea":
		$ItemUsage/Item.frame = 4
		$Fighters.restore = true
		$Fighters.item_name = "Ginger Tea"
	if item_id == "Bounty Herb":
		$ItemUsage/Item.frame = 5
		$Fighters.restore = true
		$Fighters.revive = true
		$Fighters.item_name = "Bounty Herb"
	if item_id == "Remedy Bouquet":
		$ItemUsage/Item.frame = 5
		$Fighters.remedy_b = true
		$Fighters.item_name = "Remedy Bouquet"
	if item_id == "Perfect Panacea":
		$ItemUsage/Item.frame = 5
		$Fighters.perfect_p = true
		$Fighters.item_name = "Perfect Panacea"
	$Fighters.item_used()
	item_animation()
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("action_ended")
	fighter_selection = false
	attack_ended = true
	ongoing = false
	Party.remove_item()
	emit_signal("item_removed")
	#$Fighters.fighters_active_check()

func _on_Enemies_item_chosen():
	$EnemyInfo.hide()
	var fighter_position = $Fighters.get_f_position() + Vector2(40, -40)
	var item_id = $ItemWindow/ItemWindowPanel/ItemInventory.item_id
	$ItemUsage.position = fighter_position
	yield(get_tree().create_timer(0.3), "timeout")
	if item_id == "Spikey Bomb":
		$ItemUsage/Item.frame = 0
		$Enemies.item_damage = 100
	$Fighters.battle_item_used()
	$Enemies.battle_item_used()
	item_animation()
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("action_ended")
	fighter_selection = false
	attack_ended = true
	attack_show = false
	#ongoing = false
	#$Fighters.ongoing = false

func _on_Enemies_jinx_doll():
	$Enemies/EnemyInfo.hide()
	var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var item_id = $ItemWindow.get_item_id()
	$ItemUsage.position = selector_position
	if item_id == "Jinx Doll":
		$ItemUsage/Item.frame = 1
	yield(get_tree().create_timer(0.3), "timeout")
	$Fighters.battle_item_used()
	$Enemies.jinx_doll()
	item_animation()
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("action_ended")
	fighter_selection = false
	attack_ended = true
	attack_show = false
	Party.remove_item()
	emit_signal("item_removed")
	ongoing = false
	$Fighters.ongoing = false

func _on_Enemies_e_item_finished():
	Party.remove_item()
	emit_signal("item_removed")
	ongoing = false
	$Fighters.ongoing = false
	$Fighters.halt = false
	$Fighters.fighters_active_check()
	
	
func _on_SpellList_spell_chosen():
	enemy_selecting = true
	$Fighters.idle()
	attack_show = true
	magic_show = false
	defend_show = false
	item_show = false
	item_halt = false
	$BattleButtons/DiamondB.show()
	$BattleButtons/SpadeB.show()
	$BattleButtons/CloverB.show()
	$BattleButtons/StarB.show()
	$Enemies/EnemyInfo.show()
	$WindowPlayer.play("enemyinfo_open")
	$MagicWindow.hide()
	$ItemWindow.hide()
	$DefenseWindow.hide()
	emit_signal("index_resetzero")
	emit_signal("item_inactive")
	if attack_show and not window_open:
		window_open = true
		
func _on_SpellList_ally_spell_chosen():
	emit_signal("action_ongoing")
	ongoing = true
	fighter_selection = true
	$Fighters.idle()
	attack_show = false
	magic_show = false
	defend_show = false
	item_show = false
	item_halt = true
	BB_active = false
	$BattleButtons/DiamondB.show()
	$BattleButtons/SpadeB.show()
	$BattleButtons/CloverB.show()
	$BattleButtons/StarB.show()
	$BattleButtons.hide()
	$MagicWindow.hide()
	$ItemWindow.hide()
	$DefenseWindow.hide()
	emit_signal("index_resetzero")
	emit_signal("item_inactive")

func _on_Enemies_single_enemy_spell():
	ongoing = true
	emit_signal("action_ongoing")
	$Enemies/EnemyInfo.hide()
	var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var spell_id = $MagicWindow.get_spell_id()
	print(spell_id)
	yield(get_tree().create_timer(0.3), "timeout")
	if spell_id == "Earthslide":
		Earthslide()
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.idle()
	$Enemies.f_magic = $Fighters.get_f_magic()
	$Enemies.f_magic_base = $Fighters.get_f_magic_base()
	$Enemies.magic_damage()
	emit_signal("f_turn_used")
	emit_signal("magic_inactive")
	$Fighters.fighters_active_check()
	
func _on_Enemies_all_enemy_spell():
	emit_signal("action_ongoing")
	$Enemies/EnemyInfo.hide()
	var spell_id = $MagicWindow.get_spell_id()
	print(spell_id)
	yield(get_tree().create_timer(0.3), "timeout")
	ongoing = true
	if spell_id == "Thunderstorm":
		Thunderstorm()
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.idle()
	$Enemies.f_magic = $Fighters.get_f_magic()
	$Enemies.f_magic_base = $Fighters.get_f_magic_base()
	$Enemies.all_magic_damage()
	emit_signal("f_turn_used")
	emit_signal("magic_inactive")
	
	
func _on_Fighters_ally_spell_chosen():
	var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var target_position = $Fighters.get_target_position() + Vector2(40, -40)
	var spell_id = $MagicWindow.get_spell_id()
	yield(get_tree().create_timer(0.3), "timeout")
	if spell_id == "Sweet Gift":
		$Fighters.Sweet_gift()
	if spell_id == "Blossom":
		$Fighters.Blossom()
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("action_ended")
	fighter_selection = false
	attack_ended = true
	ongoing = false
	$Fighters.ongoing = false
	$Fighters.BB_active = false
	$Fighters.magic_selecting = false
	item_halt = false
	BB_active = false
	$Fighters.fighters_active_check()
	
	
func _on_Enemies_e_magic_damage_finish():
	var fighter_node = $Fighters.get_f_current()
	var fighter_position = $Fighters.get_position()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	tween = create_tween()
	tween.tween_property(fighter_node, "position", fighter_OG_position, 0.5)
	yield(tween, "finished")
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("f_index_reset")
	ongoing = false
	$Fighters.ongoing = false
	emit_signal("action_ended")
	attack_ended = true
	fighter_selection = false
	attack_show = false
	$Fighters.BB_active = false
	$Fighters.magic_selecting = false
	BB_active = false
	enemy_selecting = false
	$Fighters.fighters_active_check()
	
	
	##### Magic Spells ######
	
func Earthslide():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var fighter_node = $Fighters.get_f_current()
	var fighter_position = $Fighters.get_position()
	var enemy_position = $Enemies.get_e_position() + Vector2(-175, 40)
	$Enemies.damage_type = "earth"
	tween = create_tween()
	tween.tween_property(fighter_node, "position", enemy_position, 0.5)
	yield(tween, "finished")
	$Fighters.spell_2()
	var stun = rng.randi_range(0.0,1.0)
	if stun < 0.3:
		$Enemies.stun = true
	
	
func Thunderstorm():
	$Enemies.damage_type = "air"
	$Enemies.stun = true
	$Enemies.stun_chance = 0.3
	
	
	##### Enemy Attacks #####
	
func _on_Enemies_Basic():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.move_spread = "single"
	$Fighters.e_move_base = 1
	$Fighters.e_attack = $Enemies.e_attack
	$Fighters.e_magic = $Enemies.e_magic
	#var stun = rng.randi_range(0.0,1.0)
	#if stun < 0.3:
		#$Fighters.stun = true
	$Fighters.damage()


func _on_Enemies_Barrage():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.move_spread = "all"
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$Fighters.e_magic = $Enemies.e_magic
	for x in range($Fighters.fighters.size() -1):
		#var stun = rng.randi_range(0.0,1.0)
		#if stun < 0.3:
			#$Fighters.stun = true
		$Fighters.fighter_x = x
		$Fighters.damage()

