extends Node2D

onready var player_instance = PlayerManager.player_instance

func _ready():
	player_instance.queue_free()
	
func _process(delta):
	if $MainSelection/MenuCursor.menu_name == "Party":
		$Members.show()
		$Items.hide()
		$Trinkets.hide()
	if $MainSelection/MenuCursor.menu_name == "Items":
		$Items.show()
		$Members.hide()
		$Members.party_selecting = false
		$Trinkets.hide()
	if $MainSelection/MenuCursor.menu_name == "Trinkets":
		$Trinkets.show()
		$Items.hide()
		$Enemies.hide()
	if $MainSelection/MenuCursor.menu_name == "Enemies":
		$Enemies.show()
		$Trinkets.hide()
		$Map.hide()
	if $MainSelection/MenuCursor.menu_name == "Map":
		$Map.show()
		$Enemies.hide()
		$Key.hide()
	if $MainSelection/MenuCursor.menu_name == "Key":
		$Map.hide()
		$Key.show()

func _on_MemberOptionsCursor_show_stats():
	$Members.hide()
	$MemberOptions.hide()
	$Stats.show()

func _on_MemberOptionsCursor_retread():
	$Stats.hide()
	$MainSelection/MenuCursor.main_active = false
	$MainSelection/MenuCursor.hide()

func _on_MenuCursor_retread():
	$MemberOptions.hide()

func _on_TrinketsInventory_trinket_chosen():
	$Members/HP.hide()
	$Members/Trinkets.show()

func _on_TrinketsInventory_return_to_trinkets():
	yield(get_tree().create_timer(0.3), "timeout")
	$Members/HP.show()
	$Members/Trinkets.hide()