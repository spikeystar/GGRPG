extends KinematicBody2D

var speed : float
var velocity

var end_position : Vector2

func _ready():
	pass
	
func _process(delta):
	var distance = (end_position - global_position).normalized()
	velocity = (distance * speed)
	
	if Vector2(int(global_position.x), int(global_position.y)) != Vector2(int(end_position.x), int(end_position.y)):
		$MovingLedge.velocity = velocity
		$MovingLedge.update_velocity()
		move_and_slide(velocity)
		$MovingLedge._generate_meshes()
		
		
	#print(Vector2(int(global_position.x), int(global_position.y)))
	#print(Vector2(int(end_position.x), int(end_position.y)))
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(end_position.x - 3), int(end_position.y -3)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(end_position.x + 3), int(end_position.y +3)):
		self.queue_free()

	#if $MovingLedge.is_ready:
	#	$MovingLedge.update_height()
	#if global_position == end_position:
	#	$MovingLedge.height = $MovingLedge.height
#		$MovingLedge.floor_height = $MovingLedge.floor_height
