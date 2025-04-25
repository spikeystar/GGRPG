extends Area2D

export var height = 0.0
#export var event_name : String
signal area_event
var used = false
var gary = null
var activated = false
export var cutscene = false
export var unavoid = false

func _ready():
	#activated = false
	position.y += height
	yield(get_tree().create_timer(0.3), "timeout")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _process(delta):
	gary = PlayerManager.player_motion_root
	

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and gary.pos_z == height and not unavoid:
		used = true
		area_event()
		
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and not unavoid:
		activated = true
		
	if "is_player_motion_root" in body and body.is_player_motion_root and not used and unavoid:
		used = true
		area_event()
		
		
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and activated and not unavoid:
		activated = false
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and activated and gary.pos_z == height:
		used = true
		area_event()
		
func area_event():
	activated = false
	if not Global.Collected.has(global_position):
		if not cutscene:
			SE.effect("Select")
		
		PlayerManager.freeze = true
		emit_signal("area_event")
		Global.Collected.append(global_position)
		#activated = false
	else:
		return
