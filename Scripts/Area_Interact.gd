extends Area2D

export(String, FILE, "*.tscn,*.scn") var target_scene
export var door_name : String;
export var height : int;

var motion_root;

onready var transition = $"/root/WorldRoot/CanvasLayer/Transition"

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("ui_select"):
		if get_overlapping_bodies().size() > 0:
			enter()
			
func enter():
	#$Fade/AnimationPlayer.play("Fade")
	var _ERR = get_tree().change_scene(target_scene)
	#$Player.global.position = Global.player_pos
	
	#Global.door_name = name
	
	
