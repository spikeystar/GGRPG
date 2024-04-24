extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	
func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("Done")
