extends Area2D

var player = null
var detected = false
export var height = 0.0
export var able : bool = false
var player_height
var ground_enemy : bool

var printer = false

signal triggered

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _physics_process(delta):
	player_height = PlayerManager.player_motion_root.pos_z
	if height < player_height and ground_enemy:
		able = false
	if height == player_height and ground_enemy:
		able = true
	#if not ground_enemy and int(player_height) >= int(height-70) or int(player_height) == int(height):
		#able = true
	#if not ground_enemy and int(player_height) <= int(height-80):
		#able = false
		
	if not ground_enemy and int(player_height) in range (int(height-60), int(height)):
		able = true
	

func player_check():
	return player !=null

#func _on_BattleTrigger_body_entered(body):
	#player = body

func _on_body_entered(body):
	#if "is_player_motion_root" in body and body.is_player_motion_root and not Global.battle_ended and able:
		#_on_touch_area()
		#detected = true
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not Global.battle_ended and able:
		_on_touch_area()
		detected = true
	
func _on_touch_area():
	disconnect("body_entered", self, "_on_body_entered")
	emit_signal("triggered")

