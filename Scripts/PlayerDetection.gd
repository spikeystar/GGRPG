extends Area2D

var player = null
var detected = false

func _physics_process(delta):
	pass

func player_check():
	return player !=null

func _on_PlayerDetection_body_entered(body):
	player = body
	detected = true

func _on_PlayerDetection_body_exited(body):
	player = null
	detected = false
