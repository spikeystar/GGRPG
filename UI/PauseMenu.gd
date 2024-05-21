extends Node2D

onready var player_instance = PlayerManager.player_instance

func _ready():
	player_instance.queue_free()
	
func _process(delta):
	if $MainSelection/MenuCursor.menu_name == "Party":
		pass
