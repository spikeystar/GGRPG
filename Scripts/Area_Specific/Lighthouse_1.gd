extends Node2D

func _ready():
	if EventManager.Lighthouse_Intro and not EventManager.Lighthouse_After:
		$Node2D/CollisionRoot/Outside.exit_name = "Default"
