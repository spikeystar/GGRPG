extends KinematicBody2D

#func _physics_process(delta):
	#if PlayerManager.jumping:
		#$CollisionShape2D.set_deferred("disabled", false)
	#if not PlayerManager.jumping:
		#$CollisionShape2D.set_deferred("disabled", true)
