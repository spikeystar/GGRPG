extends Path2D

var timer = 0
export var spawn_time : float

export var follower : PackedScene

func _process(delta):
	timer = timer + delta
	
	if (timer > spawn_time) and not SceneManager.bubble:
		var new_follower = follower.instance()
		new_follower.global_position = $SpawnPosition.position
		add_child(new_follower)
		timer = 0
