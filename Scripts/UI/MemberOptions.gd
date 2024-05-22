extends Sprite


func _on_Members_member_options():
	self.show()
	$VBoxOptions/MemberOptionsCursor.show()
	yield(get_tree().create_timer(0.2), "timeout")
	$VBoxOptions/MemberOptionsCursor.member_options = true

func _on_MemberOptionsCursor_party_selecting():
	self.hide()

func _on_MemberOptionsCursor_switch_selecting():
	self.hide()
