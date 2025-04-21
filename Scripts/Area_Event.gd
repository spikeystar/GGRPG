extends Area2D

export var height = 0.0
#export var event_name : String
signal area_event
var used = false
var gary = null
#var activated = false
export var cutscene = false

func _ready():
	#activated = false
	position.y += height
	yield(get_tree().create_timer(0.3), "timeout")
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	gary = PlayerManager.player_motion_root
	

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and gary.pos_z == height:
		used = true
		#activated = true
		area_event()
		
		
func area_event():
	if not Global.Collected.has(global_position):
		if not cutscene:
			SE.effect("Select")
		
		PlayerManager.freeze = true
		emit_signal("area_event")
		Global.Collected.append(global_position)
		#activated = false
	else:
		return
