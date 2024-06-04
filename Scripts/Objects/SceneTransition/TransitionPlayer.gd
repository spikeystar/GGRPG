# This class handles playing a transition animation, and switching the scene

extends CanvasLayer
 
signal transition_in_done
signal transition_out_done

onready var animation_player = $AnimationPlayer
var target_scene
var animation_name = "FadeToBlack"
 
func _ready():
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	
func fade_speed():
	animation_player.playback_speed = 0.8

func transition_in(target_scene, animation_name = "FadeToBlack"):
	self.animation_name = animation_name
	self.target_scene = target_scene
	animation_player.play(animation_name + "_In")

func transition_out(animation_name = "FadeToBlack"):
	self.animation_name = animation_name
	animation_player.play(animation_name + "_Out")
 
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name.ends_with("_In"):
		PlayerManager.remove_player_from_scene()
		get_tree().change_scene(target_scene)
		PlayerManager.call_deferred("add_player_to_scene")
		emit_signal("transition_in_done")
		transition_out(animation_name)
	elif anim_name.ends_with("_Out"):
		emit_signal("transition_out_done")
		queue_free()
