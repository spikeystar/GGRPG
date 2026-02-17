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
		
	if EventManager.circus_extra:
		$YSort/MiddleGround/BlocksA.queue_free()
		$YSort/MiddleGround/Calico.queue_free()
		$CollisionRoot/NPC.queue_free()
		
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(0.1)
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _on_timer_timeout():
	$LedgeMover2.play("Ledges")


func _on_Dialogue_event_trigger():
	if not EventManager.calico_initial:
		SE.effect("Drama Jump")
		$YSort/MiddleGround/Calico/BodyYSort/AnimationPlayer.play("hop")
		yield(get_tree().create_timer(0.8), "timeout")
		$YSort/MiddleGround/Calico/BodyYSort/AnimationPlayer.play("idle")
		
	if EventManager.calico_initial:
		$CollisionRoot/NPC.queue_free()
		EventManager.circus_extra = true
		PlayerManager.freeze = true
		yield(get_tree().create_timer(0.5), "timeout")
		PlayerManager.freeze = true
		SE.effect("Poof")
		$PoofPlayer.play("Poof")
		yield(get_tree().create_timer(0.2), "timeout")
		PlayerManager.freeze = true
		$YSort/MiddleGround/BlocksA.queue_free()
		$CircusExtra/CollisionPolygon2D.disabled = false
		yield(get_tree().create_timer(1), "timeout")
		PlayerManager.freeze = true
		SE.effect("Drama Jump")
		$YSort/MiddleGround/Calico/BodyYSort/AnimationPlayer.play("hop")
		$Camera2D/Interaction/Dialogue.Calico_after()
		yield(get_tree().create_timer(1), "timeout")
		PlayerManager.freeze = true
		$YSort/MiddleGround/Calico/BodyYSort/AnimationPlayer.play("idle")
		yield(get_tree().create_timer(0.6), "timeout")
		PlayerManager.freeze = true
		SE.effect("Poof")
		$PoofPlayer2.play("Poof")
		yield(get_tree().create_timer(0.2), "timeout")
		$YSort/MiddleGround/Calico.queue_free()
		yield(get_tree().create_timer(0.5), "timeout")
		PlayerManager.freeze = false


