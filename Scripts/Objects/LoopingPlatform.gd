extends KinematicBody2D

var velocity

var speed : float
var Positions = []

var end_position : Vector2


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
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[0].global_position.x - 4), int(Positions[0].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[0].global_position.x + 4), int(Positions[0].global_position.y + 4)):
		end_position = Positions[1].global_position
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[1].global_position.x - 4), int(Positions[1].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[1].global_position.x + 4), int(Positions[1].global_position.y + 4)):
		end_position = Positions[2].global_position
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[2].global_position.x - 4), int(Positions[2].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[2].global_position.x + 4), int(Positions[2].global_position.y + 4)):
		end_position = Positions[3].global_position
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[3].global_position.x - 4), int(Positions[3].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[3].global_position.x + 4), int(Positions[3].global_position.y + 4)):
		end_position = Positions[4].global_position	
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[4].global_position.x - 4), int(Positions[4].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[4].global_position.x + 4), int(Positions[4].global_position.y + 4)):
		end_position = Positions[5].global_position
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[5].global_position.x - 4), int(Positions[5].global_position.y - 4)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[5].global_position.x + 4), int(Positions[5].global_position.y + 4)):
		end_position = Positions[0].global_position
		
