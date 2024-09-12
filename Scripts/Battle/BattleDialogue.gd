extends Sprite

var length : int
var tween

func tween_go():
	length = $Name/Talk.text.length()
	if length <= 25:
		length = 25
	$Name/Talk.percent_visible = 0.0
	tween = create_tween()
	tween.tween_property($Name/Talk, "percent_visible", 1, (length/25))
	
func talk():
	yield(get_tree().create_timer((length/25)), "timeout")
	$DialogueCursor.show()
	
func window_show():
	show()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.2)
	
func window_hide():
	tween.tween_property(self, "modulate:a", 0, 0.2)
	yield(get_tree().create_timer(0.2), "timeout")
	hide()

func Reeler_Event():
	window_show()
	$Name.text = "Reeler:"
	$Name/Talk.text = "Hope you won't be needing these anymore!"
	tween_go()
	yield(get_tree().create_timer((1.5)), "timeout")
	var tween = create_tween()
	window_hide()
	
