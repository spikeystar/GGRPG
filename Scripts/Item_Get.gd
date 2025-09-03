extends Area2D

#onready var camera = get_tree().get_root().get_node("WorldRoot/Camera2D")
export var height = 0.0
export var item_name : String
signal item_get
var used = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not used:
		item_get()
		used = true
		
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Item_Get")
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
