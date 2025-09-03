tool
extends Node2D

signal item_get

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer
onready var square_shadow = $SquareShadow

export var item_name : String
export var marbles_amount : int
export var floor_height = 0.0 setget set_floor_height
export var box_height_above_floor = 95.0 setget set_box_height_above_floor
export(Color) var shadow_color = Color(0.0, 0.0, 0.0, 1.0) setget set_shadow_color

var is_ready = false
var is_opened = false

func _ready():
	is_ready = true
	
	square_shadow.modulate = shadow_color
	square_shadow.update_mesh()

	if not Engine.editor_hint:

		_calculate_box_position()

		if not Global.Collected.has(global_position):
			animation_player.play("Idle")
			collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")
		else:
			animation_player.play("Done")

func set_floor_height(new_floor_height):
	floor_height = new_floor_height
	if is_ready:
		_calculate_box_position()

func set_box_height_above_floor(new_box_height_above_floor):
	box_height_above_floor = new_box_height_above_floor
	if is_ready:
		_calculate_box_position()

func set_shadow_color(new_shadow_color):
	shadow_color = new_shadow_color
	if is_ready:
		square_shadow.modulate = shadow_color
		if not Engine.editor_hint:
			square_shadow.update_mesh()

func _calculate_box_position():
	if not Engine.editor_hint:
		collidable_box.floor_height = floor_height + box_height_above_floor
		collidable_box.position.y = floor_height
		square_shadow.height = floor_height + 0.5

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
	$ItemUsage/ItemPlayer.playback_speed = 0.9
	$ItemUsage/ItemPlayer.play("Item_Usage")
	$ItemUsage.show()
	yield(get_tree().create_timer(1.2), "timeout")
	$ItemUsage/Poof.show()
	$ItemUsage/Poof.position += Vector2(-1, -1)
	$ItemUsage/PoofPlayer.play("Poof")
	$ItemUsage/ItemPlayer.playback_speed = 1
	yield(get_tree().create_timer(1), "timeout")
	
	
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Present")
		Party.add_item_name = item_name
		if item_name == "X":
			Party.add_key_item_name = item_name
			Party.add_key_item()
		else:
			Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
		
func trinket_get():
	if not Global.Collected.has(global_position):
		SE.effect("Present")
		Party.trinket_get = true
		Party.add_trinket_name = item_name
		Party.add_trinket()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
	
func marbles_get():
	if not Global.Collected.has(global_position):
		SE.effect("Present")
		#Party.marbles += marbles_amount
		Party.marbles = clamp(Party.marbles + marbles_amount, 0, 999999)
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
	if item_name == "Pretty Gem":
		$ItemUsage/Item.frame = 1
		item_get()
	if item_name == "Ginger Tea":
		$ItemUsage/Item.frame = 4
		item_get()
	if item_name == "Sugar Pill":
		$ItemUsage/Item.frame = 3
		item_get()
	if item_name == "Bounty Herb":
		$ItemUsage/Item.frame = 5
		item_get()
	if item_name == "Picnic Pie":
		$ItemUsage/Item.frame = 2
		item_get()
	if item_name == "Marbles":
		$ItemUsage/Item.frame = 11
		marbles_get()
	if item_name == "Full Heal":
		$ItemUsage/Item.frame = 10
		full_heal()
	if item_name == "Gold Earring":
		$ItemUsage/Item.frame = 8
		trinket_get()
	if item_name == "X":
		$ItemUsage/Item.frame = 90
		item_get()
