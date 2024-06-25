extends Sprite

var move_name : String

signal move_window_done

func _on_Enemies_update_move_window():
	if move_name == "Basic":
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("move_window_done")
	else:
		$Move_Name.text = move_name
		yield(get_tree().create_timer(0.5), "timeout")
		self.show()
		yield(get_tree().create_timer(1.2), "timeout")
		self.hide()
		emit_signal("move_window_done")
