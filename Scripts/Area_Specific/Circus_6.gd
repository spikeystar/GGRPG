extends Node2D

func _ready():
	SceneManager.counter = 0
	
	SceneManager.location = "Circus"
	if Music.id != "Circus":
		Music.switch_songs()
		Music.id = "Circus"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if SceneManager.time_decided:
		SceneManager.time_decided = false
		
	if EventManager.circus_puzzle:
		$YSort/MiddleGround/BlocksA.queue_free()
		$Circus7/CollisionPolygon2D.disabled = false


func _on_G_puzzle_solved():
	EventManager.circus_puzzle = true
	PlayerManager.freeze = true
	yield(get_tree().create_timer(0.5), "timeout")
	var current_position = $Camera2D.position
	$Camera2D.follow_player = false
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2(582, -135), 1)
	yield(tween, "finished")
	SE.effect("Poof")
	$PoofPlayer.play("Poof")
	yield(get_tree().create_timer(0.2), "timeout")
	$YSort/MiddleGround/BlocksA.queue_free()
	$Circus7/CollisionPolygon2D.disabled = false
	yield(get_tree().create_timer(1), "timeout")
	var tween3 = create_tween()
	tween3.tween_property($Camera2D, "position", current_position, 1)
	yield(tween3, "finished")
	PlayerManager.freeze = false
	$Camera2D.follow_player = true
