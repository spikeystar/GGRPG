extends Area2D

var player = null
var detected = false

signal start_chase
signal stop_chase

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	$CollisionShape2D.set_deferred("disabled", false)


func _physics_process(delta):
	if get_overlapping_bodies().size() > 0 and detected:
		emit_signal("start_chase")
		
	if not detected:
		emit_signal("stop_chase")


func player_check():
	return player !=null

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not PlayerManager.freeze:
		player = body
		detected = true
		#emit_signal("start_chase")
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not PlayerManager.freeze:
		player = body
		detected = true

func _on_PlayerDetection_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		player = null
		detected = false
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape:
		player = null
		detected = false
		#emit_signal("stop_chase")
