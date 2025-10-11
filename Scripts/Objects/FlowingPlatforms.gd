extends Node2D

var timer = 0
export var spawn_time : float
export var speed : float

export var follower : PackedScene

func _ready():
	spawn()

func _process(delta):
	timer = timer + delta
	
	if (timer > spawn_time):
		spawn()
		timer = 0
		
func spawn():
	var new_follower = follower.instance()
	new_follower.global_position = $Spawn.position
	new_follower.end_position = $End.global_position
	new_follower.speed = speed
	add_child(new_follower)
	#var direction = ($Spawn.position - $End.position).normalized()
	#var distance = new_follower.position.distance_to(direction)
	#var velocity = direction * min(speed, distance_to_target / delta)

	#new_follower.queue_free()
