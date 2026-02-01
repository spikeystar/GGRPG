extends Path2D

var timer = 0
export var spawn_time : float

export var follower : PackedScene

export var cannon = false

export var flip = false

func _process(delta):
	
	timer = timer + delta
	
	if (timer > spawn_time):
		var new_follower = follower.instance()
		
		if cannon and flip:
			new_follower.flip = true

		
		new_follower.global_position = $SpawnPosition.global_position
		self.add_child(new_follower)
		timer = 0
		
		if cannon:
			$Poof/AnimationPlayer.play("spawn")
			SE.effect("Drama Thud")
			
			
				
