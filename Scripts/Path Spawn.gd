extends Path2D

var timer = 0
export var spawn_time = 1.6

#var follower = preload("res://Enemies/Cherry Trail/Cheribo/Cheribo_path_follow.tscn")

#func _process(delta):
	#timer = timer + delta
	
	#if (timer > spawn_time):
		#var new_follower = follower.instance()
		#add_child(new_follower)
		#timer = 0
		
