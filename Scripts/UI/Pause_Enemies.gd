extends Sprite

func reset():
	$EnemyDisplay.position = Vector2(86, -126)
	$EnemyDisplay.scale = Vector2(1, 1)
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
		$EnemyDisplay.position = Vector2(86, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 0
		$TypeDisplay.frame = 16
		$HP_info.text = "20"
		$Attack_info.text = "3"
		$Magic_info.text = "0"
		$Defense_info.text = "2"
		$EnemyInfo.text = "They're not very strong but are a little mischevious. They like to line up behind things"
	if key_id == "Flutterbie":
		$EnemyDisplay.position = Vector2(86, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 1
		$TypeDisplay.frame = 16
		$HP_info.text = "30"
		$Attack_info.text = "4"
		$Magic_info.text = "3"
		$Defense_info.text = "3"
		$EnemyInfo.text = "Flutterbie's like to use pesky magic moves to annoy their opponents"
	if key_id == "Sapling":
		$EnemyDisplay.position = Vector2(86, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 2
		$TypeDisplay.frame = 5
		$HP_info.text = "30"
		$Attack_info.text = "6"
		$Magic_info.text = "2"
		$Defense_info.text = "6"
		$EnemyInfo.text = "They seem unassuming, but someday that sprout might grow into something dangerous..."
	if key_id == "Tindrum":
		$EnemyDisplay.position = Vector2(86, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 3
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Tindrum is always looking for a fight and angry about something"
	if key_id == "Bramby":
		$EnemyDisplay.position = Vector2(83, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 4
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They blend into their canyon surroundings for protection"
	if key_id == "Scorpus":
		$EnemyDisplay.position = Vector2(88, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 5
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Poisonous critters that often travel in swarms"
	if key_id == "Hercules":
		$EnemyDisplay.position = Vector2(86, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 6
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They use Kugi Canyon as their training ground. They hit hard"
	if key_id == "Cactmouse":
		$EnemyDisplay.position = Vector2(87, -126)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 7
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They like to rough-house and throw their cactus spines at people"
	if key_id == "Thorvern":
		$EnemyDisplay.position = Vector2(90, -125)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 8
		$TypeDisplay.frame = 4
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Thorvern fly around one area as if they are guarding something"
	if key_id == "Saguarotel":
		$EnemyDisplay.position = Vector2(87, -124)
		$EnemyDisplay.scale = Vector2(1.1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 9
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "A large cactus that houses some mischevious little birds"
	if key_id == "Tenant A":
		$EnemyDisplay.position = Vector2(85, -123)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 10
		$TypeDisplay.frame = 0
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "This bird with a temper is always causing a ruckus for its neighbors"
	if key_id == "Tenant B":
		$EnemyDisplay.position = Vector2(83, -123)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 11
		$TypeDisplay.frame = 4
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "A chatty bird with a bad habit of spitting at those who pass by"
	if key_id == "Smush":
		$EnemyDisplay.position = Vector2(89, -121)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 12
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They wander the forest looking for shady places to rest and protect their mushroom"
	if key_id == "Druplet":
		$EnemyDisplay.position = Vector2(87, -121)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 13
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Their bodies are made up of berries that are incredibly sour"
	if key_id == "Beezle":
		$EnemyDisplay.position = Vector2(89, -123)
		$EnemyDisplay.scale = Vector2(0.95, 0.95)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 14
		$TypeDisplay.frame = 4
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Beezles love music and often swarm areas where it can be heard playing"
	if key_id == "Raznor":
		$EnemyDisplay.position = Vector2(89, -122)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 15
		$TypeDisplay.frame = 1
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They like to push people into the water and are generally quite troublesome"
	if key_id == "Bushel":
		$EnemyDisplay.position = Vector2(88, -121)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 16
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Bushels like to throw their sticky berries wherever they can to make a mess"
	if key_id == "Kerobi":
		$EnemyDisplay.position = Vector2(87, -122)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 17
		$TypeDisplay.frame = 1
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Once something is caught by its tongue, it will refuse to let go no matter what it is"
	if key_id == "Trocodile":
		$EnemyDisplay.position = Vector2(91, -122)
		$EnemyDisplay.scale = Vector2(1, 1)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 18
		$TypeDisplay.frame = 1
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Watch out for Trocodiles lurking in the water, their tail slash is deadly"
	if key_id == "Reeler":
		$EnemyDisplay.position = Vector2(91, -122)
		$EnemyDisplay.scale = Vector2(1, 0.96)
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 19
		$TypeDisplay.frame = 1
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "An eel with a bad attitude who frequents Berry Lake to fish for other's lost items"
