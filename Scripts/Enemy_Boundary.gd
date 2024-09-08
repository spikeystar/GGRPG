extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	
func _on_body_entered(body):
	SceneManager.enemy_repel = true
	
func _on_body_exited(body):
	SceneManager.enemy_repel = false
