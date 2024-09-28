extends Area2D

export var height = 0.0
#export var event_name : String
signal area_event
var used = false
export var cutscene = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not used:
		used = true
		area_event()
		
func area_event():
	if not cutscene:
		SE.effect("Select")
	
	if not Global.Collected.has(global_position):
		PlayerManager.freeze = true
		emit_signal("area_event")
		Global.Collected.append(global_position)
	else:
		return
