extends Sprite
var key_id

func _ready():
	if Party.KeyItems.size() > 0:
		key_id = $KeyPanel/KeyInventory.initial_id()
		set_id()
	
	if Party.jhumki_amount > 0:
		$KeyDisplay.frame = 90
		$KeyInfo.text = "A small golden ornament that some collect"
		$Held.text = "Found: " + str(Party.jhumki_amount)
	
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
	key_id = $KeyPanel/KeyInventory.get_id()
	set_id()

func set_id():
	if key_id == "Jhumki":
		$KeyDisplay.show()
		$KeyDisplay.frame = 90
		$KeyInfo.text = "A small golden ornament that some collect"
		$Held.text = "Found: " + str(Party.jhumki_amount)
	if key_id == "Lighthouse Key":
		$KeyDisplay.show()
		$KeyDisplay.frame = 66
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
	
