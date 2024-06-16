extends Node2D

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer

var is_opened = false

func _ready():
	animation_player.play("Idle")
	collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")

func _on_bumped_from_bottom():
	yield(get_tree().create_timer(0.1), "timeout")
	animation_player.play("Open Box")
	animation_player.playback_speed = 1.0
	collidable_box.disconnect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	is_opened = true
