extends Area2D

var entered = false
var transitioning = false
var player_height

const TransitionPlayer = preload("res://Objects/SceneTransition/TransitionPlayer.tscn")
const PixelationPlayer = preload("res://UI/PixelationTransition.tscn")

# If you change the numeric values of this enum, you WILL break every scene that uses it.
# Only add new values, do not modify.
enum TransitionType {
	FADE_TO_BLACK = 0,
}

export(String, FILE, "*.tscn,*.scn") var target_scene
export var exit_name : String;
export(TransitionType) var transition_type = TransitionType.FADE_TO_BLACK;
export var height = 0.0
var body_check = false

func _ready():
	SceneManager.counter = 0
	yield(get_tree().create_timer(0.5), "timeout")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	position.y += height
	
func _process(delta):
	player_height = int(PlayerManager.player_motion_root.pos_z)
	
	if body_check and int(height) == player_height and not transitioning and SceneManager.counter > 0:
		_on_touch_area()

func _on_body_entered(body):
	if "is_player_motion_root" in body and body.is_player_motion_root and not transitioning and not body_check and not PlayerManager.drown:
		#Global.door_name = "Entrance"
		SceneManager.counter += 1
		body_check = true
		
		if int(PlayerManager.player_motion_root.pos_z) == int(height):
			PlayerManager.jump_disabled = true
		#_on_touch_area()
			
func _on_body_exited(body):
	if "is_player_motion_root" in body and body.is_player_motion_root:
		SceneManager.counter -= 1
		PlayerManager.jump_disabled = false
		body_check = false
	
func _on_touch_area():
	Global.door_name = "Entrance"
	body_check = false
	transitioning = true
	SE.effect("Drown 2")
	PlayerManager.drown = true
	disconnect("body_entered", self, "_on_body_entered")
	PlayerManager.freeze = true
	yield(get_tree().create_timer(0.3), "timeout")
	var pixelation = PixelationPlayer.instance()
	get_tree().get_root().add_child(pixelation)
	pixelation.pixelate2()
	yield(get_tree().create_timer(0.7), "timeout")
	if SceneManager.counter > 1:
		if priority == 1:
			Global.door_name = exit_name
		else:
			return
	else:
		Global.door_name = exit_name
	var transition = TransitionPlayer.instance()
	get_tree().get_root().add_child(transition)
	transition.transition_in(target_scene, _get_animation_name())
	yield(get_tree().create_timer(0.6), "timeout")
	#pixelation.queue_free()
	PlayerManager.drown = false
	yield(get_tree().create_timer(2), "timeout")
	transition.queue_free()
	transitioning = false
	
	

func _get_animation_name():
	var animation_name = "FadeToBlack" # default
	match transition_type:
		TransitionType.FADE_TO_BLACK:
			animation_name = "FadeToBlack"
	return animation_name
