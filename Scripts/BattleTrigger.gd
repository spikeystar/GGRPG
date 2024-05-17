extends Area2D

var player = null
var detected = false
export var height = 0.0
signal triggered

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _physics_process(delta):
	pass

func player_check():
	return player !=null

#func _on_BattleTrigger_body_entered(body):
	#player = body

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		_on_touch_area()
	
func _on_touch_area():
	disconnect("body_entered", self, "_on_body_entered")
	emit_signal("triggered")
