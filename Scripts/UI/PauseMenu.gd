extends Node2D

onready var player_instance = PlayerManager.player_instance

func _ready():
	player_instance.queue_free()
	
func _process(delta):
	if $MainSelection/MenuCursor.menu_name == "Party":
		$Members.show()
		$Items.hide()
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

func _on_MenuCursor_retread():
	$MemberOptions.hide()
