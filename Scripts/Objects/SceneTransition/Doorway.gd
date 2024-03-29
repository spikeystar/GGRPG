# This class defines an area where the player will move to another scene when touched.
# You should create a CollisionPolygon2D and put it inside of this node in order to define the shape of the area.

extends Area2D

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")

# If you change the numeric values of this enum, you WILL break every scene that uses it.
# Only add new values, do not modify.
enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;
export var height = 0.0

func _ready():
	var timer = Timer.new()
	timer.one_shot = true
	timer.connect("timeout", self, "_on_start_checking_body_entered")
	add_child(timer)
	timer.start(0.1)
	
	position.y += height

func _on_start_checking_body_entered():
	connect("body_entered", self, "_on_body_entered")

func _input(event):
	if event.is_action_pressed("ui_select"):
		if get_overlapping_bodies().size() > 0:
			_on_touch_area()
	
func _on_touch_area():
	disconnect("body_entered", self, "_on_body_entered")
	Global.door_name = exit_name
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition_in(target_scene, _get_animation_name())

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name

