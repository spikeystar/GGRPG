extends Node

#export(tscn) var enemy = null
const TransitionPlayer = preload("res://UI/BattleTransition.tscn")
const PixelationPlayer = preload("res://UI/PixelationTransition.tscn")
export(String, FILE, "*.tscn,*.scn") var main_menu

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
var item_stolen = false
var new_spell = false

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
signal magic_enemy_update

func _ready():
	SceneManager.victory = false
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
	yield(get_tree().create_timer(1.3), "timeout")
	transition.queue_free()
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
		$BattleButtons.show()
		$BattleButtons/AttackX.hide()
		$BattleButtons/MagicX.hide()
		$BattleButtons/ItemX.hide()
		$BattleButtons/AnimationPlayer.play("Initial")
		emit_signal("BB_active")
		wimpy = $Fighters.get_wimpy()
		if wimpy:
			$BattleButtons/AttackX.show()
		dizzy = $Fighters.get_dizzy()
		if dizzy:
			$BattleButtons/MagicX.show()
		if item_stolen:
			$BattleButtons/ItemX.show()
		yield(get_tree().create_timer(0.1), "timeout")
		BB_active = true
		
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
		
	if (Input.is_action_just_pressed("ui_up")) and BB_active and not item_show and not item_halt and not item_stolen:
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
		
	if Input.is_action_just_pressed("ui_select") and new_spell:
		new_spell = false
		$LevelUpWindow.hide()
		$VictoryWindow.hide()
		$NewSpellWindow.show()
		$WindowPlayer.playback_speed = 0.9
		$WindowPlayer.play("new_spell_open")
		if PartyStats.new_spell_2:
			$NewSpellWindow/NewSpell.text = "Gary learned \"Earthslide\"!"
			yield(get_tree().create_timer(2.5), "timeout")
			$WindowPlayer.play("new_spell_open")
			$NewSpellWindow/NewSpell.text = "Jacques learned \"Prism Snow\"!"
			yield(get_tree().create_timer(2), "timeout")
			PartyStats.new_spell_2 = false
			victory_ended = true
		

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
		item_halt = false
		attack_show = false
		defend_show = false
		magic_show = false
		window_open = false
		attack_ended = true
		enemy_selecting = false
		ongoing = false
		#fighter_selection = false
		$Fighters.fighters_active = true
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
		yield(get_tree().create_timer(2), "timeout")
		#BattleMusic.fade_out()
		#BattleMusic.switch_songs()
		get_tree().paused = false
		Global.battle_ended = true
	
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
		$Enemies.whammy_chance = $Fighters.get_status("whammy_chance")
		$Enemies.f_attack = $Fighters.get_f_attack()
		$Enemies.f_attack_base = $Fighters.get_f_attack_base()
		$Enemies.enemy_damage()
	else:
		yield(get_tree().create_timer(2.5), "timeout")
		$Enemies.whammy_chance = $Fighters.get_status("whammy_chance")
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
	emit_signal("f_index_reset")
	$Fighters.fighters_active_check()
	#emit_signal("f_index_reset")

func _on_WorldRoot_f_turn_used():
	f_turns += 1
	
func _on_Enemies_victory():
	var EXP_reward = int(EXP_base + (rand_range(0.05, 0.2) * EXP_base))
	var marbles_reward = int(marbles_base + (rand_range(0.05, 0.2) * marbles_base))
	PartyStats.party_exp += EXP_reward
	Party.marbles += marbles_reward
	yield(get_tree().create_timer(1.2), "timeout")
	BattleMusic.switch_songs()
	BattleMusic.id = "Victory"
	BattleMusic.music()
	yield(get_tree().create_timer(0.2), "timeout")
	ongoing = true
	$Fighters.ongoing = true
	$Fighters.halt = true
	$Fighters/HUDS.hide()
	$VictoryWindow/MarblesReward.text = str(marbles_reward)
	$VictoryWindow/EXPReward.text = str(EXP_reward)
	$VictoryWindow.show()
	$WindowPlayer.play("victory_open")
	
	if PartyStats.party_exp >= PartyStats.next_level:
		PartyStats.party_level += 1
		PartyStats.party_exp -= PartyStats.next_level
		PartyStats.level_check()
		$LevelUpWindow.show()
		$LevelUpWindow.scale = Vector2(1.05, 1.04)
		yield(get_tree().create_timer(0.1), "timeout")
		$LevelUpWindow.scale = Vector2(1.1, 1.09)
		$WindowPlayer.play("Level_up_text")
	
	$Fighters.hide_cursors_remote()
	$Fighters.victory()
	emit_signal("update_party")
	if PartyStats.new_spell_2:	
		new_spell = true
	else:
		victory_ended = true
	
