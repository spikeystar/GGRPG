extends Sprite

var move_name : String

signal move_window_done

func _on_Enemies_update_move_window():
	if move_name == "Basic":
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("move_window_done")
	else:
		$Icons.position = Vector2(-110.7, -2)
		$Move_Name.text = move_name
		set_type()
		if $Move_Name.text.length() <= 6:
			$Icons.position = Vector2(-110.7, -2) + Vector2($Move_Name.text.length() * 11.5, 0)
		if $Move_Name.text.length() >= 7:
			$Icons.position = Vector2(-110.7, -2) + Vector2($Move_Name.text.length() * 12.2, 0)
		yield(get_tree().create_timer(0.5), "timeout")
		self.show()
		yield(get_tree().create_timer(1.2), "timeout")
		self.hide()
		emit_signal("move_window_done")

func set_type():
	if move_name == "Barrage":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Beat Down":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Sting":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Sabotage":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Pester":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Extort":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Slash":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 5
	if move_name == "Splat":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 6
	if move_name == "Asphyxiate":
		$Icons/Type1.frame = 4
		$Icons/Type2.frame = 6
	if move_name == "Bubble Ring":
		$Icons/Type1.frame = 1
		$Icons/Type2.frame = 6
	if move_name == "Stream Strike":
		$Icons/Type1.frame = 1
		$Icons/Type2.frame = 5
	if move_name == "Friction":
		$Icons/Type1.frame = 0
		$Icons/Type2.frame = 5
	if move_name == "Aero Bullet":
		$Icons/Type1.frame = 2
		$Icons/Type2.frame = 5
	if move_name == "Squall":
		$Icons/Type1.frame = 2
		$Icons/Type2.frame = 5
	if move_name == "Zap":
		$Icons/Type1.frame = 2
		$Icons/Type2.frame = 6
	if move_name == "Terra Arrow":
		$Icons/Type1.frame = 3
		$Icons/Type2.frame = 5
	if move_name == "Gravel Spat":
		$Icons/Type1.frame = 3
		$Icons/Type2.frame = 5
	if move_name == "Hay Fever":
		$Icons/Type1.frame = 3
		$Icons/Type2.frame = 6
