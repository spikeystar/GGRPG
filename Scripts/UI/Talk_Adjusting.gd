extends Label

func _process(delta):
	if text.length() <= 5:
		$Talk.margin_left = int(11.5 * text.length())
	if text.length() > 5:
		$Talk.margin_left = int(10.5 * text.length())
