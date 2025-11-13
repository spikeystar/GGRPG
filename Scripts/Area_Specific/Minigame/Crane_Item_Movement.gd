extends Node2D


var Item_Choice = ["Yummy Cake", "Pretty Gem", "Picnic Pie", "Sugar Pill", "Polar Parfait", "Spikey Bomb", "Yummy Cake", "Pretty Gem", "Picnic Pie", "Bounty Herb", "Polar Parfait", "Spikey Bomb", "Yummy Cake", "Pretty Gem", "Picnic Pie", "Bounty Herb", "Polar Parfait", "Spikey Bomb", "Yummy Cake", "Strange Perfume", "Faulty Amp", "Power Drill", "Chilly Globe", "Blister Grenade", "Delicious Cake", "Lovely Gem", "Strange Perfume", "Flummery Flambe", "Saffron Souffle", "Nori Cookie", "Ginger Tea", "Sugar Pill", "Yummy Cake", "Yummy Cake", "Picnic Pie", "Bounty Herb", "Polar Parfait", "Spikey Bomb", "Yummy Cake", "Yummy Cake", "Picnic Pie", "Bounty Herb", "Polar Parfait", "Picnic Pie", "Yummy Cake", "Picnic Pie", "Spikey Bomb", "Lovely Gem", "Picnic Pie"]

export var speed : float
var Positions = []
var BasketPosition : Vector2


func _ready():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	Positions = [$Position1, $Position2, $Position3, $Position4]
	BasketPosition = $BasketPosition.global_position
	
	for child in $Crane_Items.get_children():
		var item_pick = rng.randi_range(0, (Item_Choice.size() - 1))
		var this_item = Item_Choice[item_pick]
		child.Positions = Positions.duplicate()
		child.speed = speed
		child.item_name = this_item
		child.BasketPosition = BasketPosition
		
	if not EventManager.Crane_Item_1:
		$Crane_Items/Crane_Item4.item_name = "Stress Ball"
		
	if not EventManager.Crane_Item_2:
		$Crane_Items/Crane_Item8.item_name = "Jhumki"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
