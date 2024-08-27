extends Area2D

var player = null
var detected = false


func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	$CollisionShape2D.set_deferred("disabled", false)


func _physics_process(delta):
	if get_overlapping_bodies().size() > 0 and detected:
		SceneManager.bubble = true
		PlayerManager.bubble()
		
		

func player_check():
	return player !=null

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not PlayerManager.freeze and not SceneManager.bubble:
		player = body
		detected = true
		#emit_signal("start_chase")
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not PlayerManager.freeze and not SceneManager.bubble:
		player = body
		detected = true

func _on_PlayerDetection_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		pass
		#player = null
		#detected = false
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape:
		pass
		#player = null
		#detected = false