func _on_Fighters_game_over():
	ongoing = true
	yield(get_tree().create_timer(1.5), "timeout")
	#BattleMusic.fade_out()
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.hide()
	var pixelation = PixelationPlayer.instance()
	get_tree().get_root().add_child(pixelation)
	pixelation.pixelate()
	yield(get_tree().create_timer(0.3), "timeout")
	transition.slow_down()
	transition.ease_out()
	yield(get_tree().create_timer(0.05), "timeout")
	transition.show()
	yield(get_tree().create_timer(3.5), "timeout")
	transition.queue_free()
	pixelation.queue_free()
	get_tree().paused = false
	Global.battle_ended = true
	get_tree().change_scene(main_menu)
	#PlayerManager.remove_player_from_scene()
	#PlayerManager.call_deferred("add_player_to_scene")

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
	yield(get_tree().create_timer(0.3), "timeout")
	$ItemUsage.show()
	$ItemUsage/ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.2), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/PoofPlayer.play("Poof")
	yield(get_tree().create_timer(1), "timeout")
	
func _on_Fighters_item_chosen():
	fighter_selection = false
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
		$Fighters.random_buff()
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
	$MagicWindow.hide()
	$ItemWindow.hide()
	$DefenseWindow.hide()
	emit_signal("index_resetzero")
	emit_signal("item_inactive")
	if attack_show and not window_open:
		window_open = true
	emit_signal("magic_enemy_update")
	yield(get_tree().create_timer(0.01), "timeout")
	$WindowPlayer.play("enemyinfo_open")
	$Enemies/EnemyInfo.show()
		
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
	var debuff_move = false
	$Fighters/HUDS.hiding()
	ongoing = true
	emit_signal("action_ongoing")
	$Enemies/EnemyInfo.hide()
	#var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var spell_id = $MagicWindow.get_spell_id()
	yield(get_tree().create_timer(0.3), "timeout")
	if spell_id == "Earthslide":
		Earthslide()
		debuff_move = true
		yield(get_tree().create_timer(1.7), "timeout")
	if spell_id == "Icicle":
		Icicle()
		debuff_move = true
	if spell_id == "Precious Beam":
		Precious_Beam()
		debuff_move = true
		yield(get_tree().create_timer(2.5), "timeout")
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.idle()
	$Enemies.whammy_chance = $Fighters.get_status("whammy_chance")
	$Enemies.f_magic = $Fighters.get_f_magic()
	$Enemies.f_magic_base = $Fighters.get_f_magic_base()
	$Enemies.fighter_type = $Fighters.get_status("type")
	$Enemies.magic_damage()
	emit_signal("f_turn_used")
	emit_signal("magic_inactive")
	emit_signal("f_index_reset")
	if debuff_move:
		yield(get_tree().create_timer(1.7), "timeout")
		$Fighters.fighters_active_check()
	else:
		$Fighters.fighters_active_check()
	
func _on_Enemies_all_enemy_spell():
	$Fighters/HUDS.hiding()
	emit_signal("action_ongoing")
	var spell_id = $MagicWindow.get_spell_id()
	yield(get_tree().create_timer(0.01), "timeout")
	$Enemies/EnemyInfo.hide()
	yield(get_tree().create_timer(0.3), "timeout")
	ongoing = true
	if spell_id == "Thunderstorm":
		Thunderstorm()
		yield(get_tree().create_timer(1.5), "timeout")
	if spell_id == "Prism Snow":
		Prism_Snow()
		yield(get_tree().create_timer(1.2), "timeout")
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.idle()
	$Enemies.whammy_chance = $Fighters.get_status("whammy_chance")
	$Enemies.f_magic = $Fighters.get_f_magic()
	$Enemies.f_magic_base = $Fighters.get_f_magic_base()
	$Enemies.fighter_type = $Fighters.get_status("type")
	$Enemies.all_magic_damage()
	emit_signal("f_turn_used")
	emit_signal("magic_inactive")
	emit_signal("f_index_reset")
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.fighters_active_check()
	
	
func _on_Fighters_ally_spell_chosen():
	var selector_position = $Fighters.get_selector_position() + Vector2(40, -40)
	var target_position = $Fighters.get_target_position() + Vector2(40, -40)
	var spell_id = $MagicWindow.get_spell_id()
	yield(get_tree().create_timer(0.3), "timeout")
	if spell_id == "Sweet Gift":
		Sweet_Gift()
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
	
	
func _on_Enemies_e_magic_damage_finish():
	$Fighters/HUDS.showing()
	var fighter_node = $Fighters.get_f_current()
	var fighter_position = $Fighters.get_position()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	tween = create_tween()
	tween.tween_property(fighter_node, "position", fighter_OG_position, 0.5)
	yield(tween, "finished")
	yield(get_tree().create_timer(0.3), "timeout")
	ongoing = false
	$Fighters.ongoing = false
	emit_signal("action_ended")
	attack_ended = true
	#fighter_selection = false
	attack_show = false
	$Fighters.BB_active = false
	$Fighters.magic_selecting = false
	BB_active = false
	enemy_selecting = false
	
	#$Fighters.fighters_active_check()
	
	
	##### Magic Spells ######
