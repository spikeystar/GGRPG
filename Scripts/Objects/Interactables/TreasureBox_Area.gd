extends Area2D

var area_height : int
var player_height
var able = false
var inside = false
var used = false

signal open_box

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	
	if not PlayerManager.freeze and not PlayerManager.jumping and player_height == area_height and not PlayerManager.floating:
		able = true
		
	if not player_height == area_height:
		able = false
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able and inside and not used:
		emit_signal("open_box")
		able = false
		inside = false
		used = true


func _on_Area2D_body_entered(body):
	if "is_player_jump_shape" in body and body.is_player_jump_shape:
		inside = true
		
func _on_Area2D_body_exited(body):
	if "is_player_jump_shape" in body and body.is_player_jump_shape:
		inside = false
		able = false
