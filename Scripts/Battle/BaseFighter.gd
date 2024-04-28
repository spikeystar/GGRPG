extends Node2D

var party_id = 0
export(PackedScene) var TEXT_DAMAGE: PackedScene = null
export(PackedScene) var TEXT_HEAL: PackedScene = null
export(PackedScene) var TEXT_SP: PackedScene = null
export(PackedScene) var TEXT_LOSS: PackedScene = null
var able = true

func focus():
	if able:
		$Cursor.show()
		$CursorPlayer.play("cursor_idle")

func unfocus():
	$Cursor.hide()
	
func turn():
	$AnimationPlayer.play("Fighter_Turn")
	
func defend():
	$AnimationPlayer.play("Fighter_Defend")
	able = false
	
func flee():
	$AnimationPlayer.play("Fighter_Flee")
	$AnimationPlayer.playback_speed = 1
	
func pre_attack():
	$AnimationPlayer.play("Fighter_Pre_Attack")
	able = false

func attack():
	$AnimationPlayer.play("Fighter_Attack")
	$AnimationPlayer.playback_speed = 0.6
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("Fighter_BattleReady")
	
func text(TEXT: PackedScene, text_position: Vector2 = global_position):
	if TEXT:
		var text = TEXT.instance()
		get_tree().current_scene.add_child(text)
		text.global_position = text_position + Vector2(0, -60)
		
func get_position(fighter_position: Vector2 = global_position):
	return fighter_position

func get_self(fighter_self: Node2D = self):
	return fighter_self

