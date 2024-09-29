extends Node
onready var Gary = PlayerManager.player_instance

onready var Jacques = $YSort/MiddleGround/Jacques
onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer


func _ready():
	EventManager.Kugi_Canyon = true
	
	SceneManager.SceneEnemies = []
	SceneManager.location = "Kugi Canyon"
	if Music.id != "Kugi_Canyon" or not Music.is_playing:
		Music.switch_songs()
		Music.id = "Kugi_Canyon"
		Music.music()
		
	if EventManager.Saguarotel:
		$YSort/MiddleGround/Saguarotel.queue_free()
		$BerryLake1/CollisionPolygon2D.disabled = false


func _on_Boss_Battle_area_event():
	EventManager.Saguarotel_Intro = true
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.walk()
	var tween = create_tween()
	tween.tween_property(Gary.motion_root, "global_position", $Position2D.position, 1)
	yield(tween, "finished")
	Gary.set_right()
	Jacques.position = Gary.motion_root.global_position
	JacquesPlayer.play("back_walk_f")
	var tween2 = create_tween()
	tween2.tween_property(Jacques, "global_position", $Position2D2.position, 0.5)
	yield(tween2, "finished")
	JacquesPlayer.play("back_idle_f")
	SE.effect("Select")
	
	$BerryLake1/CollisionPolygon2D.disabled = false
