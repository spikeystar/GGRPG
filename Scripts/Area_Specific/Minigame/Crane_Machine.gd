extends Node2D

var BasketPosition : Vector2
var able = false
var done = false


# Called when the node enters the scene tree for the first time.
func _ready():
	SE.effect("Menu Open")
	SceneManager.win = false
	SceneManager.counter = 0
	$Game/Crane.MaxRight = $MaxRight.global_position
	$Game/Crane/Claw_Body.MaxBottom = $MaxBottom.global_position
	BasketPosition = $Game/Items/BasketPosition.global_position
	$Game/Crane.BasketPosition = BasketPosition
	yield(get_tree().create_timer(0.7), "timeout")
	able = true
	
func _input(event):
	if Input.is_action_just_pressed("ui_select") and able:
		SE.effect("Menu Open")
		able = false
		$AnimationPlayer.play_backwards("open")
		$AnimationPlayer.playback_speed = 1
		yield(get_tree().create_timer(0.5), "timeout")
		$Game/Intro.hide()
		$AnimationPlayer.play("open")
		yield(get_tree().create_timer(0.5), "timeout")
		$Game/Crane.handle_movement = true
		
	if Input.is_action_just_pressed("ui_select") and done:
		SE.effect("Switch")
		done = false
		var tween = create_tween()
		tween.tween_property($Notify, "modulate:a", 0, 0.15)
		SceneManager.counter = 0
		SceneManager.minigame_done = true
		$AnimationPlayer.play_backwards("open")
		$AnimationPlayer.playback_speed = 1
		yield(get_tree().create_timer(0.9), "timeout")
		self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Crane_game_done():
	yield(get_tree().create_timer(0.8), "timeout")
	done = true
	var tween = create_tween()
	tween.tween_property($Notify, "modulate:a", 1, 0.15)
	$Notify.show()
	
