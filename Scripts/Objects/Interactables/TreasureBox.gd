extends Node2D

export var floor_height : int

export var item_name : String
export var marbles_amount : int

export var flowing : bool
export var flowing_name : String

signal quest_item

func _ready():
	$CollidableBox.floor_height = floor_height
	$Area2D.area_height = floor_height
	global_position.y += floor_height
	$Area2D.global_position = global_position


	if Global.Collected.has(global_position) or Global.Collected.has(flowing_name):
		$AnimationPlayer.play("opened")
		$Area2D.queue_free()


func _on_Area2D_open_box():
	if not Global.Collected.has(global_position) or not Global.Collected.has(flowing_name):
		PlayerManager.freeze = true
		SE.effect("Treasure Box")
		Party.add_item_name = item_name
		$AnimationPlayer.play("open")
		if item_name == "Jhumki" or item_name == "Lighthouse Key":
			Party.add_key_item_name = item_name
			Party.add_key_item()
		if item_name == "Beggar's Amulet":
			Party.trinket_get = true
			Party.add_trinket_name = item_name
			Party.add_trinket()
		if item_name == "Marbles":
			Party.marbles = clamp(Party.marbles + marbles_amount, 0, 999999)
			Party.marbles_get = true
			Party.add_item_name = str(marbles_amount) + " Marbles"
		else:
			Party.add_item()
		
		
		Global.Collected.append(global_position)
		if flowing:
			Global.Collected.append(flowing_name)
			
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("quest_item")
			
	else:
		return