func Sweet_Gift():
	var target_position = $Fighters.get_target_position() 
	$MovePlayer.position = target_position + Vector2(2, -60)
	$Fighters.fighter_index = $Fighters.selector_index
	$Fighters.spell_1()
	yield(get_tree().create_timer(0.8), "timeout")
	$MovePlayer/AnimPlayer.play("Sweet_Gift")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.battle_ready()
	yield(get_tree().create_timer(0.4), "timeout")
	$Fighters.Sweet_gift()
	$Fighters.fighters_active_check()
	
	
func Earthslide():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var fighter_node = $Fighters.get_f_current()
	var fighter_position = $Fighters.get_f_OG_position()
	var enemy_position = $Enemies.get_e_position() + Vector2(-175, 40)
	$Enemies.damage_type = "earth"
	$Enemies.move_type = "earth"
	$Enemies.f_magic_base = 50
	tween = create_tween()
	tween.tween_property(fighter_node, "position", enemy_position, 0.5)
	yield(tween, "finished")
	$Fighters.spell_2()
	yield(get_tree().create_timer(0.7), "timeout")
	$WindowPlayer.play("little_shake")
	$MovePlayer.position = enemy_position + Vector2(60, 15)
	$MovePlayer/AnimPlayer.play("Earthslide")
	$Enemies.a_debuff = true
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.idle()
	var tween2 = create_tween()
	tween2.tween_property(fighter_node, "position", fighter_position, 0.5)
	
func Icicle():
	var enemy_position = $Enemies.get_e_position()
	$Enemies.damage_type = "water"
	$Enemies.move_type = "water"
	$Enemies.f_magic_base = 30
	$Enemies.d_debuff = true
	$Fighters.spell_1()
	yield(get_tree().create_timer(0.5), "timeout")
	$MovePlayer.position = enemy_position + Vector2(-30, -120)
	$MovePlayer/AnimPlayer.play("Icicle")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.battle_ready()
	
func Precious_Beam():
	$WindowPlayer.playback_speed = 1.2
	$WindowPlayer.play("darken")
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var fighter_node = $Fighters.get_f_current()
	var fighter_position = $Fighters.get_f_OG_position()
	var enemy_position = $Enemies.get_e_position() + Vector2(-127, 21)
	$Enemies.damage_type = "fire"
	$Enemies.move_type = "fire"
	$Enemies.f_magic_base = 50
	tween = create_tween()
	tween.tween_property(fighter_node, "position", enemy_position, 0.5)
	yield(tween, "finished")
	$Fighters.spell_2()
	yield(get_tree().create_timer(3.5), "timeout")
	$Enemies.m_debuff = true
	#yield(get_tree().create_timer(1), "timeout")
	$Fighters.idle()
	var tween2 = create_tween()
	tween2.tween_property(fighter_node, "position", fighter_position, 0.5)
	$WindowPlayer.playback_speed = 1
	$WindowPlayer.play_backwards("darken")
	
