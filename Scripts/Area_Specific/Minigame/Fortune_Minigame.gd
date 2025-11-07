extends Node2D

var able = false
var done = false
var card_index = 0

var Cards = []

var Fortune_Type = ["Courageous", "Mysterious", "Healing", "Lucky"]

var Courageous_Fortunes = []
var Mysterious_Fortunes = []
var Healing_Fortunes = []
var Lucky_Fortunes = []

var Courageous_Pool = ["Spikey Bomb", "Faulty Amp", "Chilly Globe", "Power Drill", "Blister Grenade"]
var Mysterious_Pool = ["Starberry", "Lovely Gem", "Beautiful Gem", "Strange Perfume"]
var Healing_Pool = ["Bounty Herb", "Remedy Bouquet", "Delicious Cake", "Amazing Cake", "Picnic Pie"]
var Lucky_Pool = ["Magic Mushroom", "Hocus Potion", "Jinx Doll"]
var Extra_Pool = ["Perfect Panacea"]

var item_pool = []


func _ready():
	fortune_populate()
	SE.effect("Menu Open")
	Cards = $Cards.get_children()
	Cards[0].cursor_show()
	$AnimationPlayer.play("open")
	yield(get_tree().create_timer(1), "timeout")
	able = true
	
func select_next_card(card_index_offset):
	var last_index = card_index;
	var new_index = fposmod(last_index + card_index_offset, Cards.size())
	Cards[last_index].cursor_hide()
	Cards[new_index].cursor_show()
	card_index = new_index
	
func fortune_set():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	SceneManager.fortune_counter = 3
	SceneManager.attack_fortune = false
	SceneManager.magic_fortune = false
	SceneManager.defense_fortune = false
	SceneManager.whammy_fortune = false
	
	var type_pick = rng.randi_range(0, 3)
	var current_type = Fortune_Type[type_pick]
	var fortune_choice = rng.randi_range(0, 3)
	
	if current_type == "Courageous":
		$Title2.text = "Courageous Fortune"
		$Fortune_Bonus.text = "Attack +10% next 3 battles!"
		item_pool = Courageous_Pool
		SceneManager.attack_fortune = true
		SceneManager.fortune_counter = 3
		$Fortune.text = Courageous_Fortunes[fortune_choice]
		
	if current_type == "Mysterious":
		$Title2.text = "Mysterious Fortune"
		$Fortune_Bonus.text = "Magic +10% next 3 battles!"
		item_pool = Mysterious_Pool
		SceneManager.magic_fortune = true
		SceneManager.fortune_counter = 3
		$Fortune.text = Mysterious_Fortunes[fortune_choice]
		
	if current_type == "Healing":
		$Title2.text = "Healing Fortune"
		$Fortune_Bonus.text = "Defense +10% next 3 battles!"
		item_pool = Healing_Pool
		SceneManager.defense_fortune = true
		SceneManager.fortune_counter = 3
		$Fortune.text = Healing_Fortunes[fortune_choice]
		
	if current_type == "Lucky":
		$Title2.text = "Lucky Fortune"
		$Fortune_Bonus.text = "Whammy! chance +3 next 3 battles!"
		item_pool = Lucky_Pool
		SceneManager.whammy_fortune = true
		SceneManager.fortune_counter = 3
		$Fortune.text = Lucky_Fortunes[fortune_choice]
		
	var extra_roll = rng.randi_range(0, 100)
	if extra_roll == 1:
		item_pool = Extra_Pool


func _input(event):
	if Input.is_action_just_pressed("ui_select") and able:
		able = false
		SE.effect("Switch")
		Cards[card_index].cursor_hide()
		Cards[card_index].flip()
		$AnimationPlayer.play("flash")
		yield(get_tree().create_timer(0.4), "timeout")
		$Cards.hide()
		$Screen.hide()
		$Title.hide()
		$StarDeco.hide()
		$StarDeco2.hide()
		
		fortune_set()
		item_set()
		$Screen2.show()
		$Title2.show()
		$Fortune.show()
		$Fortune_Bonus.show()
		$Item.show()
		yield(get_tree().create_timer(1), "timeout")
		done = true
		
	if Input.is_action_just_pressed("ui_select") and done:
		SE.effect("Menu Open")
		$AnimationPlayer.play_backwards("open")
		yield(get_tree().create_timer(0.8), "timeout")
		self.queue_free()
		
		
	if Input.is_action_just_pressed("ui_right") and able:
		select_next_card(+1)
		SE.effect("Move Between")
		
	if Input.is_action_just_pressed("ui_left") and able:
		select_next_card(-1)
		SE.effect("Move Between")

