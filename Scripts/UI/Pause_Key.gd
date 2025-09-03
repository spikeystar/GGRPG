extends Sprite

func _ready():
	var key_id = $KeyPanel/KeyInventory.get_id()
	
	if Party.jewel_seeds == 1:
		$Seed1.show()
	if Party.jewel_seeds == 2:
		$Seed1.show()
		$Seed2.show()
	if Party.jewel_seeds == 3:
		$Seed1.show()
		$Seed2.show()
		$Seed3.show()
	if Party.jewel_seeds == 4:
		$Seed1.show()
		$Seed2.show()
		$Seed3.show()
		$Seed4.show()
	if Party.jewel_seeds == 5:
		$Seed1.show()
		$Seed2.show()
		$Seed3.show()
		$Seed4.show()
		$Seed5.show()
	if Party.jewel_seeds == 6:
		$Seed1.show()
		$Seed2.show()
		$Seed3.show()
		$Seed4.show()
		$Seed5.show()
		$Seed6.show()
	if Party.jewel_seeds == 7:
		$Seed1.show()
		$Seed2.show()
		$Seed3.show()
		$Seed4.show()
		$Seed5.show()
		$Seed6.show()
		$Seed7.show()

func _process(delta):
	var key_id = $KeyPanel/KeyInventory.get_id()
	if key_id == "X":
		$KeyDisplay.show()
		$KeyDisplay.frame = 90
		$KeyInfo.text = "A strange stone that some collect"
		$Held.text = "Held: " + str(Party.x_amount)
	if key_id == "Lighthouse Key":
		$KeyDisplay.show()
		$KeyDisplay.frame = 0
		$KeyInfo.text = "Opens the Puzzle Pier lighthouse"
		$Held.text = ""
	if key_id == "Mansion Key":
		$KeyDisplay.show()
		$KeyDisplay.frame = 1
		$KeyInfo.text = "Opens the front door of Candyhand's Mansion"
		$Held.text = ""
	if key_id == "Pearl":
		$KeyDisplay.show()
		$KeyDisplay.frame = 2
		$KeyInfo.text = "An iridescent object"
		$Held.text = ""

func _on_KeyInventory_empty_key():
	$KeyDisplay.hide()
	$KeyInfo.text = "No key items"
	$Held.text = ""
	
