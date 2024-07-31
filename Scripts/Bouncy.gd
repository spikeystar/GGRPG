extends Area2D

var entered = false
var player_height

export var height = 0.0
var body_check = false
var able = false

func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	position.y += height
	
func _process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	
	if body_check and int(height) == player_height:
		_on_touch_area()

#func _input(event):
	#if Input.is_action_just_pressed("ui_push") and able:
			#body_check = true

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		body_check = true
		#able = true
		#_on_touch_area()
			
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		body_check = false
		#able = false
	
func _on_touch_area():
	body_check = false
	SE.effect("Bouncy")
	PlayerManager.bouncy = true
	yield(get_tree().create_timer(1), "timeout")
	PlayerManager.bouncy = false
	#yield(get_tree().create_timer(1), "timeout")
	#PlayerManager.bouncy = false
	#disconnect("body_entered", self, "_on_body_entered")
	#yield(get_tree().create_timer(2), "timeout")
	
