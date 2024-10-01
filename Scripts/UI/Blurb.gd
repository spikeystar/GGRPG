extends Sprite

var able = false
signal done

func _process(delta):
	if visible:
		yield(get_tree().create_timer(3), "timeout")
		able = true
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able:
		SE.effect("Select")
		visible = false
		emit_signal("done")
