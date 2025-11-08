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

export var flowing = false
export var flowing_name: String

var is_ready = false
var is_opened = false
var bumpable = false

func _ready():		
	is_ready = true
	
	square_shadow.modulate = shadow_color
	square_shadow.update_mesh()

	if not Engine.editor_hint:

		_calculate_box_position()

		if not Global.Collected.has(global_position) and not Global.Collected.has(flowing_name):
			animation_player.play("Idle")
			collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")
		else:
			animation_player.play("Done")
			
	var timer = Timer.new()
	add_child(timer)
	timer.start(1)
	timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	bumpable = true
	
func _process(delta):
	if flowing:
		$CollidableBox._generate_meshes()

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
	if bumpable:
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
	if not Global.Collected.has(global_position) or not Global.Collected.has(flowing_name):
		SE.effect("Present")
		Party.add_item_name = item_name
		if item_name == "Jhumki":
			Party.add_key_item_name = item_name
			Party.add_key_item()
		else:
			Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
		if flowing:
			Global.Collected.append(flowing_name)
	else:
		return
		
func trinket_get():
	if not Global.Collected.has(global_position) or not Global.Collected.has(flowing_name):
		SE.effect("Present")
		Party.trinket_get = true
		Party.add_trinket_name = item_name
		Party.add_trinket()
		emit_signal("item_get")
		Global.Collected.append(global_position)
		if flowing:
			Global.Collected.append(flowing_name)
	else:
		return
	
func marbles_get():
	if not Global.Collected.has(global_position) or not Global.Collected.has(flowing_name):
		SE.effect("Present")
		#Party.marbles += marbles_amount
		Party.marbles = clamp(Party.marbles + marbles_amount, 0, 999999)
		Party.marbles_get = true
		Party.add_item_name = str(marbles_amount) + " Marbles"
		emit_signal("item_get")
		Global.Collected.append(global_position)
		if flowing:
			Global.Collected.append(flowing_name)
	else:
		return
		
func full_heal():
	if not Global.Collected.has(global_position) or not Global.Collected.has(flowing_name):
		SE.effect("Full Heal")
		PartyStats.full_heal()
		Party.add_item_name = item_name
		emit_signal("item_get")
		Global.Collected.append(global_position)
		if flowing:
			Global.Collected.append(flowing_name)
	else:
		return
	
