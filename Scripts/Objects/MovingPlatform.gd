extends KinematicBody2D

var velocity
var end_position : Vector2

export var speed : float
export var counter = 0
export var counter_max = 0

export var height = 0
export var floor_height = 0

export var trapeze = false
var reverse = false

var Positions = []


# Called when the node enters the scene tree for the first time.
func _ready():
	$Ledge.height = height
	$Ledge.floor_height = floor_height


func _process(delta):
	var distance = (end_position - global_position).normalized()
	velocity = (distance * speed)
	$Ledge.velocity = velocity
	$Ledge.update_velocity()
	move_and_slide(velocity)
	$Ledge._generate_meshes()
	
	if trapeze:
		trapeze_movement()
		
	#area_movement()
		
func area_movement():
	if counter == 1:
		end_position = Positions[1].global_position
		
func trapeze_movement():
	if counter == 1:
		end_position = Positions[1].global_position
	if counter == 2:
		end_position = Positions[2].global_position
	if counter == counter_max:
		reverse = true
		counter = 1
		end_position = Positions[1].global_position
	if counter == 0:
		end_position = Positions[0].global_position
	if counter == -1:
		reverse = false
		counter = 1

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not reverse:
		counter += 1
	if reverse:
		counter -= 1
