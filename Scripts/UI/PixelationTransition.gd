extends CanvasLayer

func _ready():
	pixelate()

func pixelate():
	$AnimationPlayer.play("pixelate")
