extends Sprite

func reset():
	$EnemyDisplay.show()
	$EnemyDisplay.frame = 0
	$TypeDisplay.frame = 16
	$HP_info.text = "20"
	$Attack_info.text = "3"
	$Magic_info.text = "0"
	$Defense_info.text = "2"
	$EnemyInfo.text = "They're not very strong but are a little mischevious. They like to line up behind things"

func _process(delta):
	var key_id = $EnemiesNode/EnemiesInventory.get_id()
	if key_id == "Cheribo":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 0
		$TypeDisplay.frame = 16
		$HP_info.text = "20"
		$Attack_info.text = "3"
		$Magic_info.text = "0"
		$Defense_info.text = "2"
		$EnemyInfo.text = "They're not very strong but are a little mischevious. They like to line up behind things"
	if key_id == "Flutterbie":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 1
		$TypeDisplay.frame = 16
		$HP_info.text = "30"
		$Attack_info.text = "4"
		$Magic_info.text = "3"
		$Defense_info.text = "3"
		$EnemyInfo.text = "Flutterbie's like to use pesky magic moves to annoy their opponents"
	if key_id == "Sapling":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 2
		$TypeDisplay.frame = 5
		$HP_info.text = "30"
		$Attack_info.text = "6"
		$Magic_info.text = "2"
		$Defense_info.text = "6"
		$EnemyInfo.text = "They seem unassuming, but someday that sprout might grow into something dangerous..."
	if key_id == "Tindrum":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 3
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Tindrum is always looking for a fight and angry about something"
	else:
		$EnemyDisplay.hide()
		$EnemyDisplay.frame = 3
		$TypeDisplay.frame = 17
		$HP_info.text = "-"
		$Attack_info.text = "-"
		$Magic_info.text = "-"
		$Defense_info.text = "-"
		$EnemyInfo.text = ""
