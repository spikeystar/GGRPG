extends Node2D

onready var player_instance = PlayerManager.player_instance
var save_path = "user://save.dat"
var save_name : int

func _ready():
	player_instance.queue_free()
	
func save_file():
	var data = {
		"party_members" : PartyStats.party_members,
		"party_level" : PartyStats.party_level,
	}
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "samantha")
	if error == OK:
		file.store_var(save_name)
		file.close()
		
func load_file():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "P#ableDH")
		if error == OK:
			var player_data = file.get_var(save_name)
			file.close()
			PartyStats.party_members = player_data["party_members"]
			PartyStats.party_level = player_data["party_level"]
	
func _input(event):
	var file_name : String = $SaveSelection/MenuCursor.menu_name
	
	if Input.is_action_just_pressed("ui_left"):
		PartyStats.party_members += 1
	
	if Input.is_action_just_pressed("ui_right"):
		print(PartyStats.party_members)
		
	if Input.is_action_just_pressed("ui_accept"):
		SE.effect("Select")
		load_file()
		print(PartyStats.party_members)
	
	if Input.is_action_just_pressed("ui_select") and file_name == "1":
		SE.effect("Select")
		save_name = 1
		save1_update()
		save_file()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "2":
		SE.effect("Select")
		save2_update()
		
	if Input.is_action_just_pressed("ui_select") and file_name == "3":
		SE.effect("Select")
		save3_update()
		
func save1_update():
	$Save1/Location.text = "Gary's House"
	$Save1/Level_info.text = str(PartyStats.party_level)
	$Save1/Initial.hide()
	$Save1/Display.show()
	if PartyStats.gary_id == 1:
		$Save1/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save1/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save1/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save1/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save1/Display.frame = 4
	if EventManager.jewel_seeds == 1:
		$Save1/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
		$Save1/Seed6.show()
	if EventManager.jewel_seeds == 7:
		$Save1/Seed1.show()
		$Save1/Seed2.show()
		$Save1/Seed3.show()
		$Save1/Seed4.show()
		$Save1/Seed5.show()
		$Save1/Seed6.show()
		$Save1/Seed7.show()
		
func save2_update():
	$Save2/Location.text = "Gary's House"
	$Save2/Level_info.text = str(PartyStats.party_level)
	$Save2/Initial.hide()
	$Save2/Display.show()
	if PartyStats.gary_id == 1:
		$Save2/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save2/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save2/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save2/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save2/Display.frame = 4
	if EventManager.jewel_seeds == 1:
		$Save2/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
		$Save2/Seed6.show()
	if EventManager.jewel_seeds == 7:
		$Save2/Seed1.show()
		$Save2/Seed2.show()
		$Save2/Seed3.show()
		$Save2/Seed4.show()
		$Save2/Seed5.show()
		$Save2/Seed6.show()
		$Save2/Seed7.show()
	
func save3_update():
	$Save3/Location.text = "Gary's House"
	$Save3/Level_info.text = str(PartyStats.party_level)
	$Save3/Initial.hide()
	$Save3/Display.show()
	if PartyStats.gary_id == 1:
		$Save3/Display.frame = 0
	if PartyStats.jacques_id == 1:
		$Save3/Display.frame = 1
	if PartyStats.irina_id == 1:
		$Save3/Display.frame = 2
	if PartyStats.suzy_id == 1:
		$Save3/Display.frame = 3
	if PartyStats.damien_id == 1:
		$Save3/Display.frame = 4
	if EventManager.jewel_seeds == 1:
		$Save3/Seed1.show()
	if EventManager.jewel_seeds == 2:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
	if EventManager.jewel_seeds == 3:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
	if EventManager.jewel_seeds == 4:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
	if EventManager.jewel_seeds == 5:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
	if EventManager.jewel_seeds == 6:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
		$Save3/Seed6.show()
	if EventManager.jewel_seeds == 7:
		$Save3/Seed1.show()
		$Save3/Seed2.show()
		$Save3/Seed3.show()
		$Save3/Seed4.show()
		$Save3/Seed5.show()
		$Save3/Seed6.show()
		$Save3/Seed7.show()
