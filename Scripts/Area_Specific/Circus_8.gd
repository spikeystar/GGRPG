extends Node2D

onready var Gary = PlayerManager.player_instance

#onready var Jacques = $YSort/MiddleGround/Jacques
#onready var JacquesPlayer = $YSort/MiddleGround/Jacques/BodyYSort/AnimationPlayer

#onready var Irina = $YSort/MiddleGround/Irina
#onready var IrinaPlayer = $YSort/MiddleGround/Irina/BodyYSort/AnimationPlayer

func _ready():
	SceneManager.location = "Circus"
	if Music.id != "Circus":
		Music.switch_songs()
		Music.id = "Circus"
		Music.music()

	SceneManager.SceneEnemies = []
	
	if SceneManager.time_decided:
		SceneManager.time_decided = false


func _on_Camera2D_animate_Gary():
	PlayerManager.freeze = true
	PlayerManager.cutscene = true
	Gary.animation("hold_seed")

func _on_Boss_Battle_area_event():
	pass
