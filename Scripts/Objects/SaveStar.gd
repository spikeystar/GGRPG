extends Area2D

export var height = 0.0
export var star_name : String
signal star_options
var this_body = false

func _ready():
	position.y += height
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_start_checking_body_entered")
	add_child(timer)
	timer.start(0.5)
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not this_body:
		this_body = true
		
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and this_body:
		this_body = false
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and this_body and not SceneManager.overworld and not PlayerManager.cutscene and not PlayerManager.jumping:
		SE.effect("Select")
		PlayerManager.freeze = true
		emit_signal("star_options")
