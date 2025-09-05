extends Node2D

#onready var player_instance = PlayerManager.player_instance
var stats_showing = false
var able = false

func _ready():
	$AnimationPlayer.play("open")
	
func _process(delta):
	if $MainSelection/MenuCursor.menu_name == "Party" and not stats_showing:
		$Members.show()
		$Items.hide()
		$Items.reset()
		$Trinkets.hide()
	if $MainSelection/MenuCursor.menu_name == "Items":
		$Items.show()
		$Members.hide()
		$Members.party_selecting = false
		$Trinkets.hide()
		$Trinkets.reset()
	if $MainSelection/MenuCursor.menu_name == "Trinkets":
		$Trinkets.show()
		$Items.hide()
		$Items.reset()
		$Enemies.hide()
		$Enemies.reset()
	if $MainSelection/MenuCursor.menu_name == "Enemies":
		$Enemies.show()
		$Trinkets.hide()
		$Trinkets.reset()
		$Map.hide()
	if $MainSelection/MenuCursor.menu_name == "Map":
		$Map.show()
		$Enemies.hide()
		$Enemies.reset()
		$Key.hide()
	if $MainSelection/MenuCursor.menu_name == "Key":
		$Map.hide()
		$Key.show()
		
	#if Input.is_action_pressed("ui_pause") and PlayerManager.freeze and able:
	#	get_tree().paused = false
		#able = false
		#$AnimationPlayer.play("open")
		

func _on_MemberOptionsCursor_show_stats():
	$Members.hide()
	$MemberOptions.hide()
	$Stats.show()
	stats_showing = true
	yield(get_tree().create_timer(0.2), "timeout")
	$MemberOptions/VBoxOptions/MemberOptionsCursor.down_count = 0
	$MemberOptions/VBoxOptions/MemberOptionsCursor.stats_active = true

func _on_MemberOptionsCursor_retread():
	$Stats.hide()
	$Members.show()
	$MainSelection/MenuCursor.hide()
	stats_showing = false

func _on_MenuCursor_retread():
	$MemberOptions.hide()

func _on_TrinketsInventory_trinket_chosen():
	$Members/HP.hide()
	$Members/Trinkets.show()

func _on_TrinketsInventory_return_to_trinkets():
	yield(get_tree().create_timer(0.3), "timeout")
	$Members/HP.show()
	$Members/Trinkets.hide()
	SceneManager.transitioning = false
