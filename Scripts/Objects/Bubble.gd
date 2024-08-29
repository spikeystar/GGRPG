extends YSort

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not PlayerManager.freeze:
		if SceneManager.bubble:
			SE.effect("Bubble Pop")
		queue_free()
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not PlayerManager.freeze:
		if SceneManager.bubble:
			SE.effect("Bubble Pop")
		queue_free()
		
		
