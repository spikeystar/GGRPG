extends Node2D

var BasketPosition : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	BasketPosition = $Game/Items/BasketPosition.global_position
	$Game/Crane.BasketPosition = BasketPosition


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
