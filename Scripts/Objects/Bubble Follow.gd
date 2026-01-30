extends PathFollow2D

export var speed = 42

export var projectile = false

func _ready():
	rotation_degrees = 0
	
func _process(delta):
	if not projectile:
		set_offset(get_offset() + speed * delta)
		
	if projectile:
		if not $Projectile.stopped:
			set_offset(get_offset() + speed * delta)
		
			
		
	if(loop == false and get_unit_offset() == 1):
		queue_free()
