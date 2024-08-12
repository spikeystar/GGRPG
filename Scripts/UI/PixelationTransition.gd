extends CanvasLayer

func pixelate():
	$AnimationPlayer.play("pixelate")
	$TextureRect.hide()
	yield(get_tree().create_timer(0.1), "timeout")
	$TextureRect.show()

func pixelate2():
	$AnimationPlayer.play("pixelate2")
	$TextureRect.hide()
	yield(get_tree().create_timer(0.1), "timeout")
	$TextureRect.show()
	
func reset():
	$AnimationPlayer.play("RESET")

func kill():
	self.queue_free()
