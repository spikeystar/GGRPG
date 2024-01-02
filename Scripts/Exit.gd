extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;
export var height = 0.0

onready var transition = $"/root/WorldRoot/CanvasLayer/Transition"

func _ready():
	connect("body_entered", self, "_on_body_entered")
	position.y += height

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		on_touch_area()
	
func on_touch_area():
	Global.door_name = exit_name
	transition.transition_in(target_scene)

