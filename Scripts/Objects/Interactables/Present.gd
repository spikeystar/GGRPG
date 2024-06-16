extends Node2D

onready var collidable_box = $CollidableBox
onready var animation_player = $AnimationPlayer
onready var square_shadow = $SquareShadow

export var floor_height = 0.0 setget set_floor_height
export var box_height_above_floor = 80.0 setget set_box_height_above_floor

var is_ready = false
var is_opened = false

func _ready():
	is_ready = true
	animation_player.play("Idle")
	collidable_box.connect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	
	_calculate_box_position()

func set_floor_height(new_floor_height):
	floor_height = new_floor_height
	if is_ready:
		_calculate_box_position()

func set_box_height_above_floor(new_box_height_above_floor):
	box_height_above_floor = new_box_height_above_floor
	if is_ready:
		_calculate_box_position()

func _calculate_box_position():
	collidable_box.floor_height = floor_height + box_height_above_floor
	collidable_box.position.y = floor_height

func _on_bumped_from_bottom():
	yield(get_tree().create_timer(0.1), "timeout")
	animation_player.play("Open Box")
	animation_player.playback_speed = 1.0
	collidable_box.disconnect("bumped_from_bottom", self, "_on_bumped_from_bottom")
	is_opened = true