func Thunderstorm():
	$WindowPlayer.playback_speed = 1.2
	$WindowPlayer.play("darken")
	$MovePlayer.position = Vector2(0,0)
	$Enemies.damage_type = "air"
	$Enemies.move_type = "air"
	$Enemies.f_magic_base = 20
	$Enemies.stun = true
	$Enemies.stun_chance = 20
	yield(get_tree().create_timer(0.2), "timeout")
	$Fighters.spell_1()
	yield(get_tree().create_timer(1), "timeout")
	$MovePlayer/AnimPlayer.playback_speed = 0.6
	$MovePlayer/AnimPlayer.play("Thunderstorm")
	yield(get_tree().create_timer(1.6), "timeout")
	$WindowPlayer.playback_speed = 1
	$WindowPlayer.play_backwards("darken")
	
func Prism_Snow():
	$WindowPlayer.playback_speed = 1.2
	$WindowPlayer.play("darken")
	$MovePlayer.position = Vector2(0,0)
	$Enemies.damage_type = "water"
	$Enemies.move_type = "water"
	$Enemies.f_magic_base = 30
	$Enemies.multi_debuff = true
	yield(get_tree().create_timer(0.2), "timeout")
	$Fighters.spell_2()
	yield(get_tree().create_timer(0.6), "timeout")
	$MovePlayer/AnimPlayer.play("Prism_Snow")
	yield(get_tree().create_timer(1.6), "timeout")
	$WindowPlayer.playback_speed = 1
	$WindowPlayer.play_backwards("darken")
	
	
	##### Enemy Attacks #####
func _on_Enemies_update_move_window():
	$Fighters/HUDS.hiding()
	
func _on_Enemies_Basic():
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.move_spread = "single"
	$Fighters.e_move_base = 1
	$Fighters.e_attack = $Enemies.e_attack
	$Fighters.e_magic = $Enemies.e_magic
	$Fighters.damage()

