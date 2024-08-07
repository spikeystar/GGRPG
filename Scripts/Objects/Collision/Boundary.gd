extends StaticBody2D

export var height : int

func _process(delta):
	if int(PlayerManager.player_instance.body_sprite.height) > height:
		$Boundary.disabled = true
	if int(PlayerManager.player_instance.body_sprite.height) == height:
		$Boundary.disabled = false

	#print(int(PlayerManager.player_instance.body_sprite.height))
