extends Node2D

onready var player_instance = PlayerManager.player_instance
var stats_showing = false

func _ready():
	pass
	#player_instance.queue_free()
	
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

func _on_MemberOptionsCursor_show_stats():
	$Members.hide()
	$MemberOptions.hide()
	$Stats.show()
	stats_showing = true

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
