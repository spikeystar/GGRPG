extends Node2D

var item_name : String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func item_set():
	if item_name == "Yummy Cake":
		$Sprite.frame = 0
		$Sprite.position = Vector2(1.7, 0)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Pretty Gem":
		$Sprite.frame = 1
		$Sprite.position = Vector2(1, 0)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Ginger Tea":
		$Sprite.frame = 4
		$Sprite.position = Vector2(1, -2)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Sugar Pill":
		$Sprite.frame = 3
		$Sprite.position = Vector2(1, 0)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Bounty Herb":
		$Sprite.frame = 5
		$Sprite.position = Vector2(0, -1)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Picnic Pie":
		$Sprite.frame = 2
		$Sprite.position = Vector2(1, 0)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Jhumki":
		$Sprite.frame = 90
		$Sprite.position = Vector2(0.25, 0)
		$Sprite.scale = Vector2(0.88, 0.88)

				
	if item_name == "Remedy Bouquet":
		$Sprite.frame = 58
		$Sprite.position = Vector2(4, 4)
		$Sprite.scale = Vector2(1, 1)

	
	if item_name == "Delicious Cake":
		$Sprite.frame = 45
		$Sprite.position = Vector2(0, 0)
		$Sprite.scale = Vector2(0.85, 0.85)


	if item_name == "Polar Parfait":
		$Sprite.frame = 50
		$Sprite.position = Vector2(0, 3)
		$Sprite.scale = Vector2(0.88, 0.88)

		
	if item_name == "Flummery Flambe":
		$Sprite.frame = 49
		$Sprite.position = Vector2(-1, 3)
		$Sprite.scale = Vector2(0.92, 0.92)
		
	if item_name == "Saffron Souffle":
		$Sprite.frame = 51
		$Sprite.position = Vector2(0, 9)
		$Sprite.scale = Vector2(0.85, 0.85)
		
	if item_name == "Nori Cookie":
		$Sprite.frame = 52
		$Sprite.position = Vector2(0.5, 7)
		$Sprite.scale = Vector2(0.88, 0.88)
		
	if item_name == "Lovely Gem":
		$Sprite.frame = 47
		$Sprite.position = Vector2(3, 1)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Spikey Bomb":
		$Sprite.frame = 53
		$Sprite.position = Vector2(2, 8)
		$Sprite.scale = Vector2(1, 1)
		
	if item_name == "Blister Grenade":
		$Sprite.frame = 59
		$Sprite.position = Vector2(3, 3)
		$Sprite.scale = Vector2(1, 1)

	if item_name == "Power Drill":
		$Sprite.frame = 62
		$Sprite.position = Vector2(3, 13)
		$Sprite.scale = Vector2(0.88, 0.88)

	if item_name == "Faulty Amp":
		$Sprite.frame = 61
		$Sprite.position = Vector2(2, 14.5)
		$Sprite.scale = Vector2(1, 1)

	if item_name == "Chilly Globe":
		$Sprite.frame = 60
		$Sprite.position = Vector2(-2, 11)
		$Sprite.scale = Vector2(0.88, 0.88)
		
	if item_name == "Comfy Blanket":
		$Sprite.frame = 12
		$Sprite.position = Vector2(0.5, 1.5)
		$Sprite.scale = Vector2(0.88, 0.88)
		
	if item_name == "Surfboard":
		$Sprite.frame = 91
		$Sprite.position = Vector2(1, 3.5)
		$Sprite.scale = Vector2(0.8, 0.8)

