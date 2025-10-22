extends Area2D

export var height = 0.0
var gary_entered = false
signal signpost

var this_body = false
var able = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
	position.y += height

func _input(event):
	if event.is_action_pressed("ui_select") and get_overlapping_bodies().size() > 0 and not PlayerManager.freeze and SceneManager.ready_again and this_body:
		SE.effect("Menu Open")
		PlayerManager.freeze = true
		SceneManager.ready_again = false
		emit_signal("signpost")
	
func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		SceneManager.ready_again = true
		this_body = true

func _on_Signpost_body_exited(body):
	SceneManager.ready_again = false
	this_body = false
