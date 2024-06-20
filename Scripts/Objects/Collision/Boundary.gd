extends StaticBody2D

func _process(delta):
	if PlayerManager.player_instance.body_sprite.height > 0:
		$Boundary.disabled = true
	if PlayerManager.player_instance.body_sprite.height == 0:
		$Boundary.disabled = false
