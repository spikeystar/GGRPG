extends Sprite

func _ready():
	var key_id = $KeyPanel/KeyInventory.get_id()
	
	if Party.jewel_seeds == 1:
		$Seed1.show()

func _process(delta):
	var key_id = $KeyPanel/KeyInventory.get_id()
	if key_id == "Lighthouse Key":
		$KeyDisplay.show()
		$KeyDisplay.frame = 0
		$KeyInfo.text = "Opens the Puzzle Pier lighthouse"
	if key_id == "Mansion Key":
		$KeyDisplay.show()
		$KeyDisplay.frame = 1
		$KeyInfo.text = "Opens the front door of Candyhand's Mansion"
	if key_id == "Pearl":
		$KeyDisplay.show()
		$KeyDisplay.frame = 2
		$KeyInfo.text = "An iridescent object"

func _on_KeyInventory_empty_key():
	$KeyDisplay.hide()
	$KeyInfo.text = "No key items"
