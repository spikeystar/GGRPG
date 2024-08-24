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
	if key_id == "Bramby":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 4
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They blend into their canyon surroundings for protection"
	if key_id == "Scorpus":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 5
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Poisonous critters that often travel in swarms"
	if key_id == "Hercules":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 6
		$TypeDisplay.frame = 16
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They use Kugi Canyon as their training ground. They hit hard"
	if key_id == "Cactmouse":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 7
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "They like to rough-house and throw their cactus spines at people"
	if key_id == "Thorvern":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 8
		$TypeDisplay.frame = 4
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "Thorvern fly around one area as if they are guarding something"
	if key_id == "Saguarotel":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 9
		$TypeDisplay.frame = 5
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "A large cactus that houses some mischevious little birds"
	if key_id == "Tenant A":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 10
		$TypeDisplay.frame = 0
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "This bird with a temper is always causing a ruckus for its neighbors"
	if key_id == "Tenant B":
		$EnemyDisplay.show()
		$EnemyDisplay.frame = 11
		$TypeDisplay.frame = 4
		$HP_info.text = "60"
		$Attack_info.text = "10"
		$Magic_info.text = "4"
		$Defense_info.text = "10"
		$EnemyInfo.text = "A chatty bird with a bad habit of spitting at those who pass by"
