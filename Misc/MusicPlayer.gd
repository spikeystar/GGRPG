extends AudioStreamPlayer

export var end_time : float
export var loop_time : float
var timing : float
var saved_time : float

func _process(delta):
	timing = get_playback_position()
	if timing >= end_time:
		seek(loop_time)
