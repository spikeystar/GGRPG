extends Node

onready var player_instance = PlayerManager.player_instance

func _ready():
	$DefenseWindow.hide()
	$BattleButtons.hide()
	$ItemWindow.hide()
	$MagicWindow.hide()
	$BattleDialogue.hide()
	$EnemyInfo.hide()
	$EnemyMove.hide()
	$FleeDialogue.hide()
	player_instance.queue_free()
	
func _input(event):
	if (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		$BattleButtons.show()
		$BattleButtons/AnimationPlayer.play("Initial")
		$Gary_Battle/AnimationPlayer.play("Gary_Turn")
	if (Input.is_action_just_pressed("ui_down")):
		$BattleButtons/SpadeB.hide()
		$DefenseWindow.show()
		
func _on_Defend_cursor_selected():
	$DefenseWindow.hide()
	$Gary_Battle/AnimationPlayer.play("Gary_Defend")

func _on_Flee_cursor_selected():
	$HUDS.hide()
	$DefenseWindow.hide()
	$FleeDialogue.show()
	$FadeRect/AnimationPlayer.play("Flee")
