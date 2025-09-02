extends Area2D

var player = null

func _ready():
	#pass
	#var timer = Timer.new()
	#add_child(timer)
	#timer.start(0.5)
	#timer.connect("timeout", self, "timeout")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
#func _process(delta):
	#print(PlayerManager.repel_zone)
	
func _on_body_entered(body):
	SceneManager.enemy_repel = true
	
	if "is_player_motion_root" in body and body.is_player_motion_root:
		player = body
		PlayerManager.repel_zone = true
	
func _on_body_exited(body):
	SceneManager.enemy_repel = false
	
	if "is_player_motion_root" in body and body.is_player_motion_root:
		player = null
		PlayerManager.repel_zone = false

#func timeout():
	#connect("body_entered", self, "_on_body_entered")
	#connect("body_exited", self, "_on_body_exited")
