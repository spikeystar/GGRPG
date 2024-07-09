extends Path2D

var timer = 0
export var spawn_time : float

export var follower : PackedScene

func _process(delta):
	timer = timer + delta
	
	if (timer > spawn_time):
		var new_follower = follower.instance()
		new_follower.global_position = $SpawnPosition.position
		add_child(new_follower)
		new_follower.global_position = $SpawnPosition.position
		timer = 0
		
