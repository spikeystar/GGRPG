extends Area2D

var player = null
export var detected = false
export var height = 0.0
export var able : bool = false
var player_height
var ground_enemy : bool
var entered = false
var viable = false

var printer = false

signal triggered

func _ready():
	#connect("body_exited", self, "_on_body_exited")
	position.y += height
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
	yield(get_tree().create_timer(1), "timeout")
	viable = true

func _physics_process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	if int(height) < player_height and ground_enemy:
		able = false
	if int(height) == player_height and ground_enemy:
		able = true
	#if not ground_enemy and int(player_height) >= int(height-70) or int(player_height) == int(height):
		#able = true
	#if not ground_enemy and int(player_height) <= int(height-80):
		#able = false
		
	if not ground_enemy and int(player_height) in range (int(height-30), int(height)):
		able = true
		
	if able and entered and not detected and viable and ground_enemy and not Global.battling:
		_on_touch_area()
		

func player_check():
	return player !=null

#func _on_BattleTrigger_body_entered(body):
	#player = body

func _on_body_entered(body):
	#if "is_player_motion_root" in body and body.is_player_motion_root and not Global.battle_ended and able:
		#_on_touch_area()
		#detected = true
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not Global.battle_ended and able and not PlayerManager.freeze and viable:
		_on_touch_area()
		detected = true
		
	if "is_player_motion_root" in body and body.is_player_motion_root and not Global.battle_ended and not PlayerManager.freeze:
		entered = true
		
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		entered = false
	
func _on_touch_area():
	detected = true
	entered = false
	disconnect("body_entered", self, "_on_body_entered")
	emit_signal("triggered")
	
#func _on_body_exited(body):
	#if "is_player_jump_shape" in body and body.is_player_jump_shape and not Global.battle_ended and able and not PlayerManager.freeze:
		#detected = false
		
func _on_BattleTrigger_body_entered(_name):
	pass