func _on_Enemies_Barrage():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.d_debuff = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 5
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(30, -5)
	$MovePlayer/AnimPlayer.play("Barrage")
	yield(get_tree().create_timer(1.1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Beat_Down():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.enemy_type = $Enemies.get_type()
	for x in $Enemies.enemies.size():
		$Fighters.e_move_base += 5
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(-2, -12)
	$MovePlayer/AnimPlayer.play("Beat_Down")
	yield(get_tree().create_timer(1.1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Sting():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.poison = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(240, -97)
	$MovePlayer/AnimPlayer.play("Sting")
	yield(get_tree().create_timer(1.2), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Sabotage():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.wimpy = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(24, -9)
	$MovePlayer/AnimPlayer.play("Sabotage")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Pester():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.anxious = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(20, -60)
	$MovePlayer/AnimPlayer.play("Pester")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Extort():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "neutral"
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$Fighters.sp_loss = true
	$Fighters.SP_amount = int(PartyStats.party_max_sp * 0.1)
	$MovePlayer.position = fighter_OG_position + Vector2(0, -10)
	$MovePlayer/AnimPlayer.play("Extort")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Slash():
	$Fighters.move_spread = "spread"
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$MovePlayer.position = Vector2(0, 0)
	$MovePlayer/AnimPlayer.play("Slash")
	yield(get_tree().create_timer(1), "timeout")
	for x in range ($Fighters.fighters.size()):
		$Fighters.move_kind = "attack"
		$Fighters.move_type = "neutral"
		$Fighters.enemy_type = $Enemies.get_type()
		$Fighters.e_move_base = 15
		$Fighters.e_attack = $Enemies.e_attack
		var a_debuff = rng.randi_range(1, 100)
		if a_debuff <= 25:
			$Fighters.a_debuff = true
		$Fighters.fighter_index = x
		$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()
	yield(get_tree().create_timer(0.7), "timeout")
	$Fighters.damage_end()

func _on_Enemies_Splat():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "magic"
	$Fighters.move_type = "neutral"
	$Fighters.m_debuff = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_magic = $Enemies.e_magic
	$MovePlayer.position = fighter_OG_position + Vector2(125, -82)
	$MovePlayer/AnimPlayer.play("Splat")
	yield(get_tree().create_timer(1.2), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Asphyxiate():
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "magic"
	$Fighters.move_type = "neutral"
	$Fighters.dizzy = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_magic = $Enemies.e_magic
	$MovePlayer.position = fighter_OG_position + Vector2(-6, -27)
	$MovePlayer/AnimPlayer.play("Asphyxiate")
	yield(get_tree().create_timer(1.8), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Bubble_Ring():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "magic"
	$Fighters.move_type = "water"
	var dizzy = rng.randi_range(1, 100)
	if dizzy <= 50:
		$Fighters.dizzy = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_magic = $Enemies.e_magic
	$MovePlayer.position = fighter_OG_position + Vector2(260, -154)
	$MovePlayer/AnimPlayer.play("Bubble_Ring")
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Stream_Strike():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "water"
	var d_debuff = rng.randi_range(1, 100)
	if d_debuff <= 50:
		$Fighters.d_debuff = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 15
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(247, -95)
	$MovePlayer/AnimPlayer.play("Stream_Strike")
	yield(get_tree().create_timer(2), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Friction():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	var fighter = $Fighters.get_f_current()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "fire"
	var stun = rng.randi_range(1, 100)
	if stun <= 30:
		$Fighters.stun = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(5, -35)
	$MovePlayer/AnimPlayer.play("Friction")
	var og_color : Color
	og_color.r = 1
	og_color.g = 1
	og_color.b = 1
	var modulate_color : Color
	modulate_color.r = 1
	modulate_color.g = 0.25
	modulate_color.b = 0
	var tween = create_tween()
	tween.tween_property(fighter, "modulate", modulate_color, 0.8)
	yield(get_tree().create_timer(1), "timeout")
	var tween2 = create_tween()
	tween2.tween_property(fighter, "modulate", og_color, 0.7)
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Aero_Bullet():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "air"
	var chance = rng.randi_range(1, 100)
	if chance <= 50:
		$Fighters.m_debuff = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(240, -93)
	$MovePlayer/AnimPlayer.play("Aero_Bullet")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Squall():
	$Fighters.move_spread = "spread"
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$MovePlayer.position = Vector2(0, 0)
	$MovePlayer/AnimPlayer.play("Squall")
	yield(get_tree().create_timer(1.5), "timeout")
	for x in range ($Fighters.fighters.size()):
		$Fighters.move_kind = "attack"
		$Fighters.move_type = "air"
		$Fighters.enemy_type = $Enemies.get_type()
		$Fighters.e_move_base = 15
		$Fighters.e_attack = $Enemies.e_attack
		var chance = rng.randi_range(1, 100)
		if chance <= 30:
			$Fighters.random_debuff = true
		$Fighters.fighter_index = x
		$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()
	yield(get_tree().create_timer(0.7), "timeout")
	$Fighters.damage_end()

func _on_Enemies_Zap():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "magic"
	$Fighters.move_type = "air"
	var chance = rng.randi_range(1, 100)
	if chance <= 50:
		$Fighters.dizzy = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_magic = $Enemies.e_magic
	$MovePlayer.position = fighter_OG_position + Vector2(240, -90)
	$MovePlayer/AnimPlayer.play("Zap")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()


func _on_Enemies_Terra_Arrow():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Fighters.move_spread = "single"
	$Fighters.pick_fighter()
	var fighter_OG_position = $Fighters.get_f_OG_position()
	$Fighters.move_kind = "attack"
	$Fighters.move_type = "earth"
	var chance = rng.randi_range(1, 100)
	if chance <= 50:
		$Fighters.a_debuff = true
	$Fighters.enemy_type = $Enemies.get_type()
	$Fighters.e_move_base = 10
	$Fighters.e_attack = $Enemies.e_attack
	$MovePlayer.position = fighter_OG_position + Vector2(240, -93)
	$MovePlayer/AnimPlayer.play("Terra_Arrow")
	yield(get_tree().create_timer(1), "timeout")
	$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()

func _on_Enemies_Gravel_Spat():
	$Fighters.move_spread = "spread"
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$MovePlayer.position = Vector2(0, 0)
	$MovePlayer/AnimPlayer.play("Gravel_Spat")
	$WindowPlayer.play("Gravel_Spat")
	yield(get_tree().create_timer(1.5), "timeout")
	for x in range ($Fighters.fighters.size()):
		$Fighters.move_kind = "attack"
		$Fighters.move_type = "earth"
		$Fighters.enemy_type = $Enemies.get_type()
		$Fighters.e_move_base = 15
		$Fighters.e_attack = $Enemies.e_attack
		var chance = rng.randi_range(1, 100)
		if chance <= 25:
			$Fighters.wimpy = true
		$Fighters.fighter_index = x
		$Fighters.damage()
	yield(get_tree().create_timer(1), "timeout")
	$Fighters/HUDS.showing()
	yield(get_tree().create_timer(0.7), "timeout")
	$Fighters.damage_end()
