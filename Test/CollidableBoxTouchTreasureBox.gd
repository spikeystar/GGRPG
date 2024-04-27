extends Node2D

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer

var is_opened = false

func _ready():
	collidable_box.connect("touched", self, "_on_box_touched")

func _on_box_touched(touch_direction):
	var touch_angle = Vector2(1.0, 0.0).angle_to(touch_direction)
	if touch_angle < (4 * PI / 5) and touch_angle > (-PI / 3):
		animation_player.play("open_box")
		collidable_box.height = 48
		collidable_box.disconnect("touched", self, "_on_box_touched")
		is_opened = true

