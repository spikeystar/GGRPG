extends Node2D

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer
export var item_name : String
export var marbles_amount : int
export var location_height : int
signal item_get

var is_opened = false

func _ready():
	if not Global.Collected.has(global_position):
		animation_player.play("Idle")
		collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	else:
		animation_player.play("Done")
	$CollidableBox.present_height = location_height
	$CollidableBox.position = Vector2(0, (0.2 * location_height))


func _on_bumped_from_bottom():
	yield(get_tree().create_timer(0.1), "timeout")
	animation_player.play("Open Box")
	animation_player.playback_speed = 1.0
	collidable_box.disconnect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	is_opened = true
	set_item()
	#emit_signal("item_get")
	yield(get_tree().create_timer(0.1), "timeout")
	item_animation()
	

func item_animation():
	$ItemUsage.show()
	$ItemUsage/ItemPlayer.playback_speed = 0.9
	$ItemUsage/ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.4), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/PoofPlayer.play("Poof")
	$ItemUsage/ItemPlayer.playback_speed = 1
	yield(get_tree().create_timer(1), "timeout")
	
	
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Present")
		Party.add_item_name = item_name
		Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
	
func marbles_get():
	if not Global.Collected.has(global_position):
		SE.effect("Present")
		Party.marbles += marbles_amount
		Party.marbles_get = true
		Party.add_item_name = str(marbles_amount) + " Marbles"
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
		
func full_heal():
	if not Global.Collected.has(global_position):
		SE.effect("Full Heal")
		PartyStats.full_heal()
		Party.add_item_name = item_name
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
	
func set_item():
	if item_name == "Yummy Cake":
		$ItemUsage/Item.frame = 0
		item_get()
	if item_name == "Marbles":
		$ItemUsage/Item.frame = 11
		marbles_get()
	if item_name == "Full Heal":
		$ItemUsage/Item.frame = 10
		full_heal()
