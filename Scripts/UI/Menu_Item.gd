extends Label
var defend_active = false

signal cursor_selected()
signal go_to_Item()

func cursor_select() ->void:
	emit_signal("cursor_selected")

func get_id():
	return text

#func _on_WorldRoot_defend_active():
	#defend_active = true
	
