extends Sprite

onready var Enemies = get_tree().get_root().get_node("WorldRoot/Enemies")
var move_name : String

signal move_window_done

func get_move_name():
	#move_name = Enemies.pick_move()
	move_name = "Basic"
	return move_name

func _on_Enemies_update_move_window():
	move_name = get_move_name()
	if move_name == "Basic":
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("move_window_done")
	else:
		$Move_Name.text = move_name
		yield(get_tree().create_timer(0.6), "timeout")
		self.show()
		yield(get_tree().create_timer(1.5), "timeout")
		self.hide()
		emit_signal("move_window_done")
