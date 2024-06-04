extends Label
signal text_ready

func _process(delta):
	if percent_visible == 1:
		emit_signal("text_ready")