func fortune_populate():
	var one = "Things may seem dire at the moment, but a new friend or ally will show up soon to give you the help that you need"
	var two = "ping pong"
	var three = "ping pong"
	var four = "ping pong"
	Courageous_Fortunes = [one, two, three, four]
	
	var five = "Things may seem dire at the moment, but a new friend or ally will show up soon to give you the help that you need"
	var six = "ping pong"
	var seven = "ping pong"
	var eight = "ping pong"
	Mysterious_Fortunes = [five, six, seven, eight]
	
	var nine = "Things may seem dire at the moment, but a new friend or ally will show up soon to give you the help that you need"
	var ten = "ping pong"
	var eleven = "ping pong"
	var twelve = "ping pong"
	Healing_Fortunes = [nine, ten, eleven, twelve]
	
	var thirteen = "Things may seem dire at the moment, but a new friend or ally will show up soon to give you the help that you need"
	var fourteen = "ping pong"
	var fifteen = "ping pong"
	var sixteen = "ping pong"
	Lucky_Fortunes = [thirteen, fourteen, fifteen, sixteen]

func item_set():
	randomize()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var item_choice = rng.randi_range(0, (item_pool.size() -1))
	var item_name = item_pool[item_choice]
	
	Party.add_item_name = item_name
	
	if item_name == "Bounty Herb":
		$Item.frame = 5
		$Item.position = Vector2(0, 92)
		$Item.scale = Vector2(1.4, 1.4)

	if item_name == "Picnic Pie":
		$Item.frame = 2
		$Item.position = Vector2(0, 92)
		$Item.scale = Vector2(1.4, 1.4)

	if item_name == "Remedy Bouquet":
		$Item.frame = 58
		$Item.position = Vector2(5, 98)
		$Item.scale = Vector2(1.6, 1.6)

		
	if item_name == "Perfect Panacea":
		$Item.frame = 57
		$Item.position = Vector2(-2, 98)
		$Item.scale = Vector2(1.65, 1.65)

	
	if item_name == "Delicious Cake":
		$Item.frame = 45
		$Item.position = Vector2(-1, 93)
		$Item.scale = Vector2(1.4, 1.4)

	
	if item_name == "Amazing Cake":
		$Item.frame = 46
		$Item.position = Vector2(-3, 96)
		$Item.scale = Vector2(1.4, 1.4)


	if item_name == "Lovely Gem":
		$Item.frame = 47
		$Item.position = Vector2(4, 91)
		$Item.scale = Vector2(1.4, 1.4)

		
	if item_name == "Beautiful Gem":
		$Item.frame = 48
		$Item.position = Vector2(-1, 96)
		$Item.scale = Vector2(1.4, 1.4)

		
	if item_name == "Starberry":
		$Item.frame = 55
		$Item.position = Vector2(6, 98)
		$Item.scale = Vector2(1.5, 1.5)

	if item_name == "Hocus Potion":
		$Item.frame = 63
		$Item.position = Vector2(-3, 101)
		$Item.scale = Vector2(1.6, 1.6)
		
	if item_name == "Magic Mushroom":
		$Item.frame = 56
		$Item.position = Vector2(0, 101)
		$Item.scale = Vector2(1.5, 1.5)
		
	if item_name == "Strange Perfume":
		$Item.frame = 64
		$Item.position = Vector2(5, 95)
		$Item.scale = Vector2(1.65, 1.65)
		
	if item_name == "Jinx Doll":
		$Item.frame = 65
		$Item.position = Vector2(5, 100)
		$Item.scale = Vector2(1.5, 1.5)
		
	if item_name == "Spikey Bomb":
		$Item.frame = 53
		$Item.position = Vector2(0, 106)
		$Item.scale = Vector2(1.65, 1.65)
		
	if item_name == "Blister Grenade":
		$Item.frame = 59
		$Item.position = Vector2(2, 97)
		$Item.scale = Vector2(1.65, 1.65)

	if item_name == "Power Drill":
		$Item.frame = 62
		$Item.position = Vector2(5, 113)
		$Item.scale = Vector2(1.6, 1.6)

	if item_name == "Faulty Amp":
		$Item.frame = 61
		$Item.position = Vector2(3, 116)
		$Item.scale = Vector2(1.65, 1.65)

	if item_name == "Chilly Globe":
		$Item.frame = 60
		$Item.position = Vector2(-4, 111)
		$Item.scale = Vector2(1.5, 1.5)


