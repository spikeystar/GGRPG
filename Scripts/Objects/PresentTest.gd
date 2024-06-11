extends KinematicBody2D

func _process(delta):
	if Global.jumping:
		$CollisionShape2D.set_deferred("disable", false)
	if not Global.jumping:
		$CollisionShape2D.set_deferred("disable", true)
