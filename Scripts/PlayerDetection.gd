extends Area2D

var player = null
var detected = false

signal start_chase

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	$CollisionShape2D.set_deferred("disabled", false)


func _physics_process(delta):
	pass

func player_check():
	return player !=null

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		player = body
		detected = true
		emit_signal("start_chase")

func _on_PlayerDetection_body_exited(body):
	player = null
	detected = false
