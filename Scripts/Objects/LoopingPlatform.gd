extends KinematicBody2D

var velocity

var speed : float
var Positions = []

var end_position : Vector2

export var onto_0 = false
export var onto_1 = false
export var onto_2 = false
export var onto_3 = false
export var onto_4 = false
export var onto_5 = false


func _ready():
	pass

func _process(delta):
	
	if Positions.size() == 6:
		six_movement()
	
	var distance = (end_position - global_position).normalized()
	velocity = (distance * speed)
	$MovingLedge.velocity = velocity
	$MovingLedge.update_velocity()
	move_and_slide(velocity)
	$MovingLedge._generate_meshes()
	
	
func six_movement():	
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[0].global_position.x - 4), int(Positions[0].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[0].global_position.x + 4), int(Positions[0].global_position.y + 4)) && onto_1:
		end_position = Positions[1].global_position
		onto_1 = false
		onto_2 = true
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[1].global_position.x - 4), int(Positions[1].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[1].global_position.x + 4), int(Positions[1].global_position.y + 4)) && onto_2:
		end_position = Positions[2].global_position
		onto_2 = false
		onto_3 = true
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[2].global_position.x - 4), int(Positions[2].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[2].global_position.x + 4), int(Positions[2].global_position.y + 4)) && onto_3:
		end_position = Positions[3].global_position
		onto_3 = false
		onto_4 = true
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[3].global_position.x - 4), int(Positions[3].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[3].global_position.x + 4), int(Positions[3].global_position.y + 4)) && onto_4:
		end_position = Positions[4].global_position
		onto_4 = false
		onto_5 = true	
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[4].global_position.x - 4), int(Positions[4].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[4].global_position.x + 4), int(Positions[4].global_position.y + 4)) && onto_5:
		end_position = Positions[5].global_position
		onto_5 = false
		onto_0 = true
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[5].global_position.x - 4), int(Positions[5].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[5].global_position.x + 4), int(Positions[5].global_position.y + 4)) && onto_0:
		end_position = Positions[0].global_position
		onto_0 = false
		onto_1 = true
		
