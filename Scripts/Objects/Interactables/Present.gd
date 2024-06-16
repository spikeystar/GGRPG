extends Node2D

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer
export var item_name : String
signal item_get

var is_opened = false

func _ready():
	if not Global.Collected.has(global_position):
		animation_player.play("Idle")
		collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")
		set_item()
	else:
		animation_player.play("Done")


func _on_bumped_from_bottom():
	yield(get_tree().create_timer(0.1), "timeout")
	animation_player.play("Open Box")
	animation_player.playback_speed = 1.0
	collidable_box.disconnect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	is_opened = true
	item_get()
	emit_signal("item_get")
	yield(get_tree().create_timer(0.1), "timeout")
	item_animation()
	

func item_animation():
	$ItemUsage.show()
	$ItemUsage/ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.2), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/PoofPlayer.play("Poof")
	yield(get_tree().create_timer(1), "timeout")
	
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Item_Get")
		Party.add_item_name = item_name
		Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
	
func set_item():
	if item_name == "Yummy Cake":
		$ItemUsage/Item.frame = 0
