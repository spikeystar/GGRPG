extends Area2D

export var height = 0.0
#export var event_name : String
signal area_event
var used = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		area_event()
		
func area_event():
	SE.effect("Select")
	PlayerManager.freeze = true
	emit_signal("area_event")
