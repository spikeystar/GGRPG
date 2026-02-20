extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func item_animation():
	if Party.add_item_name == "Jhumki":
		$Item.frame = 90
	if Party.add_item_name == "Lighthouse Key":
		$Item.frame = 66
	
	$ItemPlayer.playback_speed = 0.9
	$ItemPlayer.play("Item_Usage")
	yield(get_tree().create_timer(1.2), "timeout")
	$Poof.show()
	$PoofPlayer.play("Poof")
	$ItemPlayer.playback_speed = 1
	yield(get_tree().create_timer(1), "timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