func set_item():
	if item_name == "Yummy Cake":
		$ItemUsage/Item.frame = 0
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Pretty Gem":
		$ItemUsage/Item.frame = 1
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Ginger Tea":
		$ItemUsage/Item.frame = 4
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Sugar Pill":
		$ItemUsage/Item.frame = 3
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Bounty Herb":
		$ItemUsage/Item.frame = 5
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Picnic Pie":
		$ItemUsage/Item.frame = 2
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
	if item_name == "Marbles":
		$ItemUsage/Item.frame = 11
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		marbles_get()
	if item_name == "Full Heal":
		$ItemUsage/Item.frame = 10
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		full_heal()
	if item_name == "Gold Earring":
		$ItemUsage/Item.frame = 8
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
	if item_name == "Jhumki":
		$ItemUsage/Item.frame = 90
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
				
	if item_name == "Remedy Bouquet":
		$ItemUsage/Item.frame = 58
		$ItemUsage/Item.position = Vector2(4, 4)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()
		
	if item_name == "Perfect Panacea":
		$ItemUsage/Item.frame = 57
		$ItemUsage/Item.position = Vector2(0.5, 5)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()
	
	if item_name == "Delicious Cake":
		$ItemUsage/Item.frame = 45
		$ItemUsage/Item.position = Vector2(0, 0)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
	
	if item_name == "Amazing Cake":
		$ItemUsage/Item.frame = 46
		$ItemUsage/Item.position = Vector2(0, 1)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
		
	if item_name == "Polar Parfait":
		$ItemUsage/Item.frame = 50
		$ItemUsage/Item.position = Vector2(0, 3)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Flummery Flambe":
		$ItemUsage/Item.frame = 49
		$ItemUsage/Item.position = Vector2(-1, 3)
		$ItemUsage/Item.scale = Vector2(0.92, 0.92)
		item_get()
		
	if item_name == "Saffron Souffle":
		$ItemUsage/Item.frame = 51
		$ItemUsage/Item.position = Vector2(0, 9)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
		
	if item_name == "Nori Cookie":
		$ItemUsage/Item.frame = 52
		$ItemUsage/Item.position = Vector2(0.5, 7)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Lovely Gem":
		$ItemUsage/Item.frame = 47
		$ItemUsage/Item.position = Vector2(3, 1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Beautiful Gem":
		$ItemUsage/Item.frame = 48
		$ItemUsage/Item.position = Vector2(0, 2)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
		
	if item_name == "Starberry":
		$ItemUsage/Item.frame = 55
		$ItemUsage/Item.position = Vector2(4, 3)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
		
	if item_name == "Icescream":
		$ItemUsage/Item.frame = 54
		$ItemUsage/Item.position = Vector2(-1, 3)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Hocus Potion":
		$ItemUsage/Item.frame = 63
		$ItemUsage/Item.position = Vector2(-2, 8)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Magic Mushroom":
		$ItemUsage/Item.frame = 56
		$ItemUsage/Item.position = Vector2(2, 5)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		item_get()
		
	if item_name == "Strange Perfume":
		$ItemUsage/Item.frame = 64
		$ItemUsage/Item.position = Vector2(6, 4)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()
		
	if item_name == "Jinx Doll":
		$ItemUsage/Item.frame = 65
		$ItemUsage/Item.position = Vector2(4, 4)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Spikey Bomb":
		$ItemUsage/Item.frame = 53
		$ItemUsage/Item.position = Vector2(2, 8)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()
		
	if item_name == "Blister Grenade":
		$ItemUsage/Item.frame = 59
		$ItemUsage/Item.position = Vector2(3, 3)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()

	if item_name == "Power Drill":
		$ItemUsage/Item.frame = 62
		$ItemUsage/Item.position = Vector2(3, 13)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()

	if item_name == "Faulty Amp":
		$ItemUsage/Item.frame = 61
		$ItemUsage/Item.position = Vector2(2, 10)
		$ItemUsage/Item.scale = Vector2(1, 1)
		item_get()
		
	if item_name == "Chilly Globe":
		$ItemUsage/Item.frame = 60
		$ItemUsage/Item.position = Vector2(-2, 11)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		item_get()
		
	if item_name == "Lucky Locket":
		$ItemUsage/Item.frame = 14
		$ItemUsage/Item.position = Vector2(3, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Beggar's Amulet":
		$ItemUsage/Item.frame = 15
		$ItemUsage/Item.position = Vector2(0, -1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Martyr's Medal":
		$ItemUsage/Item.frame = 16
		$ItemUsage/Item.position = Vector2(0, -1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Bottlecap":
		$ItemUsage/Item.frame = 17
		$ItemUsage/Item.position = Vector2(5, -1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Overdrive":
		$ItemUsage/Item.frame = 23
		$ItemUsage/Item.position = Vector2(1, 1)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		trinket_get()
		
	if item_name == "Ripple Ribbon":
		$ItemUsage/Item.frame = 27
		$ItemUsage/Item.position = Vector2(1, 5)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Toxic Barb":
		$ItemUsage/Item.frame = 28
		$ItemUsage/Item.position = Vector2(1, 3)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Shooting Star":
		$ItemUsage/Item.frame = 31
		$ItemUsage/Item.position = Vector2(2, 1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		trinket_get()
		
	if item_name == "Megaphone":
		$ItemUsage/Item.frame = 36
		$ItemUsage/Item.position = Vector2(-2, 0)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		trinket_get()
		
	if item_name == "Butterfly Charm":
		$ItemUsage/Item.frame = 14
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		trinket_get()
		
	if item_name == "Froggie Charm":
		$ItemUsage/Item.frame = 14
		$ItemUsage/Item.position = Vector2(-2, 1)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)
		trinket_get()
