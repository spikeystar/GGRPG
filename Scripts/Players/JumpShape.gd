extends KinematicBody2D

func _process(delta):
	if Global.jumping:
		$JumpShape.set_deferred("disabled", false)
	if not Global.jumping:
		$JumpShape.set_deferred("disabled", true)
