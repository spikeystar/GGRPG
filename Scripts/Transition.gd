extends ColorRect
 
 
signal transition_in_done
signal transition_out_done

onready var animation_player = $AnimationPlayer
var target_scene
 
func _ready():
	transition_out()

func transition_in(target_scene):
	self.target_scene = target_scene
	animation_player.play("Transition_In")

func transition_out():
	animation_player.play("Transition_Out")
 
 
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Transition_In":
		PlayerManager.remove_player_from_scene()
		get_tree().change_scene(target_scene)
		PlayerManager.call_deferred("add_player_to_scene")
		emit_signal("transition_in_done")
	elif anim_name == "Transition_Out":
		emit_signal("transition_out_done")
