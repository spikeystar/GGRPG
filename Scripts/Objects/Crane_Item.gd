extends KinematicBody2D

var item_name : String

var velocity
var speed : float
var end_position : Vector2
var Positions = []

export var onto_1 = false
export var onto_2 = false
export var onto_3 = false
export var onto_4 = false
export var begin = false


func _ready():
	yield(get_tree().create_timer(0.05), "timeout")
	set_item()
	
func _process(delta):
	var distance = (end_position - global_position).normalized()
	velocity = (distance * speed)
	move_and_slide(velocity)
	movement()
	
func movement():
	if onto_1 and begin:
		end_position = Positions[0].global_position
		begin = false
		
	if onto_2 and begin:
		end_position = Positions[1].global_position
		begin = false
	
	if onto_3 and begin:
		end_position = Positions[2].global_position
		begin = false
		
	if onto_4 and begin:
		end_position = Positions[3].global_position
		begin = false
	
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[0].global_position.x - 1), int(Positions[0].global_position.y - 1)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[0].global_position.x + 1), int(Positions[0].global_position.y + 1)) && onto_1 and not begin:
		end_position = Positions[1].global_position
		onto_1 = false
		onto_2 = true
		begin = false

		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[1].global_position.x - 1), int(Positions[1].global_position.y - 1)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[1].global_position.x + 1), int(Positions[1].global_position.y + 1)) && onto_2 and not begin:
		end_position = Positions[2].global_position
		onto_2 = false
		onto_3 = true
		begin = false
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[2].global_position.x - 1), int(Positions[2].global_position.y - 1)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[2].global_position.x + 1), int(Positions[2].global_position.y + 1)) && onto_3 and not begin:
		end_position = Positions[3].global_position
		onto_3 = false
		onto_4 = true
		begin = false
		
	if Vector2(int(global_position.x), int(global_position.y)) >= Vector2(int(Positions[3].global_position.x - 1), int(Positions[3].global_position.y - 1)) && Vector2(int(global_position.x), int(global_position.y)) < Vector2(int(Positions[3].global_position.x + 1), int(Positions[3].global_position.y + 1)) && onto_4 and not begin and not onto_1:
		end_position = Positions[0].global_position
		onto_4 = false
		onto_1 = true
		begin = false


#func make_timer():
	#var timer = Timer.new()
	#add_child(timer)
	#timer.start(4)
	#timer.connect("timeout", self, "_on_timer_timeout")

#func _on_timer_timeout():
#	loop_ready = true

func set_item():
	if item_name == "Stress Ball":
		$ItemUsage/Item.frame = 13
		$ItemUsage/Item.position = Vector2(2, 1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
	
	if item_name == "Yummy Cake":
		$ItemUsage/Item.frame = 0
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

	if item_name == "Pretty Gem":
		$ItemUsage/Item.frame = 1
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
	
	if item_name == "Ginger Tea":
		$ItemUsage/Item.frame = 4
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
	
	if item_name == "Sugar Pill":
		$ItemUsage/Item.frame = 3
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
	
	if item_name == "Bounty Herb":
		$ItemUsage/Item.frame = 5
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
	
	if item_name == "Picnic Pie":
		$ItemUsage/Item.frame = 2
		$ItemUsage/Item.position = Vector2(1, 0)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

	if item_name == "Jhumki":
		$ItemUsage/Item.frame = 90
		$ItemUsage/Item.position = Vector2(-2, -2)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

				
	if item_name == "Remedy Bouquet":
		$ItemUsage/Item.frame = 58
		$ItemUsage/Item.position = Vector2(4, 4)
		$ItemUsage/Item.scale = Vector2(1, 1)


	
	if item_name == "Delicious Cake":
		$ItemUsage/Item.frame = 45
		$ItemUsage/Item.position = Vector2(0, 0)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)


		
	if item_name == "Polar Parfait":
		$ItemUsage/Item.frame = 50
		$ItemUsage/Item.position = Vector2(0, 3)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Flummery Flambe":
		$ItemUsage/Item.frame = 49
		$ItemUsage/Item.position = Vector2(-1, 3)
		$ItemUsage/Item.scale = Vector2(0.92, 0.92)

		
	if item_name == "Saffron Souffle":
		$ItemUsage/Item.frame = 51
		$ItemUsage/Item.position = Vector2(0, 9)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)

		
	if item_name == "Nori Cookie":
		$ItemUsage/Item.frame = 52
		$ItemUsage/Item.position = Vector2(0.5, 7)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Lovely Gem":
		$ItemUsage/Item.frame = 47
		$ItemUsage/Item.position = Vector2(3, 1)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Hocus Potion":
		$ItemUsage/Item.frame = 63
		$ItemUsage/Item.position = Vector2(-2, 8)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Magic Mushroom":
		$ItemUsage/Item.frame = 56
		$ItemUsage/Item.position = Vector2(2, 5)
		$ItemUsage/Item.scale = Vector2(0.85, 0.85)

		
	if item_name == "Strange Perfume":
		$ItemUsage/Item.frame = 64
		$ItemUsage/Item.position = Vector2(6, 4)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Jinx Doll":
		$ItemUsage/Item.frame = 65
		$ItemUsage/Item.position = Vector2(4, 4)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Spikey Bomb":
		$ItemUsage/Item.frame = 53
		$ItemUsage/Item.position = Vector2(2, 8)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Blister Grenade":
		$ItemUsage/Item.frame = 59
		$ItemUsage/Item.position = Vector2(3, 3)
		$ItemUsage/Item.scale = Vector2(1, 1)


	if item_name == "Power Drill":
		$ItemUsage/Item.frame = 62
		$ItemUsage/Item.position = Vector2(3, 13)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)


	if item_name == "Faulty Amp":
		$ItemUsage/Item.frame = 61
		$ItemUsage/Item.position = Vector2(2, 10)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Chilly Globe":
		$ItemUsage/Item.frame = 60
		$ItemUsage/Item.position = Vector2(-2, 11)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		
	
