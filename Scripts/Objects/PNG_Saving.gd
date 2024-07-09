extends Node2D

onready var player_instance = PlayerManager.player_instance

func _ready():
	player_instance.queue_free()
	get_viewport().transparent_bg = true
	
func _input(event):
	if Input.is_action_just_pressed("ui_push"):
		#get_viewport().transparent_bg = true
		var vpt = get_viewport()
		var txt = vpt.get_texture()
		var image = txt.get_data()
		image.flip_y()
		image.convert(Image.FORMAT_RGBA8)
		image.save_png("user://composite.png")
