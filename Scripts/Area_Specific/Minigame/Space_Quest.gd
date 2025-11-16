extends Node2D


var FirstPool = ["Spikey Bomb", "Blister Grenade", "Power Drill", "Chilly Globe", "Faulty Amp"]
var SecondPool = ["Polar Parfait", "Nori Cookie", "Flummery Flambe", "Saffron Souffle", "Lovely Gem", "Delicious Cake"]
var ThirdPool = ["Bounty Herb", "Yummy Cake", "Pretty Gem", "Sugar Pill", "Ginger Tea", "Bounty Herb", "Yummy Cake"]

var item1 : String
var item2 : String
var item3 : String


func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var item1_pick = rng.randi_range(0, (FirstPool.size() - 1))
	var item1 = FirstPool[item1_pick]
	$Intro/Item1.item_name = item1
	var item2_pick = rng.randi_range(0, (SecondPool.size() - 1))
	var item2 = SecondPool[item2_pick]
	$Intro/Item2.item_name = item2
	var item3_pick = rng.randi_range(0, (ThirdPool.size() - 1))
	var item3 = ThirdPool[item3_pick]
	$Intro/Item3.item_name = item3
	
	if not EventManager.Space_Item_1:
		$Intro/Item1.item_name = "Comfy Blanket"
		
	if not EventManager.Space_Item_2:
		$Intro/Item2.item_name = "Jhumki"
		
	$Intro/Item1.item_set()
	$Intro/Item2.item_set()
	$Intro/Item3.item_set()
	
	$Game/Spaceship.MaxLeft = $Game/MaxLeft.global_position
	$Game/Spaceship.MaxRight = $Game/MaxRight.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
