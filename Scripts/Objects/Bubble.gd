extends YSort

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not PlayerManager.freeze:
		queue_free()
