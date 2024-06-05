extends Area2D

onready var camera = get_tree().get_root().get_node("WorldRoot/Camera2D")
export var height = 0.0
export var item_name : String
signal item_get
var gary_entered = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and gary_entered:
		item_get()

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not gary_entered:
		gary_entered = true
		
		
func item_get():
	if not Global.Collected.has(global_position):
		SE.effect("Item_Get")
		Party.add_item_name = item_name
		Party.add_item()
		emit_signal("item_get")
		gary_entered = false
		Global.Collected.append(global_position)
	else:
		return
