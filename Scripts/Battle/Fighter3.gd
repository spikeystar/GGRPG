extends Node2D

onready var focus = $Cursor
onready var cursor_player = $CursorPlayer
var party_id = 2

func ready():
	focus.hide()
	
func focus():
	focus.show()
	cursor_player.play("cursor_idle")

func inactive():
	$Cursor.hide()
