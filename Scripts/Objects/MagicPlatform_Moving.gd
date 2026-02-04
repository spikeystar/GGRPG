extends KinematicBody2D


export var floor_height : int
export var no_shadow = false
var used = false

var end_position : Vector2
var velocity
var speed

var Positions = []
var movement_type = 0
var detectable = true
export var counter = 0

export var debug = false

var active = true

func _ready():
	$Area2D.area_height = $Platform.height + floor_height
	$Platform.floor_height = floor_height
	$Poof.global_position += Vector2(0, -(floor_height))
	
	if no_shadow:
		$SquareShadow.modulate.a = 0

func _process(delta):
	var distance = (end_position - global_position).normalized()
	velocity = (distance * speed)
	
	$Platform.velocity = velocity
	move_and_slide(velocity)
	$Platform._generate_meshes()
	area_movement()
	
	if active:
		$Platform.update_velocity()
	
		
		
func area_movement():
	if movement_type == 4:
		four_movement()
		
func four_movement():
	if counter == 1:
		end_position = Positions[1]
	if counter == 2:
		end_position = Positions[2]
	if counter == 3:
		end_position = Positions[3]
	if counter == 4:
		end_position = Positions[0]
		counter = 0
		
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
	$Platform.floor_ready = false
	$Platform.remove_collision()
	$Platform.set_use_collision(false)
	$Platform._initialize_nodes()
	active = false
	
func _on_timer_timeout():
	used = false
	$Area2D.able = false
	$Area2D.inside = false
	$Platform.use_collision = true
	$Platform.set_use_collision(true)
	$Platform._initialize_nodes()
	active = true
	$AnimationPlayer.play("phase_in")
	
func _on_detect_timer_timeout():
	detectable = true


func _on_Position_Sensor_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if detectable:
		counter += 1
		detectable = false
		var detect_timer = Timer.new()
		add_child(detect_timer)
		detect_timer.one_shot = true
		detect_timer.start(0.5)
		detect_timer.connect("timeout", self, "_on_detect_timer_timeout")
	else:
		pass
	
