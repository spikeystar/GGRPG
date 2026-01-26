extends YSort

func delete():
	self.queue_free()

func _on_PlayerDetection_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not PlayerManager.freeze:
		$AnimationPlayer.play("destruct")
		
	if "is_player_jump_shape" in body and body.is_player_jump_shape and not PlayerManager.freeze:
		$AnimationPlayer.play("destruct")
