extends Node2D

func wimpy():
	$AttackX.show()
	
func dizzy():
	$MagicX.show()
	
func item_halt():
	$ItemX.show()
	
func reset():
	$AttackX.hide()
	$MagicX.hide()
	$ItemX.hide()
	
func _on_AnimationPlayer_animation_finished(_name):
	pass
