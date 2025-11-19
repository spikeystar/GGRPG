extends KinematicBody2D

var item_name : String

var velocity
var speed : float
var end_position : Vector2
var Positions = []
var BasketPosition : Vector2

export var counter = 0

var grabbed = false


func _ready():
	yield(get_tree().create_timer(0.05), "timeout")
	set_item()
	
func _process(delta):
	if not grabbed:
		var distance = (end_position - global_position).normalized()
		velocity = (distance * speed)
		move_and_slide(velocity)
		area_movement()

func area_movement():
	if counter == 1:
		end_position = Positions[1].global_position
	if counter == 2:
		end_position = Positions[2].global_position
	if counter == 3:
		end_position = Positions[3].global_position
	if counter == 4:
		end_position = Positions[0].global_position
		counter = 0


func set_item():
	if item_name == "Stress Ball":
		$ItemUsage/Item.frame = 13
		$ItemUsage/Item.position = Vector2(2, 3)
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
		$ItemUsage/Item.position = Vector2(1,-2)
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
		$ItemUsage/Item.position = Vector2(0, 0)
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
		$ItemUsage/Item.position = Vector2(0, 0)
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
		$ItemUsage/Item.position = Vector2(0.5, 9)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Lovely Gem":
		$ItemUsage/Item.frame = 47
		$ItemUsage/Item.position = Vector2(4, 1)
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
		$ItemUsage/Item.position = Vector2(6, 3)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Jinx Doll":
		$ItemUsage/Item.frame = 65
		$ItemUsage/Item.position = Vector2(4, 4)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)

		
	if item_name == "Spikey Bomb":
		$ItemUsage/Item.frame = 53
		$ItemUsage/Item.position = Vector2(1, 8)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Blister Grenade":
		$ItemUsage/Item.frame = 59
		$ItemUsage/Item.position = Vector2(3, 3)
		$ItemUsage/Item.scale = Vector2(1, 1)


	if item_name == "Power Drill":
		$ItemUsage/Item.frame = 62
		$ItemUsage/Item.position = Vector2(5, 13)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)


	if item_name == "Faulty Amp":
		$ItemUsage/Item.frame = 61
		$ItemUsage/Item.position = Vector2(2, 10)
		$ItemUsage/Item.scale = Vector2(1, 1)

		
	if item_name == "Chilly Globe":
		$ItemUsage/Item.frame = 60
		$ItemUsage/Item.position = Vector2(-2, 11)
		$ItemUsage/Item.scale = Vector2(0.88, 0.88)
		
	

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	counter += 1


func _on_Item_Area_area_entered(area):
	SE.silence("Metal Door")
	SE.effect("Grab")
	var current_y = global_position.y
	var BasketX = Vector2(BasketPosition.x, current_y)
	grabbed = true
	SceneManager.counter += 1
	var counter = SceneManager.counter
	if counter > 1:
		grabbed = false
	yield(get_tree().create_timer(0.5), "timeout")
	if grabbed and counter == 1:
		var tween = create_tween()
		tween.tween_property(self, "global_position", BasketX, 2)
		yield(tween, "finished")
		yield(get_tree().create_timer(0.3), "timeout")
		var tween2 = create_tween()
		tween2.tween_property(self, "global_position", BasketPosition, 1)
		SE.effect("Drama Descend")
		yield(tween2, "finished")
		SE.effect("Win")
		SceneManager.win = true
		Party.add_item_name = item_name
		if item_name == "Jhumki":
			Party.add_key_item_name = "Jhumki"
			EventManager.Crane_Item_2 = true
		if item_name == "Stress Ball":
			Party.add_trinket_name = "Stress Ball"
			EventManager.Crane_Item_1 = true			

func _on_Item_Area_area_exited(area):
	pass
	#grabbed = false
