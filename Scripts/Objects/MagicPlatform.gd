extends Area2D

var area_height
var player_height
var able = false
var inside = false

signal destruct

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	
	if not PlayerManager.freeze and not PlayerManager.jumping and player_height == area_height:
		able = true
	
	if able and inside:
		emit_signal("destruct")
		

func _on_Area2D_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		inside = true
		
	
