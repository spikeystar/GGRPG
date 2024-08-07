extends Node

var ready = false

func _ready():
	SceneManager.SceneEnemies = []
	pass
	if Music.id != "Pivot_Town" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Pivot_Town"
		Music.music()
	yield(get_tree().create_timer(0.3), "timeout")
	ready = true
		
func _physics_process(delta):
	#and not SceneManager.flee
	
	if ready and SceneManager.SceneEnemies.size() == 0 and not EventManager.kugi_canyon_extra:
		reveal_extra()
		
func reveal_extra():
	$YSort/MiddleGround/ExtraBlock.use_transparency = true
	PlayerManager.freeze = true
	var current_position = $Camera2D.position
	EventManager.kugi_canyon_extra = true
	$Camera2D.follow_player = false
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2(259, -229), 1.5)
	yield(tween, "finished")
	var tween2 = create_tween()
	tween2.tween_property($YSort/MiddleGround/ExtraBlock, "modulate:a", 0, 0.7)
	yield(tween2, "finished")
	$YSort/MiddleGround/ExtraBlock.queue_free()
	var tween3 = create_tween()
	tween3.tween_property($Camera2D, "position", current_position, 1.5)
	yield(tween3, "finished")
	PlayerManager.freeze = false
	$Camera2D.follow_player = true
