extends Node2D

func _ready():
	pass # Replace with function body.


func cursor_show():
	$Cursor.show()
	
func cursor_hide():
	$Cursor.hide()
	
func flip():
	$AnimationPlayer.play("flip")
