extends Area2D

export var height = 0.0
var gary_entered = false
signal interaction
export var NPC_name : String

func _ready():
	#var timer = Timer.new()
	#timer.one_shot = true
	#timer.connect("timeout", self, "_on_start_checking_body_entered")
	#add_child(timer)
	#timer.start(0.1)
	
	yield(get_tree().create_timer(0.01), "timeout")
	
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	position.y += height
	

#func _on_start_checking_body_entered():
	#connect("body_entered", self, "_on_body_entered")

func _input(event):
	if event.is_action_pressed("ui_select") and get_overlapping_bodies().size() > 0 and gary_entered and not PlayerManager.freeze:
		SE.effect("Select")
		PlayerManager.freeze = true
		_on_touch_area()
		gary_entered = false
	else:
		return
		#yield(get_tree().create_timer(1.5), "timeout")
	
func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		gary_entered = true
	
func _on_touch_area():
	#disconnect("body_entered", self, "_on_body_entered")
	emit_signal("interaction")
	
func _on_body_exited(body):
	pass

func _on_FerrisWheel_body_exited(body):
	gary_entered = false

func _on_EventOptions_no():
	if SceneManager.npc_name == NPC_name:
		yield(get_tree().create_timer(0.2), "timeout")
		gary_entered = true
		PlayerManager.freeze = false
	
func reset():
	gary_entered = true
	
