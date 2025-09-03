extends Area2D

#onready var camera = get_tree().get_root().get_node("WorldRoot/Camera2D")
export var height = 0.0
export var item_name : String
signal item_get
var used = false
var able = false
var activated = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	position.y += height
	
func _process(delta):
	if height == int(PlayerManager.height) and not PlayerManager.jumping:
		able = true
	else:
		able = false
		
	if able and activated:
		item_get()

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and able:
		item_get()
		
	if "is_player_motion_root" in body and body.is_player_motion_root:
		activated = true
		
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		activated = false
		
func item_get():
	used = true
	if not Global.Collected.has(global_position):
		SE.effect("Item_Get")
		Party.add_item_name = item_name
		if item_name == "Jhumki":
			Party.add_key_item_name = item_name
			Party.add_key_item()
		else:
			Party.add_item()
		emit_signal("item_get")
		Global.Collected.append(global_position)
	else:
		return
