extends Path2D

var timer = 0
export var spawn_time : float

export var follower : PackedScene

export var cannon = false

func _process(delta):
	timer = timer + delta
	
	if (timer > spawn_time):
		var new_follower = follower.instance()
		new_follower.global_position = $SpawnPosition.position
		add_child(new_follower)
		timer = 0
		
		if cannon:
			$Poof/AnimationPlayer.play("spawn")
			SE.effect("Drama Thud")
