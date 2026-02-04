extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var floor_height : int
export var no_shadow = false
var used = false



# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_height = $Platform.height + floor_height
	$Platform.floor_height = floor_height
	$Poof.global_position += Vector2(0, -(floor_height))
	$Area2D.global_position += Vector2(0, -(floor_height))
	
	if no_shadow:
		$SquareShadow.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func poof_noise():
	SE.effect("Poof")

func _on_Area2D_destruct():
	if not used:
		used = true
		$AnimationPlayer.play("phase_out")
		var timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.start(2.5)
		timer.connect("timeout", self, "_on_timer_timeout")
	
func update_collision():
	$Platform.remove_collision()
	$Platform.set_use_collision(false)
	$Platform._initialize_nodes()
	
func _on_timer_timeout():
	used = false
	$Area2D.able = false
	$Area2D.inside = false
	$Platform.use_collision = true
	$Platform.set_use_collision(true)
	$Platform._initialize_nodes()
	$AnimationPlayer.play("phase_in")
