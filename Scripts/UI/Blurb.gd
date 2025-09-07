extends Sprite

var able = false
var used = false
signal done

func _process(delta):
	if visible and not used:
		yield(get_tree().create_timer(3), "timeout")
		able = true
		
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able and not used:
		able = false
		used = true
		SE.effect("Select")
		SE.effect("Menu Open")
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.1)
		yield(get_tree().create_timer(0.1), "timeout")
		visible = false
		emit_signal("done")
