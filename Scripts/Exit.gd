extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;

onready var transition = $"/root/WorldRoot/CanvasLayer/Transition"

func _on_body_entered(body):
	# This is a stupid way to check
	if body.name == "MotionRoot":
		on_touch_area()
	
func on_touch_area():
	Global.door_name = exit_name
	#get_tree().change_scene(target_scene)
	transition.transition_in(target_scene)

